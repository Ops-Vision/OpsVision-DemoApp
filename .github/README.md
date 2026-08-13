# Trivy reusable workflow

This folder contains a reusable GitHub Actions workflow to run Trivy scans across repositories.

Usage
- To call the reusable workflow from the same repo, add `.github/workflows/call-trivy-local.yml` (already present).
- To call it from other repositories, use the example in `examples/call-trivy-workflow.yml` and replace `<ORG>/<TEMPLATE_REPO>` and the tag.

Recommended rollout
- Create a dedicated org repo (for example `org-actions` or `.github`) and add `.github/workflows/trivy-scan-reusable.yml` there.
- Tag releases (for example `v1`) and update calling repos to use the tag.
