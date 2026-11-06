#!/usr/bin/env bash
# Network File Manager — One-Click Docker Launcher (Linux & macOS)
# Zero dependencies needed on your machine (no Python, pip, or virtualenv) — only Docker!

set -e
cd "$(dirname "$0")"

echo "=================================================="
echo "    Network File Manager — Docker Quickstart"
echo "=================================================="

# Check if Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "[-] Error: Docker is not installed on this machine."
    echo "    Please install Docker Desktop or Docker Engine:"
    echo "    - Linux: https://docs.docker.com/desktop/setup/install/linux/"
    echo "    - macOS: https://docs.docker.com/desktop/setup/install/mac-install/"
    exit 1
fi

# Ensure data directory exists with write permissions
mkdir -p data
chmod 777 data 2>/dev/null || true

# Check if docker daemon is running
if ! docker info >/dev/null 2>&1; then
    echo "[-] Error: Cannot connect to Docker daemon."
    echo "    Please ensure Docker is running (e.g. open Docker Desktop)."
    exit 1
fi

echo "[*] Building and starting Network File Manager in Docker..."

# Try docker compose (v2) or docker-compose (v1) or direct docker run
if docker compose version >/dev/null 2>&1; then
    docker compose up -d --build
elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose up -d --build
else
    echo "[*] Using docker build & docker run..."
    docker build -t netmanager:latest .
    docker stop netmanager 2>/dev/null || true
    docker rm netmanager 2>/dev/null || true
    docker run -d --name netmanager --restart unless-stopped -p 8080:8080 -v "$(pwd)/data:/data" netmanager:latest
fi

echo ""
echo "=================================================="
echo "[+] Network File Manager is running successfully!"
echo "=================================================="
echo "  Local Web UI:   http://localhost:8080"
echo "  Files stored in: $(pwd)/data"
echo "  Stop server:    docker compose down"
echo "=================================================="
