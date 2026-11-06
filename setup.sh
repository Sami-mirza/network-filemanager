#!/usr/bin/env bash
# Network File Manager — Setup & Launcher Script
# Compatible with Linux and macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================"
echo "    Network File Manager Setup"
echo "========================================"

# 1. Detect supported Python
PYTHON_BIN=""
for cmd in python3 python; do
    if command -v "$cmd" >/dev/null 2>&1; then
        if "$cmd" -c "import sys; exit(0 if sys.version_info >= (3, 9) else 1)" 2>/dev/null; then
            PYTHON_BIN="$cmd"
            break
        fi
    fi
done

if [ -z "$PYTHON_BIN" ]; then
    echo "[-] Error: Python 3.9 or newer was not found."
    echo "    Please install Python 3:"
    echo "    - Debian/Ubuntu: sudo apt update && sudo apt install -y python3 python3-venv python3-pip"
    echo "    - Fedora/RHEL:   sudo dnf install -y python3 python3-pip"
    echo "    - Arch Linux:    sudo pacman -S python python-pip"
    echo "    - macOS:         brew install python"
    echo "    Or download from https://www.python.org/downloads/"
    exit 1
fi

echo "[+] Using Python: $($PYTHON_BIN --version) ($PYTHON_BIN)"

# 2. Ensure data directory and configuration exist
mkdir -p data

if [ ! -f .env ]; then
    echo "[*] Initializing .env configuration from .env.example..."
    if [ ! -f .env.example ]; then
        echo "[-] Error: .env.example is missing."
        exit 1
    fi
    cp .env.example .env
    "$PYTHON_BIN" -c 'from pathlib import Path; import secrets; p = Path(".env"); p.write_text(p.read_text().replace("change-me-to-a-long-random-string", secrets.token_hex(32)))'
    echo "[+] Created .env with generated SECRET_KEY."
fi

# 3. Virtual environment setup
VENV_DIR="$SCRIPT_DIR/.venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "[*] Creating virtual environment at $VENV_DIR..."
    if ! "$PYTHON_BIN" -m venv "$VENV_DIR"; then
        echo "[-] Error: Failed to create virtual environment."
        echo "    On Debian/Ubuntu systems, install the python3-venv package:"
        echo "    sudo apt install -y python3-venv"
        exit 1
    fi
fi

VENV_PYTHON="$VENV_DIR/bin/python"
if [ ! -x "$VENV_PYTHON" ]; then
    echo "[-] Error: The virtual environment is incomplete: $VENV_DIR"
    echo "    Remove that directory and run this setup script again."
    exit 1
fi

# 4. Install dependencies in the isolated virtual environment
echo "[*] Checking and installing requirements..."
if ! "$VENV_PYTHON" -m pip install -r requirements.txt; then
    echo "[-] Error: Could not install required dependencies."
    echo "    Check your internet connection, then run: $VENV_PYTHON -m pip install -r requirements.txt"
    exit 1
fi
echo "[+] Dependencies are up to date."

# 5. Check if user passed --setup-only
if [ "${1:-}" = "--setup-only" ]; then
    echo "[+] Setup complete! To start the server run: ./setup.sh"
    exit 0
fi

# 6. Start netmanager
echo "========================================"
echo "[+] Starting Network File Manager..."
echo "========================================"
exec "$VENV_PYTHON" "$SCRIPT_DIR/netmanager" "$@"
