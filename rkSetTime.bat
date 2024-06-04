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
    ) else (
        echo ADB downloaded successfully. Restarting the script...
        timeout /t 2 >nul
        start cmd /c "%~dpnx0"
        exit
    )
)

:: List connected devices and let the user choose
echo Listing connected devices...
adb devices

:: Prompt the user to choose a device
set /p device_name="Enter the index of the device you want to set: "

:: Execute commands in ADB Shell
adb -s %device_name% shell busybox hwclock -w
adb -s %device_name% shell date

pause
