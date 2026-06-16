#!/usr/bin/env bash

set -uo pipefail

restic backup \
  --exclude-caches \
  --exclude-file /etc/restic/exclude-file.txt \
  /storage

restic forget \
  --keep-daily 7 \
  --keep-weekly 8 \
  --keep-monthly 12 \
  --keep-yearly 2 \
  --prune
