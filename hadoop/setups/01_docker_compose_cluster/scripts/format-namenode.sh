#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

if "${COMPOSE[@]}" run --rm --no-deps -T namenode \
  test -f /var/lib/hadoop-hdfs/namenode/current/VERSION; then
  echo "NameNode metadata already exists; refusing to overwrite it."
  exit 0
fi

"${COMPOSE[@]}" run --rm --no-deps -T namenode \
  hdfs namenode -format -nonInteractive bigdata-platform-lab

echo "NameNode metadata initialized."
