# WinOptimize Premium - Performance (W11 Fixed)
Write-Host "--- Aplicando Otimizações de Perf (W11) ---" -ForegroundColor Blue

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { 
            New-Item -Path $Path -Force -ErrorAction Stop | Out-Null 
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Ajustado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado: $Name" -ForegroundColor DarkGray
    }
}

# 1. Power Plan
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

# 2. Transparência
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0

# 3. Game Mode
Set-RegKey "HKCU:\Software\Microsoft\GameBar" "AllowAutoGameMode" 1

# 4. Background Apps
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 1

# 5. Menu Iniciar
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_Layout" 1

Write-Host "--- Performance Otimizada! ---" -ForegroundColor Green
