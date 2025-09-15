#!/usr/bin/env bash
set -euo pipefail

PY=${PYTHON:-python3}
if ! command -v "$PY" >/dev/null 2>&1; then
  PY=python
fi

echo "==> Creating virtual environment in .venv (POSIX)"
if [ ! -x ".venv/bin/python" ]; then
  "$PY" -m venv .venv
else
  echo ".venv already exists — skipping creation"
fi

if [ ! -x ".venv/bin/python" ]; then
  echo "Failed to create virtual environment. Ensure Python is installed and on PATH." >&2
  exit 1
fi

# shellcheck source=/dev/null
source .venv/bin/activate

echo "==> Upgrading pip"
python -m pip install --upgrade pip

if [ -f "requirments.txt" ]; then
  echo "==> Installing dependencies from requirments.txt"
  pip install -r "requirments.txt"
else
  echo "No requirments.txt found; skipping dependency installation"
fi

echo ""
echo "Done. The environment is active in this shell. To activate later, run:"
echo "  source .venv/bin/activate"
echo "Then run your scripts with:"
echo "  python test.py"