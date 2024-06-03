@echo off
setlocal EnableDelayedExpansion

:: Define the ADB download URL and the target directory
set "adb_url=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
set "adb_dir=%~dp0platform-tools"

:: Define a temporary directory for the download
set "temp_dir=%~dp0temp_adb"

:: Create the temporary directory
if not exist "%temp_dir%" mkdir "%temp_dir%"

:: Download the ADB zip file
echo Downloading ADB...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%adb_url%', '%temp_dir%\platform-tools.zip')"

:: Unzip the ADB zip file
echo Extracting ADB...
powershell -Command "Expand-Archive -Path '%temp_dir%\platform-tools.zip' -DestinationPath '%~dp0'"

:: Clean up the temporary directory
rmdir /s /q "%temp_dir%"

:: Check if ADB was extracted correctly
if not exist "%adb_dir%\adb.exe" (
    echo Error: ADB extraction failed.
    exit /b 1
)

:: Add ADB directory to the system PATH
setx PATH "%adb_dir%;%PATH%"

:: Verify the configuration
echo.
echo Verifying ADB installation...
adb version
if %errorlevel% neq 0 (
    echo Error: ADB was not configured correctly.
    exit /b 1
)

echo.
echo ADB has been installed and configured successfully.
pause
exit /b 0
