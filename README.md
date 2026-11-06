# Network File Manager

A modern, fast, lightweight, and self-hosted web-based file manager built with Python and Flask. Easily browse, upload, preview, edit, and share files across your local network or server with zero complex database setup.

---

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites & Downloads](#prerequisites--downloads)
- [Quick Start Guide](#quick-start-guide)
- [Setup Instructions by Operating System](#setup-instructions-by-operating-system)
  - [Linux (Ubuntu, Debian, Fedora, Arch)](#1-linux-ubuntudebianfedoraarch)
  - [macOS (Apple Silicon & Intel)](#2-macos-apple-silicon--intel)
  - [Windows (10 & 11)](#3-windows-10--11)
  - [Docker & Docker Compose (Cross-Platform)](#4-docker--docker-compose-any-os)
- [Configuration & Environment Variables](#configuration--environment-variables)
- [Connecting from Phones & LAN Devices](#connecting-from-phones--lan-devices)
- [Production & Reverse Proxy (Nginx / Caddy)](#production--reverse-proxy-nginx--caddy)
- [Troubleshooting & FAQ](#troubleshooting--faq)
- [License](#license)

---

## Features

- 📂 **Full File & Folder Management**: Browse directories with breadcrumb navigation, upload multiple files simultaneously, create new directories, and create new files.
- 🖼️ **Media & Document Previews**: Native in-browser viewer for:
  - **Images**: PNG, JPG, JPEG, GIF, WEBP, SVG, ICO, AVIF
  - **Videos**: MP4, WebM, MKV, MOV, OGV
  - **Audio**: MP3, WAV, OGG, M4A, FLAC, AAC
  - **Documents**: PDF viewer embedded directly in the page
- ✏️ **Built-in Text & Code Editor**: Edit code, text notes, Markdown, and configuration files directly in your web browser with save confirmation.
- 📦 **Instant ZIP Downloads**: Download any single file or compress and download entire directories (or the entire repository) as a `.zip` archive on the fly.
- 🔍 **Real-Time Instant Search**: Live filter input box to find files in the current folder instantly without reloading.
- 🌓 **Automatic Dark / Light Theme**: Clean, responsive modern UI that adapts automatically to your device's system appearance.
- 📱 **Mobile & Local Network Ready**: Displays local IP and port in the terminal upon startup so you can easily access files from smartphones, tablets, or other computers on your Wi-Fi network.
- 🔒 **Security First**:
  - Optional password protection (lock your server or leave open for trusted home LAN).
  - CSRF protection across all forms and API endpoints.
  - Path traversal and symlink escape defenses (restricts file operations strictly within the configured root directory).
  - Content Security Policy (CSP) protection for SVG rendering.
- ⚡ **Smart Port Conflict Detection**: Automatically selects the next available port if port 8080 is already in use.
- 🚀 **Production Ready**: Supports high-performance multi-threaded WSGI serving via [Waitress](https://docs.pylonsproject.org/projects/waitress/en/stable/) or containerized deployment with [Docker](https://www.docker.com/).

---

## Project Structure

```text
Server/
├── netmanager             # Main Python application (Flask + Waitress)
├── requirements.txt       # Python dependencies (Flask, Waitress)
├── setup.sh               # Automated setup & launcher for Linux / macOS
├── setup.bat              # Automated setup & launcher for Windows
├── Dockerfile             # Multi-stage production container image
├── docker-compose.yml     # Docker Compose orchestration configuration
├── .env.example           # Configuration template
├── .env                   # Local configuration (auto-generated, git-ignored)
├── .gitignore             # Git ignore patterns
├── .dockerignore          # Docker build ignore patterns
├── data/                  # Default storage directory for files
│   └── .gitkeep
└── README.md              # Project documentation
```

---

## Prerequisites & Downloads

Before installing, ensure you have Python 3.8+ (Python 3.10+ recommended) or Docker installed.

| Component | Minimum Version | Download & Documentation Links |
| :--- | :--- | :--- |
| **Python** | 3.8 or newer | • [Python Official Downloads (All OS)](https://www.python.org/downloads/)<br>• [Python for Windows (64-bit)](https://www.python.org/downloads/windows/)<br>• [Python for macOS](https://www.python.org/downloads/macos/)<br>• [Python Source / Linux](https://www.python.org/downloads/source/) |
| **Git** | 2.x+ | • [Git Downloads (All OS)](https://git-scm.com/downloads)<br>• [Git for Windows](https://git-scm.com/download/win)<br>• [Git for macOS](https://git-scm.com/download/mac)<br>• [Git for Linux](https://git-scm.com/download/linux) |
| **Pip** | Included with Python | • [Pip Installation Guide](https://pip.pypa.io/en/stable/installation/) |
| **Docker** *(Optional)* | 20.10+ | • [Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/)<br>• [Docker Desktop for Mac](https://docs.docker.com/desktop/setup/install/mac-install/)<br>• [Docker Desktop for Linux](https://docs.docker.com/desktop/setup/install/linux/)<br>• [Docker Engine on Linux](https://docs.docker.com/engine/install/) |
| **Docker Compose** *(Optional)* | 2.0+ | • [Docker Compose Installation](https://docs.docker.com/compose/install/) |

---

## Quick Start Guide

Run the automated setup script for your operating system:

- **Linux / macOS**:
  ```bash
  chmod +x setup.sh
  ./setup.sh
  ```
- **Windows**:
  Double-click `setup.bat` or run:
  ```cmd
  setup.bat
  ```
- **Docker**:
  ```bash
  docker compose up -d
  ```

Once started, open [http://localhost:8080](http://localhost:8080) in your web browser.

---

## Setup Instructions by Operating System

### 1. Linux (Ubuntu/Debian/Fedora/Arch)

#### Option A: Automated Setup (Recommended)
1. Open a terminal in the project directory:
   ```bash
   cd /path/to/Server
   ```
2. Make `setup.sh` executable and run it:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   The script will automatically:
   - Check your Python version.
   - Create a Python virtual environment (`.venv`).
   - Install required dependencies (`Flask`, `Waitress`).
   - Create `.env` from `.env.example` with a cryptographically secure `SECRET_KEY`.
   - Ensure the `./data` directory exists.
   - Launch the server.

#### Option B: Manual Setup
1. **Install Python and Pip**:
   - **Ubuntu / Debian / Linux Mint**:
     ```bash
     sudo apt update
     sudo apt install -y python3 python3-venv python3-pip git
     ```
   - **Fedora / RHEL / CentOS**:
     ```bash
     sudo dnf install -y python3 python3-pip git
     ```
   - **Arch Linux / Manjaro**:
     ```bash
     sudo pacman -S python python-pip git
     ```
   - **openSUSE**:
     ```bash
     sudo zypper install python3 python3-pip git
     ```

2. **Create and Activate Virtual Environment**:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. **Install Dependencies**:
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. **Initialize Environment Configuration**:
   ```bash
   cp .env.example .env
   ```

5. **Start the Server**:
   ```bash
   python3 netmanager
   ```

#### Running as a Background Systemd Service (Linux)
To run Network File Manager permanently in the background and auto-start on boot:

1. Create a systemd service file:
   ```bash
   sudo nano /etc/systemd/system/netmanager.service
   ```
2. Paste the following configuration (replace `/home/sam/Projects/Server` and `sam` with your actual path and user):
   ```ini
   [Unit]
   Description=Network File Manager
   After=network.target

   [Service]
   Type=simple
   User=sam
   WorkingDirectory=/home/sam/Projects/Server
   ExecStart=/home/sam/Projects/Server/.venv/bin/python /home/sam/Projects/Server/netmanager
   Restart=always
   RestartSec=5
   Environment=PYTHONUNBUFFERED=1

   [Install]
   WantedBy=multi-user.target
   ```
3. Enable and start the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now netmanager
   ```
4. Check status:
   ```bash
   sudo systemctl status netmanager
   ```

---

### 2. macOS (Apple Silicon & Intel)

#### Option A: Automated Setup (Recommended)
1. Open the **Terminal** app (`Applications > Utilities > Terminal` or press `Cmd + Space` and type `Terminal`).
2. Navigate to the project directory:
   ```bash
   cd /path/to/Server
   ```
3. Make `setup.sh` executable and run it:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

#### Option B: Manual Setup
1. **Install Prerequisites using Homebrew**:
   If you don't have [Homebrew](https://brew.sh/) installed, install it:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
   Then install Python and Git:
   ```bash
   brew install python git
   ```

2. **Create and Activate Virtual Environment**:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. **Install Dependencies**:
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. **Initialize Environment Configuration**:
   ```bash
   cp .env.example .env
   ```

5. **Start the Server**:
   ```bash
   python3 netmanager
   ```

---

### 3. Windows (10 & 11)

#### Prerequisites
1. Download Python 3.10+ from [python.org/downloads/windows](https://www.python.org/downloads/windows/) or install via Windows Terminal / PowerShell:
   ```powershell
   winget install Python.Python.3.12 Git.Git
   ```
   > [!IMPORTANT]
   > When installing Python using the GUI installer, check the box: **"Add python.exe to PATH"** at the bottom of the first setup screen!

#### Option A: Automated Setup (Recommended)
1. Open File Explorer, navigate to the `Server` folder, and **double-click `setup.bat`**.
2. Or open **Command Prompt** / **PowerShell** and run:
   ```cmd
   setup.bat
   ```
   The batch script will automatically configure the virtual environment, install packages, create `.env`, and launch the server.

#### Option B: Manual Setup with Command Prompt (`cmd.exe`)
1. Open Command Prompt and navigate to the project directory:
   ```cmd
   cd C:\path\to\Server
   ```
2. Create and activate a virtual environment:
   ```cmd
   python -m venv .venv
   call .venv\Scripts\activate.bat
   ```
3. Install dependencies:
   ```cmd
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```
4. Copy the configuration template:
   ```cmd
   copy .env.example .env
   ```
5. Start the server:
   ```cmd
   python netmanager
   ```

#### Option C: Manual Setup with PowerShell
1. Open PowerShell and navigate to the project directory:
   ```powershell
   cd C:\path\to\Server
   ```
2. (If running scripts is restricted on your machine, enable process execution):
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
3. Create and activate a virtual environment:
   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```
4. Install dependencies:
   ```powershell
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```
5. Copy configuration template:
   ```powershell
   Copy-Item .env.example .env
   ```
6. Start the server:
   ```powershell
   python netmanager
   ```

#### Option D: Using Windows Subsystem for Linux (WSL)
If you prefer running inside Linux on Windows:
1. Ensure WSL is enabled ([WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)):
   ```powershell
   wsl --install
   ```
2. Open your WSL distribution terminal (e.g., Ubuntu).
3. Follow the [Linux Setup Instructions](#1-linux-ubuntudebianfedoraarch).

---

### 4. Docker & Docker Compose (Any OS)

Docker provides an isolated, zero-dependency environment that runs identically on Linux, macOS, and Windows.

#### Prerequisites
- Install [Docker Desktop](https://docs.docker.com/get-docker/) or [Docker Engine](https://docs.docker.com/engine/install/).

#### Using Docker Compose (Recommended)
1. Copy the configuration file:
   ```bash
   cp .env.example .env
   ```
2. Build and start the container in detached mode:
   ```bash
   docker compose up -d
   ```
3. Check the logs:
   ```bash
   docker compose logs -f
   ```
4. Stop the container:
   ```bash
   docker compose down
   ```

#### Using Docker CLI Directly
```bash
# Build the Docker image
docker build -t netmanager:latest .

# Run container with volume mounted to ./data
docker run -d \
  --name netmanager \
  --restart unless-stopped \
  -p 8080:8080 \
  -v "$(pwd)/data:/data" \
  netmanager:latest
```

---

## Configuration & Environment Variables

Configuration is handled through environment variables, which can be defined in your `.env` file or passed via shell / Docker.

### Variables Reference

| Variable | Default Value | Description |
| :--- | :--- | :--- |
| `SECRET_KEY` | Random generated string | Flask session signing key. Set a long random string for production to keep user sessions persistent across restarts. |
| `NETMANAGER_PASSWORD` | *(empty / none)* | Server login password. If set, prompts users to authenticate before viewing or modifying files. Leave empty for open access on trusted LAN. |
| `NETMANAGER_PORT` | `8080` | Port on which the application listens. |
| `NETMANAGER_DATA_DIR` | `./data` | File system directory served by the manager when running directly on the host machine. |
| `HOST_PORT` | `8080` | Host port exposed when running via Docker Compose. |
| `HOST_DATA_DIR` | `./data` | Host directory mounted into container `/data` when running via Docker Compose. |

### Command Line Arguments
You can also override the port and password directly on the command line:
```bash
# Format: python netmanager [PORT] [PASSWORD]
python3 netmanager 9000 mysecretpassword
```

---

## Connecting from Phones & LAN Devices

When Network File Manager starts, it prints your local IP address:

```text
File Manager running
Directory: /home/sam/Projects/Server/data
Security: PASSWORD PROTECTED
Local:   http://localhost:8080
Network: http://192.168.1.150:8080
```

To connect from another device (iPhone, Android, tablet, or another computer on the same Wi-Fi network):
1. Make sure both devices are connected to the same Wi-Fi or router network.
2. Open a web browser on your phone/device.
3. Enter the **Network** address shown in your console (e.g., `http://192.168.1.150:8080`).

### How to Find Your Local IP Manually
- **Linux**:
  ```bash
  ip -brief address
  # or
  hostname -I
  ```
- **macOS**:
  ```bash
  ipconfig getifaddr en0   # Wi-Fi
  # or
  ipconfig getifaddr en1   # Ethernet
  ```
- **Windows**:
  ```cmd
  ipconfig
  ```
  Look for the `IPv4 Address` under your active Wi-Fi or Ethernet adapter (usually `192.168.x.x` or `10.x.x.x`).

---

## Production & Reverse Proxy (Nginx / Caddy)

For public internet exposure, always configure SSL/TLS encryption using a reverse proxy.

### Nginx Configuration
```nginx
server {
    listen 80;
    server_name files.yourdomain.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name files.yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/files.yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/files.yourdomain.com/privkey.pem;

    # Allow large file uploads
    client_max_body_size 10G;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Disable buffering for fast streaming/uploads
        proxy_buffering off;
        proxy_request_buffering off;
    }
}
```

### Caddy Configuration (`Caddyfile`)
```caddy
files.yourdomain.com {
    reverse_proxy 127.0.0.1:8080 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
    }
}
```

---

## Troubleshooting & FAQ

### 1. Port is already in use (`Address already in use`)
Network File Manager includes automatic port failover: if port `8080` is busy, it automatically scans and binds to the next free port (`8081`, `8082`, etc.). You can also specify an exact port:
```bash
python3 netmanager 8888
```

### 2. Cannot connect from mobile phone or other computers
- Ensure both devices are connected to the same Wi-Fi / Local Area Network.
- Check your host firewall settings:
  - **Linux (UFW)**:
    ```bash
    sudo ufw allow 8080/tcp
    ```
  - **Windows**:
    Open Windows Defender Firewall > Allow an app or feature through Windows Defender Firewall > ensure Python is allowed for Private networks.
  - **macOS**:
    Go to `System Settings > Network > Firewall` and ensure Python is permitted to receive incoming connections.

### 3. Windows PowerShell script execution error
If you receive `File ... cannot be loaded because running scripts is disabled on this system`:
Run PowerShell as Administrator or allow process-level execution:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### 4. Permission denied when creating folders or uploading files
Ensure the user running the process has write permissions on the data directory:
```bash
# Linux / macOS
chmod -R u+rwX data/
```

### 5. Docker volume permission issues
If files written by Docker belong to `10001:10001` (the non-root `appuser`), adjust the host directory permissions:
```bash
sudo chown -R 10001:10001 data/
```

---

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to modify, distribute, and use it for personal or commercial projects.
