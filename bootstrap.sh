#!/usr/bin/env bash

set -eou pipefail

if [ -z "$DATABASE_URL" ]; then
  echo "missing \$DATABASE_URL"
  exit 1
fi

if [ -z "$PORT" ]; then
  echo "missing \$PORT"
fi

PRE=$(echo $DATABASE_URL | cut -d@ -f1)
POS=$(echo $DATABASE_URL | cut -d@ -f2)

export MF_METADATA_DB_USER=$(echo $PRE | cut -d/ -f3 | cut -d: -f1)
export MF_METADATA_DB_PSWD=$(echo $PRE | cut -d: -f3)

export MF_METADATA_DB_HOST=$(echo $POS | cut -d: -f1)
export MF_METADATA_DB_PORT=$(echo $POS | cut -d: -f2 | cut -d/ -f1)

export MF_METADATA_DB_NAME=$(echo $POS | cut -d/ -f2)

export MF_METADATA_PORT=$PORT

metadata_service