@echo off
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Intel\IRST 1>nul 2>nul
IF %errorlevel%==0 (
echo installed
) else (
echo notfound
)