@echo off

:: Check if ADB is available
where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo ADB is not available. Downloading ADB...
    call AdbInstall.bat
    if %errorlevel% neq 0 (
        echo Failed to download ADB. Exiting...
        pause
        exit /b 1
    )
)

:: Continue with the current script
set /p device_name="Enter the device name: "

:: Connect to ADB
adb connect %device_name%

:: Check if connection is successful
adb devices | findstr /C:"%device_name%"
if %errorlevel% neq 0 (
    echo Failed to connect to %device_name%
    pause
    exit /b 1
)

:: Enter ADB Shell, execute the command, and exit
adb -s %device_name% shell busybox hwclock -w && adb -s %device_name% shell exit
