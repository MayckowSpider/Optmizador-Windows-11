# WinOptimize Premium - Comfort & Stability
Write-Host "--- Aplicando Ajustes de Conforto (Sem Riscos) ---" -ForegroundColor Yellow

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Ajustado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado: $Name" -ForegroundColor DarkGray
    }
}

# 1. Desativar P2P de Atualizações (Liberar Internet)
Write-Host "[1/4] Desativando 'Otimização de Entrega' (Upload de updates)..." -ForegroundColor Cyan
Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" "DODownloadMode" 0

# 2. Remover Sugestões e Dicas Chatas
Write-Host "[2/4] Removendo sugestões e notificações de ajuda..." -ForegroundColor Cyan
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SoftLandingEnabled" 0
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0

# 3. Prevenir Reinicialização Inesperada (Windows Update)
Write-Host "[3/4] Evitando reinicializações forçadas por updates..." -ForegroundColor Cyan
Set-RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" 1

# 4. Limpando Cache de Ícones/Miniaturas
Write-Host "[4/4] Limpando cache de miniaturas (Explorador de Arquivos)..." -ForegroundColor Cyan
Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer" -Filter "thumbcache_*.db" | Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "--- Conforto e Estabilidade Concluídos! ---" -ForegroundColor Green
