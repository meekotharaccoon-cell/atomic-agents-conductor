# Atomic Agents — Conductor


This repository is the conductor for the Atomic Agents family. It documents the relationship between the runtime, staging, and demo repositories and provides orchestration helpers.

Repos:

- Main: https://github.com/meekotharaccoon-cell/atomic-agents
- Staging: https://github.com/meekotharaccoon-cell/atomic-agents-staging
- Demo: https://github.com/meekotharaccoon-cell/atomic-agents-demo

Usage

- The conductor contains a manual `workflow_dispatch` workflow that triggers a `repository_dispatch` event in each target repo. This lets maintainers run coordinated jobs across the family.

How to use

1. Create a repository secret named `CONDUCTOR_TOKEN` in the conductor repo containing a personal access token with `repo` scope.
2. Open the Actions tab for the conductor repo and run the "Cross-Repo Dispatch" workflow manually (or use the REST API).
3. The workflow will send a `conductor_dispatch` event with payload `{ message: <your input> }` to each target repo listed in the workflow (`TARGET_REPOS`).

Note: Target repositories must have workflows configured to listen for `repository_dispatch` (event_type `conductor_dispatch`) to respond.
