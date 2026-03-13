@echo off
title Windows Tweaks Toolkit
color 0A

:menu
cls
echo ======================================
echo        Windows Tweaks Toolkit
echo ======================================
echo.
echo 1. Enable Classic Explorer Menu Like windows 10 right click menu
echo 2. Revert Explorer to Default Change back to windows 11 right click menu
echo 3. Enable SMB Guest Access Fix 
echo 4. Revert SMB Security Settings
echo 5. Exit
echo.
set /p choice=Select an option (1-5): 

if "%choice%"=="1" goto explorer_enable
if "%choice%"=="2" goto explorer_revert
if "%choice%"=="3" goto smb_enable
if "%choice%"=="4" goto smb_revert
if "%choice%"=="5" exit
goto menu


:explorer_enable
echo.
echo Enabling Classic Explorer Context Menu...

reg add "HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /f
reg add "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /f /ve

echo Restarting Explorer...
taskkill /f /im explorer.exe
start explorer.exe

echo Done!
pause
goto menu


:explorer_revert
echo.
echo Reverting Explorer to Windows 11 Default...

reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
reg delete "HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}" /f

echo Restarting Explorer...
taskkill /f /im explorer.exe
start explorer.exe

echo Done!
pause
goto menu


:smb_enable
echo.
echo Applying SMB Guest Access Fix...

powershell -Command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force"
powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false -Force"
powershell -Command "Set-SmbServerConfiguration -RequireSecuritySignature $false -Force"

echo SMB settings applied.
pause
goto menu


:smb_revert
echo.
echo Reverting SMB settings to secure defaults...

powershell -Command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $false -Force"
powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $true -Force"
powershell -Command "Set-SmbServerConfiguration -RequireSecuritySignature $true -Force"

echo SMB settings reverted.
pause
goto menu