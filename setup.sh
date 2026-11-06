#!/usr/bin/env bash
# Network File Manager — Setup & Launcher Script
# Compatible with Linux and macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================"
echo "    Network File Manager Setup"
echo "========================================"

# 1. Detect Python 3
PYTHON_BIN=""
for cmd in python3 python; do
    if command -v "$cmd" >/dev/null 2>&1; then
        if "$cmd" -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)" 2>/dev/null; then
            PYTHON_BIN="$cmd"
            break
        fi
    fi
done

if [ -z "$PYTHON_BIN" ]; then
    echo "[-] Error: Python 3.8 or newer was not found."
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
    cp .env.example .env
    # Generate random SECRET_KEY
    RANDOM_SECRET=$("$PYTHON_BIN" -c "import secrets; print(secrets.token_hex(24))" 2>/dev/null || date +%s | sha256sum | head -c 48)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/change-me-to-a-long-random-string/$RANDOM_SECRET/" .env
    else
        sed -i "s/change-me-to-a-long-random-string/$RANDOM_SECRET/" .env
    fi
    echo "[+] Created .env with generated SECRET_KEY."
fi

# 3. Virtual environment setup
VENV_DIR="$SCRIPT_DIR/.venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "[*] Creating virtual environment at $VENV_DIR..."
    if ! "$PYTHON_BIN" -m venv --system-site-packages "$VENV_DIR" 2>/dev/null; then
        echo "[-] Warning: Failed to create virtual environment with --system-site-packages, trying standard venv..."
        if ! "$PYTHON_BIN" -m venv "$VENV_DIR" 2>/dev/null; then
            echo "[-] Error: Failed to create virtual environment."
            echo "    On Debian/Ubuntu systems, install the python3-venv package:"
            echo "    sudo apt install -y python3-venv"
            exit 1
        fi
    fi
fi

# 4. Activate virtual environment
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

# 5. Install dependencies
echo "[*] Checking and installing requirements..."
if ! pip install --upgrade pip --quiet 2>/dev/null; then
    echo "[-] Note: Could not upgrade pip (possibly offline or sandboxed). Continuing..."
fi

if ! pip install -r requirements.txt --quiet; then
    echo "[-] Warning: pip install failed. Checking if Flask is already available..."
    if python -c "import flask" 2>/dev/null; then
        echo "[+] Flask is available in environment. Continuing..."
    else
        echo "[-] Error: Required dependencies could not be installed and are not in environment."
        echo "    Please verify internet connection and run: pip install -r requirements.txt"
        exit 1
    fi
else
    echo "[+] Dependencies are up to date."
fi

# 7. Check if user passed --setup-only
if [ "$1" = "--setup-only" ]; then
    echo "[+] Setup complete! To start the server run: ./setup.sh"
    exit 0
fi

# 8. Start netmanager
chmod +x netmanager
echo "========================================"
echo "[+] Starting Network File Manager..."
echo "========================================"
exec python "$SCRIPT_DIR/netmanager" "$@"
