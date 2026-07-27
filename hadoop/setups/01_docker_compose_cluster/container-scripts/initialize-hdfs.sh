#!/usr/bin/env bash
set -euo pipefail

for attempt in $(seq 1 30); do
  report="$(hdfs dfsadmin -report 2>/dev/null || true)"
  if grep -q "Live datanodes (3)" <<<"${report}"; then
    break
  fi

  if [[ "${attempt}" -eq 30 ]]; then
    echo "Timed out waiting for three live DataNodes." >&2
    exit 1
  fi

  sleep 2
done

hdfs dfsadmin -safemode wait
hdfs dfs -mkdir -p /tmp /user/hadoop /mr-history/tmp /mr-history/done
hdfs dfs -chmod 1777 /tmp /mr-history/tmp /mr-history/done

echo "Initialized HDFS directories required by YARN and JobHistory Server."
