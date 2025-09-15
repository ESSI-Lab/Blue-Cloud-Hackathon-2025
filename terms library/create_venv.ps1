param(
  [string]$Python = "python",
  [string]$Requirements = "requirments.txt"
)

$ErrorActionPreference = "Stop"

Write-Host "==> Creating virtual environment in .venv (PowerShell)"
if (-not (Test-Path ".venv/Scripts/python.exe")) {
  & $Python -m venv .venv
} else {
  Write-Host ".venv already exists — skipping creation"
}

if (-not (Test-Path ".venv/Scripts/python.exe")) {
  Write-Error "Failed to create virtual environment. Ensure Python is installed and on PATH."
}

$VenvPython = ".venv/Scripts/python.exe"
Write-Host "==> Upgrading pip"
& $VenvPython -m pip install --upgrade pip

if (Test-Path $Requirements) {
  Write-Host "==> Installing dependencies from $Requirements"
  & $VenvPython -m pip install -r $Requirements
} else {
  Write-Host "No $Requirements found; skipping dependency installation"
}

Write-Host ""
Write-Host "Done. To activate the environment in the current shell, run:"
Write-Host "  .\\.venv\\Scripts\\Activate.ps1"
Write-Host "Then run your scripts with:"
Write-Host "  python test.py"