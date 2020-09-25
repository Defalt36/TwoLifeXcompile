@echo off
echo "Warning. This will restart your machine."
pause
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
shutdown /r
