@echo off
REM TravisGen Server - Batch script for Windows
REM Simple wrapper to call PowerShell script

if "%1"=="" (
    powershell -ExecutionPolicy Bypass -File "%~dp0make.ps1" help
) else (
    powershell -ExecutionPolicy Bypass -File "%~dp0make.ps1" %*
)
