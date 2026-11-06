@echo off
setlocal
cd /d "%~dp0"

echo ==================================================
echo     Network File Manager — Docker Quickstart (Windows)
echo ==================================================

REM Check if Docker is installed
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo [-] Error: Docker is not installed or not in your PATH.
    echo     Please download Docker Desktop for Windows from:
    echo     https://docs.docker.com/desktop/setup/install/windows-install/
    echo.
    pause
    exit /b 1
)

REM Ensure data folder exists
if not exist "data" mkdir data

REM Check if Docker daemon is running
docker info >nul 2>nul
if %errorlevel% neq 0 (
    echo [-] Error: Docker is not running.
    echo     Please start Docker Desktop and try again.
    echo.
    pause
    exit /b 1
)

echo [*] Starting container with Docker Compose...

docker compose version >nul 2>nul
if %errorlevel% equ 0 (
    docker compose up -d --build
) else (
    docker-compose version >nul 2>nul
    if %errorlevel% equ 0 (
        docker-compose up -d --build
    ) else (
        echo [*] Falling back to direct docker build and run...
        docker build -t netmanager:latest .
        docker stop netmanager >nul 2>nul
        docker rm netmanager >nul 2>nul
        docker run -d --name netmanager --restart unless-stopped -p 8080:8080 -v "%cd%\data:/data" netmanager:latest
    )
)

echo.
echo ==================================================
echo [+] Network File Manager is running successfully!
echo ==================================================
echo   Local Web UI:   http://localhost:8080
echo   Files folder:   %cd%\data
echo   Stop container: docker compose down
echo ==================================================
pause
