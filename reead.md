<div align="center">

# 🌐 Network File Manager

**A modern, lightweight, self-hosted web-based file manager built with Python & Flask.**  
*Browse, upload, preview, edit, and share files across your local network with zero database setup.*

[![Python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/Flask-3.x-000000?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/)
[![WSGI Waitress](https://img.shields.io/badge/WSGI-Waitress_3.x-red?style=for-the-badge)](https://docs.pylonsproject.org/projects/waitress/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[![Platform Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://www.kernel.org/)
[![Platform macOS](https://img.shields.io/badge/macOS-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Platform Windows](https://img.shields.io/badge/Windows-0078D6?style=flat-square&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Docker Compose](https://img.shields.io/badge/Docker_Compose-Supported-2496ED?style=flat-square&logo=docker&logoColor=white)](https://docs.docker.com/compose/)

[Features](#-key-features) • [Prerequisites & Downloads](#-prerequisites--official-download-links) • [Quick Start](#-quick-start) • [OS Setup Guides](#-step-by-step-setup-guides-by-os) • [Docker](#-docker--docker-compose-any-os) • [Configuration](#-configuration--environment-variables) • [LAN Access](#-connecting-from-phones--lan-devices) • [Production & Reverse Proxy](#-production--reverse-proxy-guide) • [Troubleshooting](#-troubleshooting--faq)

</div>

---

## 📸 Overview & Web Interface Preview

```text
┌────────────────────────────────────────────────────────────────────────┐
│  🌐 File Manager                                      [ 🔒 Sign out ] │
├────────────────────────────────────────────────────────────────────────┤
│  Root / Documents / Photos                                             │
├────────────────────────────────────────────────────────────────────────┤
│  [ Choose Files ] [ Upload ]   [ Folder Name ] [ New folder ]  [ Filter ]│
├────────────────────────────────────────────────────────────────────────┤
│  NAME                     │ SIZE      │ MODIFIED         │ ACTIONS     │
├────────────────────────────────────────────────────────────────────────┤
│  📁 Projects              │ -         │ 2026-11-05 18:30 │ ZIP  Del    │
│  🖼️ sunset.jpg            │ 2.4 MB    │ 2026-11-05 18:22 │ Down Del    │
│  📝 notes.txt             │ 14.2 KB   │ 2026-11-05 17:45 │ Edit Del    │
│  🎥 holiday_video.mp4     │ 154.0 MB  │ 2026-11-04 12:10 │ Down Del    │
│  📄 invoice.pdf           │ 245.0 KB  │ 2026-11-03 09:15 │ Down Del    │
└────────────────────────────────────────────────────────────────────────┘
```

---

## ✨ Key Features

- 📂 **Complete File Operations**: Browse directories with breadcrumb navigation, upload multiple files simultaneously, create new directories, and create new text files.
- 🖼️ **Native Media & Document Previews**:
  - **Images**: PNG, JPG, JPEG, GIF, WEBP, SVG, ICO, AVIF
  - **Videos**: MP4, WebM, MKV, MOV, OGV (in-browser HTML5 player)
  - **Audio**: MP3, WAV, OGG, M4A, FLAC, AAC (in-browser audio player)
  - **Documents**: Embedded PDF viewer
- ✏️ **Integrated Code & Text Editor**: In-browser text editor for quick edits, notes, scripts, JSON, Markdown, and configuration files (up to 2 MB) with instant save.
- 📦 **One-Click ZIP Archives**: Download individual files or download any folder (or the root directory) as a compressed `.zip` archive on the fly.
- 🔍 **Instant Real-Time Search**: Search and filter files in real time without page refreshes.
- 🌓 **Adaptive Light / Dark Theme**: Clean UI styled to automatically match your system's light or dark mode.
- 📱 **Mobile & Local Network Ready**: Displays your LAN IP and port at startup so you can immediately browse and upload files from smartphones, tablets, or other computers on the same Wi-Fi.
- 🔒 **Security First**:
  - Optional password protection (lock the server or keep open for home networks).
  - CSRF protection across all forms and file mutations.
  - Strict directory traversal protection (blocks `../` and symlink escapes outside the configured data directory).
  - Content Security Policy (CSP) headers applied to inline SVG rendering.
- ⚡ **Auto Port Failover**: If port `8080` is in use, automatically selects the next free port.
- 🚀 **Production Ready**: High-performance multi-threaded WSGI via **Waitress** or containerized via **Docker**.

---

## 🗂️ Project Structure

```text
Server/
├── netmanager             # Core Python application (Flask + Waitress WSGI)
├── requirements.txt       # Python dependencies (flask, waitress)
├── setup.sh               # One-click setup & launcher for Linux / macOS
├── setup.bat              # One-click setup & launcher for Windows
├── Dockerfile             # Multi-stage production container image
├── docker-compose.yml     # Docker Compose orchestration file
├── .env.example           # Configuration environment template
├── .env                   # Local configuration (auto-generated, git-ignored)
├── .gitignore             # Git ignore patterns
├── .dockerignore          # Docker build ignore rules
├── data/                  # Default data directory served by the app
│   └── .gitkeep
├── README.md              # Main project documentation
└── reead.md               # Quick setup reference
```

---

## 📥 Prerequisites & Official Download Links

Before installing, make sure you have **Python 3.8+** (recommended: **Python 3.10+**) or **Docker** installed on your system.

| Tool | Recommended Version | Official Downloads & Guides |
| :--- | :--- | :--- |
| **Python** | `3.10` or newer | • [Python Official Downloads (All Operating Systems)](https://www.python.org/downloads/)<br>• [Python for Windows (Official 64-bit Installer)](https://www.python.org/downloads/windows/)<br>• [Python for macOS (Official Universal Installer)](https://www.python.org/downloads/macos/)<br>• [Python Source Code / Linux Releases](https://www.python.org/downloads/source/) |
| **Git** | `2.x` or newer | • [Git Downloads (All Platforms)](https://git-scm.com/downloads)<br>• [Git for Windows Installer](https://git-scm.com/download/win)<br>• [Git for macOS](https://git-scm.com/download/mac)<br>• [Git for Linux Distributions](https://git-scm.com/download/linux) |
| **Pip** | `22.x+` (Bundled) | • [Official Pip Installation Documentation](https://pip.pypa.io/en/stable/installation/) |
| **Docker Desktop** *(Optional)* | Latest | • [Docker Desktop for Windows (with WSL2)](https://docs.docker.com/desktop/setup/install/windows-install/)<br>• [Docker Desktop for Mac (Apple Silicon & Intel)](https://docs.docker.com/desktop/setup/install/mac-install/)<br>• [Docker Desktop for Linux](https://docs.docker.com/desktop/setup/install/linux/)<br>• [Docker Engine on Ubuntu/Debian/CentOS](https://docs.docker.com/engine/install/) |
| **Docker Compose** *(Optional)* | `v2.x` | • [Docker Compose Installation Documentation](https://docs.docker.com/compose/install/) |

---

## ⚡ Quick Start

Choose your operating system below for an instant launch:

```bash
# 🐧 Linux or 🍏 macOS
chmod +x setup.sh && ./setup.sh

# 🪟 Windows (Command Prompt / PowerShell)
setup.bat

# 🐳 Docker / Docker Compose (Any OS)
docker compose up -d
```

Once running, navigate to:  
👉 **[http://localhost:8080](http://localhost:8080)**  
(or the local IP printed in your terminal, e.g. `http://192.168.1.150:8080`)

---

## 💻 Step-by-Step Setup Guides by OS

### 1. 🐧 Linux (Ubuntu, Debian, Fedora, Arch, openSUSE)

#### Method A: Automated One-Click Setup (Recommended)
1. Open a terminal in the cloned repository directory:
   ```bash
   cd Server
   ```
2. Grant execution rights and run `setup.sh`:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   *What this script does:*
   - Validates that Python 3.8+ is present.
   - Automatically builds a local virtual environment in `.venv`.
   - Installs or updates dependencies from `requirements.txt`.
   - Generates `.env` from `.env.example` with a cryptographically secure 48-character `SECRET_KEY`.
   - Ensures the `./data` storage directory is ready.
   - Launches `netmanager` with multi-threaded Waitress WSGI.

#### Method B: Manual Setup
1. **Install Python & Git via your distribution package manager:**
   - **Ubuntu / Debian / Linux Mint / Pop!_OS:**
     ```bash
     sudo apt update
     sudo apt install -y python3 python3-venv python3-pip git
     ```
   - **Fedora / RHEL / CentOS / Rocky Linux:**
     ```bash
     sudo dnf install -y python3 python3-pip git
     ```
   - **Arch Linux / Manjaro:**
     ```bash
     sudo pacman -S python python-pip git
     ```
   - **openSUSE:**
     ```bash
     sudo zypper install python3 python3-pip git
     ```

2. **Create and activate a virtual environment:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. **Install required Python packages:**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. **Initialize configuration:**
   ```bash
   cp .env.example .env
   ```

5. **Start the application:**
   ```bash
   python3 netmanager
   ```

#### Optional: Run 24/7 as a Background Service with Systemd
To keep the server running continuously and restart upon system reboots:

1. Create a service file:
   ```bash
   sudo nano /etc/systemd/system/netmanager.service
   ```
2. Paste the following configuration (adjust `/home/sam/Projects/Server` and `sam` to your own user and path):
   ```ini
   [Unit]
   Description=Network File Manager Web Service
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
3. Reload systemd and enable the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now netmanager
   ```
4. Verify status:
   ```bash
   sudo systemctl status netmanager
   ```

---

### 2. 🍏 macOS (Apple Silicon M1/M2/M3/M4 & Intel)

#### Method A: Automated Setup (Recommended)
1. Open the **Terminal** app (`Cmd + Space` > type `Terminal` > Enter).
2. Navigate to the repository:
   ```bash
   cd /path/to/Server
   ```
3. Run the automated script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

#### Method B: Manual Setup
1. **Install Python via [Homebrew](https://brew.sh/):**
   If Homebrew is not yet installed on your Mac, run:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
   Then install Python and Git:
   ```bash
   brew install python git
   ```

2. **Create and activate a virtual environment:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. **Initialize configuration:**
   ```bash
   cp .env.example .env
   ```

5. **Launch:**
   ```bash
   python3 netmanager
   ```

---

### 3. 🪟 Windows (Windows 10 & Windows 11)

#### Prerequisites
1. Download Python 3.10+ from the [Official Python Windows Downloads](https://www.python.org/downloads/windows/).
2. Run the installer.
   > [!IMPORTANT]
   > On the first screen of the Python installer, you **MUST** check the box:  
   > ☑️ **"Add python.exe to PATH"**  
   > Then click **Install Now**.
3. *Alternative:* You can install Python and Git using the modern **Windows Package Manager (Winget)**:
   ```powershell
   winget install Python.Python.3.12 Git.Git
   ```

---

#### Method A: One-Click Automated Setup (`setup.bat`)
1. Open the `Server` folder in File Explorer.
2. **Double-click `setup.bat`**.
3. That's it! The script will automatically:
   - Detect Python.
   - Create a Python virtual environment (`.venv`).
   - Install Flask and Waitress.
   - Generate a secure `.env` file.
   - Launch the server and display your local and Wi-Fi IP addresses.

---

#### Method B: Manual Setup via Command Prompt (`cmd.exe`)
1. Open Command Prompt (`Win + R`, type `cmd`, press Enter).
2. Navigate to the repository:
   ```cmd
   cd C:\path\to\Server
   ```
3. Create and activate a virtual environment:
   ```cmd
   python -m venv .venv
   call .venv\Scripts\activate.bat
   ```
4. Install dependencies:
   ```cmd
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```
5. Initialize `.env` file:
   ```cmd
   copy .env.example .env
   ```
6. Start the server:
   ```cmd
   python netmanager
   ```

---

#### Method C: Manual Setup via PowerShell
1. Open PowerShell.
2. Navigate to the directory:
   ```powershell
   cd C:\path\to\Server
   ```
3. If running scripts is blocked by default Windows policies, permit the current session:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
4. Create and activate the virtual environment:
   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```
5. Install dependencies and copy config:
   ```powershell
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   Copy-Item .env.example .env
   ```
6. Start the server:
   ```powershell
   python netmanager
   ```

---

#### Method D: Windows Subsystem for Linux (WSL2)
If you prefer running inside a native Linux kernel under Windows:
1. Open PowerShell as Administrator and run:
   ```powershell
   wsl --install
   ```
2. Restart your computer if prompted.
3. Open your Ubuntu/Linux terminal from the Start menu and follow the [Linux Setup Instructions](#1--linux-ubuntu-debian-fedora-arch-opensuse).

---

### 4. 🐳 Docker & Docker Compose (Any OS)

Docker provides an isolated, uniform container that runs identically on Linux, macOS, and Windows with zero host dependencies.

#### Prerequisites
- Install [Docker Desktop](https://docs.docker.com/get-docker/) (for Windows / Mac / Linux GUI) or [Docker Engine](https://docs.docker.com/engine/install/) (for headless Linux servers).

#### Running with Docker Compose (Recommended)
1. Initialize your environment file:
   ```bash
   cp .env.example .env
   ```
2. Launch the container in background mode:
   ```bash
   docker compose up -d
   ```
3. View real-time logs:
   ```bash
   docker compose logs -f
   ```
4. Stop the container:
   ```bash
   docker compose down
   ```

#### Running with Docker CLI Directly
```bash
# 1. Build container image
docker build -t netmanager:latest .

# 2. Run container with data volume mounted
docker run -d \
  --name netmanager \
  --restart unless-stopped \
  -p 8080:8080 \
  -v "$(pwd)/data:/data" \
  netmanager:latest
```

---

## ⚙️ Configuration & Environment Variables

All settings can be configured via the `.env` file or directly passed as environment variables.

| Environment Variable | Default Value | Description |
| :--- | :--- | :--- |
| `SECRET_KEY` | *(Auto-generated random hex)* | Key used to cryptographically sign user sessions and CSRF tokens. Set a permanent long string in production. |
| `NETMANAGER_PASSWORD` | *(None / Empty)* | Optional authentication password. If left blank, the server is open to anyone with network access. If set, a clean login screen is required. |
| `NETMANAGER_PORT` | `8080` | Port the web application listens on. |
| `NETMANAGER_DATA_DIR` | `./data` | Directory on the host that is served by the file manager when running directly (outside Docker). |
| `HOST_PORT` | `8080` | Port published to the host machine when using Docker Compose. |
| `HOST_DATA_DIR` | `./data` | Host folder bound to `/data` inside the container when using Docker Compose. |

### CLI Override Format
You can override port and password on the command line without modifying files:
```bash
# Usage: python netmanager [PORT] [PASSWORD]
python3 netmanager 9000 mySecretPassword
```

---

## 📱 Connecting from Phones & LAN Devices

When started, Network File Manager calculates your device's LAN IP address and prints connection links in the terminal:

```text
File Manager running
Directory: /home/sam/Projects/Server/data
Security:  PASSWORD PROTECTED
Local:     http://localhost:8080
Network:   http://192.168.1.150:8080
```

### Steps to Access from Phone or Tablet:
1. Ensure both your computer and your phone/tablet are connected to the **same Wi-Fi router**.
2. Open Safari, Chrome, or any mobile browser on your phone.
3. Type the **Network** URL shown in your terminal (e.g., `http://192.168.1.150:8080`).

### Finding Your Local IP Manually
- **Linux:**
  ```bash
  ip -brief address
  # or
  hostname -I
  ```
- **macOS:**
  ```bash
  ipconfig getifaddr en0   # Wi-Fi
  ipconfig getifaddr en1   # Ethernet
  ```
- **Windows:**
  ```cmd
  ipconfig
  ```
  Look for `IPv4 Address` under your active Wireless LAN adapter or Ethernet adapter (e.g., `192.168.x.x`).

---

## 🛡️ Production & Reverse Proxy Guide

When exposing Network File Manager over the public internet, always use a reverse proxy with HTTPS/TLS encryption.

### Nginx Configuration
```nginx
server {
    listen 80;
    server_name files.example.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name files.example.com;

    ssl_certificate /etc/letsencrypt/live/files.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/files.example.com/privkey.pem;

    client_max_body_size 10G;  # Support large uploads

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_buffering off;
        proxy_request_buffering off;
    }
}
```

### Caddyfile (Automatic SSL)
```caddy
files.example.com {
    reverse_proxy 127.0.0.1:8080 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
    }
}
```

---

## ❓ Troubleshooting & FAQ

### 1. Port 8080 is already busy
*Solution:* Network File Manager has automatic port collision resolution. It will scan ports `8081` through `8130` and bind to the first open port automatically. You can also manually choose a specific port:
```bash
python3 netmanager 8888
```

### 2. Cannot connect from phone or other computers on Wi-Fi
*Solution:* Check your operating system's firewall rules:
- **Linux (UFW):**
  ```bash
  sudo ufw allow 8080/tcp
  ```
- **Windows Firewall:**
  1. Open *Windows Defender Firewall with Advanced Security*.
  2. Create an **Inbound Rule** allowing TCP port `8080`.
  3. Ensure your Wi-Fi network profile is set to **Private**, not Public.
- **macOS Firewall:**
  Go to *System Settings > Network > Firewall* and verify Python is permitted to receive incoming network connections.

### 3. Windows PowerShell script execution error
*Issue:* `File ...\Activate.ps1 cannot be loaded because running scripts is disabled on this system.`  
*Solution:* Run:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### 4. Permission Denied on Linux or Docker volumes
*Solution:* If running via Docker or on Linux with permissions issues on `./data`:
```bash
chmod -R u+rwX data/
# If Docker uses UID 10001 (appuser):
sudo chown -R 10001:10001 data/
```

---

## 📄 License

This repository is distributed under the terms of the **[MIT License](https://opensource.org/licenses/MIT)**. Feel free to use, modify, and distribute it for personal or commercial applications.
