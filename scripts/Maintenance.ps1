# WinOptimize Premium - Safe Maintenance
Write-Host "--- Iniciando Manutenção Pro (100% Seguro) ---" -ForegroundColor Green

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Ajustado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado: $Name" -ForegroundColor DarkGray
    }
}

# 1. Acelerando a Resposta da Interface
Write-Host "[1/4] Acelerando menus e interface..." -ForegroundColor Cyan
Set-RegKey "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0"
Set-RegKey "HKCU:\Control Panel\Desktop" "MouseHoverTime" "10"

# 2. Otimizando Prioridade de Processamento
Write-Host "[2/4] Priorizando programas ativos..." -ForegroundColor Cyan
Set-RegKey "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 38

# 3. Limpeza de Rede (DNS)
Write-Host "[3/4] Limpando cache de DNS (Internet)..." -ForegroundColor Cyan
ipconfig /flushdns | Out-Null
Write-Host " [+] DNS limpo com sucesso." -ForegroundColor Gray

# 4. Limpeza de Componentes Antigos (Windows Update)
Write-Host "[4/4] Limpando arquivos de atualizações antigas (DISM)..." -ForegroundColor Cyan
Write-Host " Isso pode demorar um pouco, mas é MUITO seguro." -ForegroundColor DarkGray
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /Quiet /NoRestart

Write-Host "--- Manutenção Pro Concluída! ---" -ForegroundColor Green
