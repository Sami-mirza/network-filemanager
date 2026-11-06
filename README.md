# Network File Manager

A small, self-hosted web app for browsing, uploading, previewing, editing, and organizing files on your computer or local network.

## Quick start

You need **Python 3.9 or newer** and Git. No Docker is needed.

### Windows

1. Install [Python](https://www.python.org/downloads/windows/) and select **Add Python to PATH** during installation.
2. Install [Git for Windows](https://git-scm.com/download/win), if it is not already installed.
3. Open Command Prompt or PowerShell and run:

   ```powershell
   git clone https://github.com/Sami-mirza/network-filemanager.git
   cd network-filemanager
   setup.bat
   ```

   You can also open the project folder in File Explorer and double-click `setup.bat`.

### macOS

1. Install [Python](https://www.python.org/downloads/macos/) if needed. Git is included with Apple's Command Line Tools; macOS will prompt you to install them if necessary.
2. Open Terminal and run:

   ```bash
   git clone https://github.com/Sami-mirza/network-filemanager.git
   cd network-filemanager
   ./setup.sh
   ```

### Linux

1. Install Python 3, its virtual-environment support, pip, and Git. On Debian or Ubuntu:

   ```bash
   sudo apt update
   sudo apt install -y git python3 python3-venv python3-pip
   ```

2. Open a terminal and run:

   ```bash
   git clone https://github.com/Sami-mirza/network-filemanager.git
   cd network-filemanager
   ./setup.sh
   ```

The setup script creates a private `.venv`, installs the packages from `requirements.txt`, creates your local settings, and starts the app. On Windows, the batch file does the same.

When the startup message appears, open **http://localhost:8080** in your browser. Keep the terminal window open while you use the app; press **Ctrl+C** there to stop it.

## Use it again

After the first setup, start the app from its project folder:

- **Windows:** run `setup.bat`.
- **macOS/Linux:** run `./setup.sh`.

The setup scripts reuse `.venv` and only install missing or changed requirements. If Python reports that virtual-environment support is missing on Debian/Ubuntu, install it with `sudo apt install python3-venv` and rerun the script.

## Files and settings

- Uploaded files are stored in the project's `data/` folder. Keep this folder to keep your files.
- The setup script creates a `.env` file with a private session key. Do not share or commit `.env`.
- To set a login password, stop the app, open `.env`, set `NETMANAGER_PASSWORD` to a password of your choice, save, and start the app again. Leave it empty to disable the login screen.
- By default, the app listens on port `8080`. Set `NETMANAGER_PORT` in `.env` to use another port.
- To access the app from another device on your home network, use your computer's local IP address, for example `http://192.168.1.25:8080`. Only do this on a trusted network, and set a password first.

## Troubleshooting

- **`python` is not recognized (Windows):** reinstall Python and enable **Add Python to PATH**, then open a new terminal.
- **`python3-venv` or `ensurepip` is missing (Linux):** install `python3-venv` and `python3-pip` using your distribution's package manager, then rerun setup.
- **Dependencies fail to install:** check your internet connection and rerun the setup script.
- **Port 8080 is already in use:** set `NETMANAGER_PORT=8081` (or another free port) in `.env`, then restart.
- **The page does not load:** make sure the app is still running in the terminal and visit the port shown in its startup message.

## Manual setup

If you prefer not to use a setup script, create a virtual environment, install the requirements, and start the app:

```bash
python3 -m venv .venv
# macOS/Linux:
source .venv/bin/activate
# Windows Command Prompt: .venv\Scripts\activate.bat
# Windows PowerShell: .venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python netmanager
```

## License

See the project license for terms of use.
