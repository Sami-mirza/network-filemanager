<div align="center">

# 🌐 Network File Manager

**A modern, lightweight, self-hosted web-based file manager.**  
*Browse, upload, preview, edit, and share files across your network with zero database setup.*

[![Docker](https://img.shields.io/badge/Docker-Zero--Install%20Recommended-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Compose](https://img.shields.io/badge/Docker_Compose-One--Command-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Python](https://img.shields.io/badge/Python-3.8%2B%20(Bundled)-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[![Platform Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://www.kernel.org/)
[![Platform macOS](https://img.shields.io/badge/macOS-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Platform Windows](https://img.shields.io/badge/Windows-0078D6?style=flat-square&logo=windows&logoColor=white)](https://www.microsoft.com/windows)

</div>

> [!TIP]
> ### 🚀 Zero Host Dependencies Required!
> **You do NOT need to install Python, Flask, pip, or virtual environments on your computer!**  
> Everything (Python 3.12, Flask, Waitress, and all packages) is pre-packaged inside a container. If you have Docker, you can run the entire server with a single command:
> ```bash
> docker compose up -d
> ```
> *On Windows, you can simply double-click `docker-start.bat`!*  
> *On Linux / macOS, simply run `./docker-start.sh`!*

---

## 📑 Table of Contents

- [The Fast Way: Docker Setup (Recommended)](#-the-fast-way-docker-setup-recommended)
  - [Docker Downloads for All OS](#docker-downloads-for-all-os)
  - [Windows Setup with Docker](#1-windows-setup-with-docker)
  - [Linux Setup with Docker](#2-linux-setup-with-docker)
  - [macOS Setup with Docker](#3-macos-setup-with-docker)
  - [Docker Compose & CLI Reference](#4-docker-compose--cli-reference)
- [Key Features](#-key-features)
- [Accessing Files & Connecting Phones (LAN)](#-accessing-files--connecting-phones-lan)
- [Configuration & Password Protection](#-configuration--password-protection)
- [Alternative: Running Directly with Python (Without Docker)](#-alternative-running-directly-with-python-without-docker)
  - [Windows (Python)](#windows-manual-python-setup)
  - [Linux (Python)](#linux-manual-python-setup)
  - [macOS (Python)](#macos-manual-python-setup)
- [Production & Reverse Proxy (Nginx / Caddy)](#-production--reverse-proxy-nginx--caddy)
- [Troubleshooting & FAQ](#-troubleshooting--faq)
- [License](#-license)

---

## 🐳 The Fast Way: Docker Setup (Recommended)

Running with Docker is the cleanest, easiest method. Your host operating system stays completely untouched:
- ❌ No need to install Python.
- ❌ No need to install `pip` or Python packages (`flask`, `waitress`, etc.).
- ❌ No virtual environment conflicts or path issues.
- ✅ Everything runs in a lightweight, secure container and saves files directly to your host's [`./data`](file:///home/sam/Projects/Server/data) folder.

---

### Docker Downloads for All OS

If you don't have Docker installed yet, download the free official installer for your operating system:

| Operating System | Download Link & Guide |
| :--- | :--- |
| **🪟 Windows (10 & 11)** | [Download Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/) |
| **🍏 macOS (Apple Silicon & Intel)** | [Download Docker Desktop for Mac](https://docs.docker.com/desktop/setup/install/mac-install/) |
| **🐧 Linux (Ubuntu, Debian, Fedora, Arch)** | [Install Docker Desktop on Linux](https://docs.docker.com/desktop/setup/install/linux/) or [Install Docker Engine](https://docs.docker.com/engine/install/) |

---

### 1. Windows Setup with Docker

#### Option A: One-Click Launcher (`docker-start.bat`)
1. Make sure **Docker Desktop** is open and running.
2. Open the `Server` folder in File Explorer.
3. **Double-click `docker-start.bat`**.
4. Open your browser to **[http://localhost:8080](http://localhost:8080)**.

#### Option B: PowerShell or Command Prompt
```powershell
cd C:\path\to\Server
docker compose up -d
```
To stop the server:
```powershell
docker compose down
```

---

### 2. Linux Setup with Docker

#### Option A: One-Click Launcher (`docker-start.sh`)
```bash
cd Server
chmod +x docker-start.sh
./docker-start.sh
```

#### Option B: Terminal Command
```bash
docker compose up -d
```
To view logs:
```bash
docker compose logs -f
```
To stop:
```bash
docker compose down
```

---

### 3. macOS Setup with Docker

#### Option A: One-Click Launcher (`docker-start.sh`)
1. Ensure **Docker Desktop for Mac** is running.
2. Open Terminal and run:
   ```bash
   cd /path/to/Server
   chmod +x docker-start.sh
   ./docker-start.sh
   ```

#### Option B: Terminal Command
```bash
docker compose up -d
```

---

### 4. Docker Compose & CLI Reference

#### Where Are My Files Stored?
All files uploaded to the file manager are saved directly in the [`./data`](file:///home/sam/Projects/Server/data) folder on your host computer. You can copy files directly in or out of this folder anytime!

#### Using Docker CLI (without Compose):
```bash
# Build image
docker build -t netmanager:latest .

# Run container
docker run -d \
  --name netmanager \
  --restart unless-stopped \
  -p 8080:8080 \
  -v "$(pwd)/data:/data" \
  netmanager:latest
```

---

## ✨ Key Features

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

- 📂 **Full File & Folder Management**: Upload multiple files, create folders, create empty files, rename, and delete items.
- 🖼️ **Media Previews**: Native player for Video (MP4, WebM, MOV), Audio (MP3, WAV, FLAC), Images (PNG, JPG, SVG, WEBP), and embedded PDF viewer.
- ✏️ **In-Browser Code & Text Editor**: Edit text, Markdown, code, and configuration files directly in your browser with instant save.
- 📦 **One-Click ZIP Downloads**: Download any single file or download whole folders compressed as `.zip` on the fly.
- 🔍 **Instant Search**: Real-time folder search box.
- 🌓 **Adaptive Light/Dark Theme**: Automatically matches your system preferences.
- 🔒 **Security**: Password protection, CSRF token verification, and strict path-traversal prevention.

---

## 📱 Accessing Files & Connecting Phones (LAN)

Once the server is running, any device connected to the same Wi-Fi can access and upload files!

1. Look up your computer's local IP address:
   - **Linux:** `ip -brief address` or `hostname -I`
   - **macOS:** `ipconfig getifaddr en0` (Wi-Fi)
   - **Windows:** `ipconfig` (look for `IPv4 Address`, e.g., `192.168.1.150`)
2. On your phone (iPhone, Android, or tablet), open the browser and go to:
   ```text
   http://YOUR_LOCAL_IP:8080
   (Example: http://192.168.1.150:8080)
   ```

---

## ⚙️ Configuration & Password Protection

Settings are configured in the [`.env`](file:///home/sam/Projects/Server/.env) file:

```ini
# Optional password (leave blank for open home network access)
NETMANAGER_PASSWORD=MySecretPassword

# Port to expose on your machine (default: 8080)
HOST_PORT=8080

# Directory on host where files are stored (default: ./data)
HOST_DATA_DIR=./data

# Secret key for session security (auto-generated)
SECRET_KEY=long-random-string
```

After modifying `.env`, restart the container:
```bash
docker compose up -d
```

---

## 🐍 Alternative: Running Directly with Python (Without Docker)

If you prefer to run directly with Python on bare metal without Docker:

### Prerequisites & Downloads
- [Python 3.10+ Official Download](https://www.python.org/downloads/)
- [Git Official Download](https://git-scm.com/downloads)

---

### Windows (Manual Python Setup)

1. Install Python from [python.org](https://www.python.org/downloads/windows/).  
   *(Make sure to check **"Add python.exe to PATH"** in the installer!)*
2. Quick setup with batch script:
   ```cmd
   setup.bat
   ```
3. Or manual terminal commands:
   ```cmd
   python -m venv .venv
   call .venv\Scripts\activate.bat
   pip install -r requirements.txt
   copy .env.example .env
   python netmanager
   ```

---

### Linux (Manual Python Setup)

1. Install system packages:
   ```bash
   # Debian / Ubuntu / Mint
   sudo apt update && sudo apt install -y python3 python3-venv python3-pip git

   # Fedora / RHEL
   sudo dnf install -y python3 python3-pip git

   # Arch Linux
   sudo pacman -S python python-pip git
   ```
2. Quick setup with bash script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
3. Or manual commands:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   cp .env.example .env
   python3 netmanager
   ```

---

### macOS (Manual Python Setup)

1. Install Python via [Homebrew](https://brew.sh/):
   ```bash
   brew install python git
   ```
2. Run setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

---

## 🛡️ Production & Reverse Proxy (Nginx / Caddy)

If publishing over the public internet, use an SSL reverse proxy:

### Nginx
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

    client_max_body_size 10G;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Caddy
```caddy
files.yourdomain.com {
    reverse_proxy 127.0.0.1:8080
}
```

---

## ❓ Troubleshooting & FAQ

### 1. Port 8080 is already busy
Change `HOST_PORT=9000` in `.env` and run `docker compose up -d`, or start directly on port 9000:
```bash
HOST_PORT=9000 docker compose up -d
```

### 2. Cannot connect from phone or other computers
- Ensure both devices are connected to the same Wi-Fi.
- Allow port `8080` in your firewall:
  - Linux: `sudo ufw allow 8080/tcp`
  - Windows: Allow port 8080 in *Windows Defender Firewall*.

### 3. Permissions issue on `./data` directory
Ensure your local data directory has write permissions:
```bash
chmod -R u+rwX data/
```

---

## 📄 License

Distributed under the **[MIT License](https://opensource.org/licenses/MIT)**. Feel free to use and customize for personal or commercial projects.
# network-filemanager
# onlinestore
# onlinestore
# network-filemanager
