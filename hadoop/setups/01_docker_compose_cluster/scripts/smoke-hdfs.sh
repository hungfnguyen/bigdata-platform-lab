#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

wait_for_hdfs_nodes 3 0 >/dev/null

client_run bash -euo pipefail -c '
  lab_path=/labs/hdfs-smoke
  fixture=/opt/hadoop-lab/fixtures/wordcount.txt

  hdfs dfsadmin -safemode wait
  hdfs dfs -rm -r -f "${lab_path}" >/dev/null 2>&1 || true
  hdfs dfs -mkdir -p "${lab_path}/input"
  hdfs dfs -put "${fixture}" "${lab_path}/input/wordcount.txt"
  hdfs dfs -setrep -w 3 "${lab_path}/input/wordcount.txt" >/dev/null

  expected="$(cat "${fixture}")"
  actual="$(hdfs dfs -cat "${lab_path}/input/wordcount.txt")"
  if [[ "${actual}" != "${expected}" ]]; then
    echo "HDFS content does not match the fixture." >&2
    exit 1
  fi

  echo "HDFS checksum:"
  hdfs dfs -checksum "${lab_path}/input/wordcount.txt"
  echo
  echo "HDFS block placement:"
  hdfs fsck "${lab_path}/input/wordcount.txt" -files -blocks -locations
'

report="$(client_run hdfs dfsadmin -report)"
grep -q "Live datanodes (3)" <<<"${report}"

echo
echo "HDFS smoke test passed with three live DataNodes and three replicas."
