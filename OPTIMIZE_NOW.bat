@echo off
:: WinOptimize Premium - Master Launcher Fix
setlocal DisplayDelayedExpansion

title WinOptimize Premium - Master Optimizer
cd /d "%~dp0"

:: Verificar Administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :run_script
) else (
    echo.
    echo ======================================================
    echo   SOLICITANDO PERMISSOES DE ADMINISTRADOR...
    echo ======================================================
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:run_script
:: Navegar ate a pasta do script novamente para garantir
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\MasterOptimizer.ps1"
echo.
echo Otimizacao completa.
pause
