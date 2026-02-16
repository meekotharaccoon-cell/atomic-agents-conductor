#!/usr/bin/env bash
# Simple conductor dispatch helper
# Usage: set CONDUCTOR_TOKEN or export GH_TOKEN; edit TARGETS or pass payload as arg

set -euo pipefail

# Targets to dispatch to (owner/repo)
TARGETS=(
  "meekotharaccoon-cell/atomic-agents"
  "meekotharaccoon-cell/atomic-agents-staging"
  "meekotharaccoon-cell/atomic-agents-demo"
)

PAYLOAD=${1:-"{\"message\":\"manual-dispatch\"}"}

if [ -z "${CONDUCTOR_TOKEN:-}" ]; then
  echo "CONDUCTOR_TOKEN not set; will attempt to use GH CLI auth if available"
fi

for repo in "${TARGETS[@]}"; do
  echo "Dispatching to $repo"
  if [ -n "${CONDUCTOR_TOKEN:-}" ]; then
    curl -s -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer ${CONDUCTOR_TOKEN}" \
      https://api.github.com/repos/${repo}/dispatches \
      -d "{\"event_type\":\"conductor_dispatch\",\"client_payload\":${PAYLOAD}}"
  else
    gh api repos/${repo}/dispatches -X POST -f event_type=conductor_dispatch -F client_payload="${PAYLOAD}"
  fi
done

echo "Dispatch complete"
