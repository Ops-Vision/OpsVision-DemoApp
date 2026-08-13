# Org template: reusable Trivy workflow

This folder is a prepared layout you can copy into a central organization repo (for example `org-actions` or `.github`) and tag (for example `v1`).

Usage
- Commit the `.github/workflows/trivy-scan-reusable.yml` into the root of your template repo and create a tag (for example `v1`).
- Other repositories can call the workflow like this:

```
jobs:
  trivy:
    uses: <ORG>/<TEMPLATE_REPO>/.github/workflows/trivy-scan-reusable.yml@v1
    with:
      path: '.'
```

Security
- Reusable workflows run with the permissions of the caller repository; ensure org policies allow required actions.
