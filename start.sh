#!/bin/bash

set -eu

echo "=> Ensure directories"
mkdir -p /app/data /app/data/pipelines

echo "=> Loading configuration"
export PIPELINES_DIR=/app/data/pipelines
export PIPELINES_API_KEY=admin

[[ ! -f /app/data/env.sh ]] && cp /app/pkg/env.sh.template /app/data/env.sh

# Overrides
source /app/data/env.sh

echo "=> Setting permissions"
chown -R cloudron:cloudron /app/data

echo "=> Starting Pipelines"
exec gosu cloudron:cloudron bash /app/code/pipelines/start.sh