#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

target=datanode-3
recovered=false

recover_target() {
  if [[ "${recovered}" == "false" ]]; then
    echo "Recovering ${target}..."
    "${COMPOSE[@]}" start "${target}" >/dev/null
  fi
}
trap recover_target EXIT

wait_for_hdfs_nodes 3 0 >/dev/null
client_run hdfs dfs -setrep -w 3 /labs/hdfs-smoke/input/wordcount.txt >/dev/null

echo "Stopping ${target}..."
"${COMPOSE[@]}" stop "${target}" >/dev/null

degraded_report="$(wait_for_hdfs_nodes 2 1 45)"
grep -q "Dead datanodes (1)" <<<"${degraded_report}"

echo "Cluster report while degraded:"
printf '%s\n' "${degraded_report}"

echo
echo "File-system check while one replica is unavailable:"
fsck_output=""
for _ in $(seq 1 20); do
  fsck_output="$(client_run hdfs fsck \
    /labs/hdfs-smoke/input/wordcount.txt -files -blocks -locations)"
  if grep -Eq "Under-replicated blocks:[[:space:]]+1" <<<"${fsck_output}"; then
    break
  fi
  sleep 2
done
printf '%s\n' "${fsck_output}"
grep -Eq "Under-replicated blocks:[[:space:]]+1" <<<"${fsck_output}"

echo
echo "Starting ${target}..."
"${COMPOSE[@]}" start "${target}" >/dev/null
wait_for_hdfs_nodes 3 0 45 >/dev/null
recovered=true

recovery_fsck=""
for _ in $(seq 1 20); do
  recovery_fsck="$(client_run hdfs fsck \
    /labs/hdfs-smoke/input/wordcount.txt -files -blocks -locations)"
  if grep -Eq "Under-replicated blocks:[[:space:]]+0" <<<"${recovery_fsck}"; then
    break
  fi
  sleep 2
done
printf '%s\n' "${recovery_fsck}"
grep -Eq "Under-replicated blocks:[[:space:]]+0" <<<"${recovery_fsck}"

echo
echo "DataNode failure drill passed and ${target} recovered."
