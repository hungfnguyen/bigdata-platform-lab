#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
COMPOSE=(
  docker compose
  --project-directory "${LAB_DIR}"
  --file "${LAB_DIR}/compose.yaml"
)

client_run() {
  "${COMPOSE[@]}" --profile tools run --rm --no-deps -T client "$@"
}

wait_for_hdfs_nodes() {
  local expected_live="$1"
  local expected_dead="$2"
  local timeout_attempts="${3:-30}"
  local report=""

  for ((attempt = 1; attempt <= timeout_attempts; attempt++)); do
    report="$(client_run hdfs dfsadmin -report 2>/dev/null || true)"
    dead_count_matches=false
    if [[ "${expected_dead}" -eq 0 ]]; then
      if ! grep -Eq "Dead datanodes \\([1-9][0-9]*\\)" <<<"${report}"; then
        dead_count_matches=true
      fi
    elif grep -q "Dead datanodes (${expected_dead})" <<<"${report}"; then
      dead_count_matches=true
    fi

    if grep -q "Live datanodes (${expected_live})" <<<"${report}" \
      && [[ "${dead_count_matches}" == "true" ]]; then
      printf '%s\n' "${report}"
      return 0
    fi
    sleep 2
  done

  printf '%s\n' "${report}" >&2
  echo "Timed out waiting for ${expected_live} live and ${expected_dead} dead DataNodes." >&2
  return 1
}

wait_for_yarn_nodes() {
  local expected_running="$1"
  local timeout_attempts="${2:-30}"
  local nodes=""

  for ((attempt = 1; attempt <= timeout_attempts; attempt++)); do
    nodes="$(client_run yarn node -list -states RUNNING 2>/dev/null || true)"
    if grep -Eq "Total Nodes:[[:space:]]*${expected_running}" <<<"${nodes}"; then
      printf '%s\n' "${nodes}"
      return 0
    fi
    sleep 2
  done

  printf '%s\n' "${nodes}" >&2
  echo "Timed out waiting for ${expected_running} YARN NodeManagers." >&2
  return 1
}
