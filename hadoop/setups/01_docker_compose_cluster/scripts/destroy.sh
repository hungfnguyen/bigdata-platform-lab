#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

if [[ "${CONFIRM:-}" != "DELETE_HADOOP_DATA" ]]; then
  echo "Refusing to delete Hadoop volumes." >&2
  echo "Run with CONFIRM=DELETE_HADOOP_DATA after checking the target project." >&2
  exit 1
fi

"${COMPOSE[@]}" --profile yarn --profile tools down --volumes --remove-orphans
echo "Removed Hadoop containers, network, and persistent volumes."
