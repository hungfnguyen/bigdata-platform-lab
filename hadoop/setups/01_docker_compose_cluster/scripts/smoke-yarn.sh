#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

wait_for_yarn_nodes 3 >/dev/null

client_run bash -euo pipefail -c '
  input=/labs/hdfs-smoke/input
  output=/labs/yarn-smoke/output
  examples_jar="$(find "${HADOOP_HOME}/share/hadoop/mapreduce" \
    -maxdepth 1 -name "hadoop-mapreduce-examples-*.jar" -print -quit)"

  if [[ -z "${examples_jar}" ]]; then
    echo "MapReduce examples JAR was not found." >&2
    exit 1
  fi

  hdfs dfs -test -e "${input}/wordcount.txt"
  hdfs dfs -rm -r -f "${output}" >/dev/null 2>&1 || true
  hadoop jar "${examples_jar}" wordcount "${input}" "${output}"

  expected=$'"'"'hadoop\t2\nhdfs\t1\nspark\t2\nyarn\t1'"'"'
  actual="$(hdfs dfs -cat "${output}/part-r-00000")"
  if [[ "${actual}" != "${expected}" ]]; then
    echo "Unexpected WordCount output:" >&2
    printf "%s\n" "${actual}" >&2
    exit 1
  fi

  echo "WordCount output:"
  printf "%s\n" "${actual}"
'

nodes="$(client_run yarn node -list -states RUNNING)"
grep -Eq "Total Nodes:[[:space:]]*3" <<<"${nodes}"

echo
echo "YARN smoke test passed with three NodeManagers."
