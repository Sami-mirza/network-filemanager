@echo off
setlocal enabledelayedexpansion

echo ========================================
echo     Network File Manager Setup (Windows)
echo ========================================

REM 1. Check Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [-] Error: Python was not found in your PATH.
    echo     Please install Python 3.10+ from:
    echo     https://www.python.org/downloads/
    echo     (Ensure "Add Python to PATH" is checked during installation)
    echo     Or install via Winget:
    echo     winget install Python.Python.3.12
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('python -V') do echo [+] Found %%i

REM 2. Create virtual environment
if not exist ".venv" (
    echo [*] Creating virtual environment (.venv)...
    python -m venv .venv
    if %errorlevel% neq 0 (
        echo [-] Error creating virtual environment.
        pause
        exit /b 1
    )
)

REM 3. Activate virtual environment
call .venv\Scripts\activate.bat

REM 4. Install dependencies
echo [*] Installing dependencies from requirements.txt...
python -m pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet
if %errorlevel% neq 0 (
    echo [-] Error installing dependencies.
    pause
    exit /b 1
)
echo [+] Dependencies installed successfully.

REM 5. Initialize .env
if not exist ".env" (
    echo [*] Creating .env from .env.example...
    copy .env.example .env >nul
    python -c "import secrets, re; s=secrets.token_hex(24); f=open('.env','r'); c=f.read(); f.close(); open('.env','w').write(c.replace('change-me-to-a-long-random-string', s))"
    echo [+] Generated new random SECRET_KEY in .env
)

REM 6. Ensure data directory exists
if not exist "data" mkdir data

REM 7. Check if user passed --setup-only
if "%~1"=="--setup-only" (
    echo [+] Setup complete! Run setup.bat to start the server.
    pause
    exit /b 0
)

REM 8. Start server
echo ========================================
echo [+] Starting Network File Manager...
echo ========================================
python netmanager %*
pause
