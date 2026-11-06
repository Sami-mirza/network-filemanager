# Network File Manager

A small, self-hosted web app for browsing, uploading, previewing, editing, and organizing files on your computer or local network.

[![Windows](https://img.shields.io/badge/Windows-supported-0078D6?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![macOS](https://img.shields.io/badge/macOS-supported-000000?logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Linux-supported-FCC624?logo=linux&logoColor=black)](https://www.kernel.org/)

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

The setup script creates a private `.venv`, installs the packages listed in [`requirements.txt`](requirements.txt), creates your local settings, and starts the app. On Windows, the batch file does the same. The `requirements.txt` file is included in the repository; you do not need to create it yourself.

On the **host computer**, the terminal lists personal folders and connected drives it can find. Type the number next to the folder you want. For example:

```text
Choose the folder to share on your network.
Folders and connected storage:
  1. Home folder — /home/alex
  2. Documents — /home/alex/Documents
  3. Connected device: mtp:host=... — /run/user/1000/gvfs/mtp:host=...
  4. Connected device: mtp:host=... / Internal shared storage / Download — /run/user/1000/gvfs/mtp:host=.../Internal shared storage/Download
  5. Mounted drive: Backup — /media/alex/Backup
  M. Enter a folder path manually
Choose a number, enter M for a path, or press Enter to keep the current folder.
Folder choice [/home/alex/data]: 4
Saved shared folder: /run/user/1000/gvfs/mtp:host=.../Internal shared storage/Download
```

This question appears in the terminal running the setup script, not in the browser. Phone storage folders are listed under the connected device when the host OS exposes them. Choose the numbered folder, not its descriptive label or path. Paths marked `(read-only)` are shown for clarity but cannot be selected because uploads and file changes require write access. Press Enter to keep the currently selected folder. The selection is remembered for future launches. If a device is not listed, connect and unlock it, choose file-transfer mode, open it in the operating system's file manager, and restart the app. `M` lets you enter a real mounted filesystem path manually.

Keep the terminal window open while you use the app; press **Ctrl+C** there to stop it.

## Host and network access

- On the host computer, open **http://localhost:8080**. Only this local page shows the upload, create, rename, delete, and edit controls.
- Other devices on the same network can browse and download shared files and play supported videos, but they cannot change files. Change requests from network devices are also rejected by the server.
- On other devices on the same network, open **http://netmanager.local:8080**. The app announces this `.local` address over mDNS; devices must support local-network/mDNS names. The app serves video files with browser playback and seeking when the video format is supported by that browser.
- To use a different local name, set `NETMANAGER_HOSTNAME` in `.env` (for example, `my-files.local`) and restart.
- File access is not limited to your Wi-Fi by itself. Use a strong `NETMANAGER_PASSWORD` in `.env` before making the server accessible to people or networks you do not fully trust.

## Use it again

After the first setup, start the app from its project folder:

- **Windows:** run `setup.bat`.
- **macOS/Linux:** run `./setup.sh`.

The setup scripts reuse `.venv` and only install missing or changed requirements. If Python reports that virtual-environment support is missing on Debian/Ubuntu, install it with `sudo apt install python3-venv` and rerun the script.

## Files and settings

- **What is shared:** the selected folder becomes the file manager's root. Its existing files and subfolders appear in the browser. The host can upload and download files, create folders and files, rename, delete, preview, and edit supported files. Other network devices can browse, download, preview, and stream videos, but cannot change the shared files. Changes happen to the actual contents of the selected folder.
- **External drives and phones:** connect and unlock the device, choose its file-transfer mode if prompted, then open it in the operating system's file manager. The startup menu lists mounted external volumes and, on Linux, mounted GVFS/MTP devices. It also lists folders inside connected devices so you can select `Download`, `Documents`, or another folder directly. Read-only folders are marked and cannot be selected for sharing because uploads and file operations require write access. The app can only use devices that the host OS makes available through a filesystem path.
- Examples of mounted paths:
  - Windows: `E:\` or `D:\Photos`
  - macOS: `/Volumes/Backup` or `/Volumes/Phone`
  - Linux: `/media/alex/Backup` or `/run/user/1000/gvfs/...`
- On Linux, an unlocked phone opened in the file manager appears in the startup menu as a connected GVFS device, with its storage folders underneath it. Select the number beside the folder you want. If it does not appear, choose **File Transfer** on the phone and open the device in the file manager before restarting the app. On Windows or macOS, mounted drives and volumes appear in the menu; if a device is not listed, use `M` to enter the normal filesystem path exposed by the OS or a mounting tool.
- Keep the external device connected and mounted while the server is running. If it disconnects, stop the server, reconnect and mount it, then start the server again.
- **Changing the shared folder:** stop the server with Ctrl+C and run the setup script again. Choose another numbered folder or drive. Press Enter to continue using the saved folder.
- You can also set `NETMANAGER_DATA_DIR` in `.env` to the folder's full path. Examples:
  - Linux: `NETMANAGER_DATA_DIR=/home/alex/Documents`
  - macOS: `NETMANAGER_DATA_DIR=/Users/alex/Documents`
  - Windows: `NETMANAGER_DATA_DIR=C:/Users/Alex/Documents`
- The app needs read and write access to the selected folder. If it cannot access a folder, choose another folder or update its permissions.
- If you keep the default, the project `data/` folder is shared.
- The setup script creates a `.env` file with a private session key. Do not share or commit `.env`.
- To set a login password, stop the app, open `.env`, set `NETMANAGER_PASSWORD` to a password of your choice, save, and start the app again. Leave it empty to disable the login screen.
- By default, the app listens on port `8080`. Set `NETMANAGER_PORT` in `.env` to use another port.
- To access the app from another device on your home network, use `http://netmanager.local:8080`. Only do this on a trusted network, and set a password first.

## Troubleshooting

- **`python` is not recognized (Windows):** reinstall Python and enable **Add Python to PATH**, then open a new terminal.
- **`python3-venv` or `ensurepip` is missing (Linux):** install `python3-venv` and `python3-pip` using your distribution's package manager, then rerun setup.
- **Dependencies fail to install:** check your internet connection and rerun the setup script.
- **Port 8080 is already in use:** set `NETMANAGER_PORT=8081` (or another free port) in `.env`, then restart.
- **The `.local` address does not load:** make sure both devices are on the same network and that the client supports mDNS/local-network names. The startup message shows the host's IP as a fallback.
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
