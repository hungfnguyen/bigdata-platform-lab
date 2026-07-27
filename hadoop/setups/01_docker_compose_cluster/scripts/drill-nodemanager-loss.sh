#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

target=nodemanager-3
launcher_pid=""
launcher_log="$(mktemp)"
target_stopped=false

cleanup() {
  if [[ "${target_stopped}" == "true" ]]; then
    echo "Recovering ${target}..."
    "${COMPOSE[@]}" --profile yarn up --detach --no-build --no-deps "${target}" >/dev/null || true
  fi
  if [[ -n "${launcher_pid}" ]] && kill -0 "${launcher_pid}" 2>/dev/null; then
    kill "${launcher_pid}" 2>/dev/null || true
  fi
  rm -f "${launcher_log}"
}
trap cleanup EXIT

wait_for_yarn_nodes 3 >/dev/null

echo "Submitting a retryable DistributedShell application..."
client_run bash -euo pipefail -c '
  jar="$(find "${HADOOP_HOME}/share/hadoop/yarn" -maxdepth 1 \
    -name "hadoop-yarn-applications-distributedshell-*.jar" -print -quit)"
  yarn jar "${jar}" \
    -jar "${jar}" \
    -appname nodemanager-loss-drill \
    -master_memory 256 \
    -master_vcores 1 \
    -container_memory 256 \
    -container_vcores 1 \
    -container_retry_policy 1 \
    -container_max_retries 2 \
    -keep_containers_across_application_attempts \
    -num_containers 6 \
    -shell_command sleep \
    -shell_args 60
' >"${launcher_log}" 2>&1 &
launcher_pid=$!

application_id=""
for _ in $(seq 1 30); do
  if ! kill -0 "${launcher_pid}" 2>/dev/null; then
    wait "${launcher_pid}" || true
    launcher_pid=""
    cat "${launcher_log}" >&2
    echo "DistributedShell launcher exited before the application reached RUNNING." >&2
    exit 1
  fi

  applications="$(client_run yarn application -list -appStates RUNNING 2>/dev/null || true)"
  application_id="$(awk '$0 ~ /nodemanager-loss-drill/ {print $1; exit}' <<<"${applications}")"
  if [[ -n "${application_id}" ]]; then
    break
  fi
  sleep 2
done

if [[ -z "${application_id}" ]]; then
  cat "${launcher_log}" >&2
  echo "DistributedShell application did not reach RUNNING state." >&2
  exit 1
fi

echo "Application ${application_id} is running."
client_run yarn application -status "${application_id}"

echo
echo "Killing ${target} while containers are active..."
"${COMPOSE[@]}" --profile yarn kill "${target}" >/dev/null
target_stopped=true

lost_nodes=""
for _ in $(seq 1 20); do
  lost_nodes="$(client_run yarn node -list -states LOST 2>/dev/null || true)"
  if grep -q "${target}" <<<"${lost_nodes}"; then
    break
  fi
  sleep 2
done

if ! grep -q "${target}" <<<"${lost_nodes}"; then
  printf '%s\n' "${lost_nodes}" >&2
  echo "${target} was not reported as LOST." >&2
  exit 1
fi

echo "ResourceManager report after node loss:"
printf '%s\n' "${lost_nodes}"
client_run yarn application -status "${application_id}"

echo
echo "Starting ${target}..."
"${COMPOSE[@]}" --profile yarn up --detach --no-build --no-deps "${target}" >/dev/null
wait_for_yarn_nodes 3 30 >/dev/null
target_stopped=false

if ! wait "${launcher_pid}"; then
  cat "${launcher_log}" >&2
  echo "DistributedShell application failed after NodeManager loss." >&2
  exit 1
fi
launcher_pid=""

final_status="$(client_run yarn application -status "${application_id}")"
printf '%s\n' "${final_status}"
grep -Eq "Final-State[[:space:]]*:[[:space:]]*SUCCEEDED" <<<"${final_status}"

echo
echo "NodeManager failure drill passed and ${target} recovered."
