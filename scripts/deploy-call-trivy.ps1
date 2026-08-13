<#
Deploy `call-trivy.yml` to multiple repositories using the `gh` CLI.

Usage:
  .\deploy-call-trivy.ps1 -ReposFile repos.txt -CallerFile ..\examples\call-trivy-workflow.yml

`repos.txt` should contain one repository full name per line, e.g.:
  myorg/repo-one
  myorg/repo-two

Requires: `gh` CLI authenticated and `git` available.
#>

param(
  [Parameter(Mandatory=$true)]
  [string]$ReposFile,

  [Parameter(Mandatory=$true)]
  [string]$CallerFile
)

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Error "gh CLI not found. Install and authenticate with 'gh auth login'."
  exit 1
}

$repos = Get-Content -Path $ReposFile | Where-Object { $_ -and $_ -notmatch '^#' }

foreach ($r in $repos) {
  $rtrim = $r.Trim()
  Write-Host "Processing $rtrim"
  $name = $rtrim.Split('/')[-1]
  $tmp = Join-Path -Path $env:TEMP -ChildPath ("deploy_$name")
  if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }
  gh repo clone $rtrim $tmp
  if ($LASTEXITCODE -ne 0) { Write-Warning "Clone failed for $rtrim"; continue }

  $workflowsDir = Join-Path $tmp ".github\workflows"
  New-Item -ItemType Directory -Path $workflowsDir -Force | Out-Null
  Copy-Item -Path $CallerFile -Destination (Join-Path $workflowsDir 'call-trivy.yml') -Force

  Push-Location $tmp
  git add .github/workflows/call-trivy.yml
  git commit -m "Add org Trivy reusable workflow caller" -q
  if ($LASTEXITCODE -eq 0) {
    git push origin HEAD
    Write-Host "Pushed call-trivy.yml to $rtrim"
  } else {
    Write-Host "No changes to commit for $rtrim"
  }
  Pop-Location
  Remove-Item -Recurse -Force $tmp
}
