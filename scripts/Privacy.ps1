# WinOptimize Premium - Privacy (W11 Fixed)
Write-Host "--- Aplicando Ajustes de Privacidade (W11) ---" -ForegroundColor Magenta

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { 
            New-Item -Path $Path -Force -ErrorAction Stop | Out-Null 
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Aplicado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado (Protegido): $Name" -ForegroundColor DarkGray
    }
}

# 1. Telemetria
Set-RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0

# 2. Bing Search
Set-RegKey "HKCU:\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" 1

# 3. Widgets e Chat
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0

# 4. DiagTrack Service
Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "--- Privacidade Concluída! ---" -ForegroundColor Green
