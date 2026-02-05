# WinOptimize Premium - Restore Defaults (Windows 11)
# Restaura as configurações originais do Windows.

Write-Host "--- Restaurando Configurações Originais ---" -ForegroundColor Yellow

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { 
            New-Item -Path $Path -Force -ErrorAction Stop | Out-Null 
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Restaurado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Erro ao restaurar: $Name" -ForegroundColor DarkGray
    }
}

# 1. Performance
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 1
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 0

# 2. Privacidade e Barra de Tarefas
Set-RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 1
Set-RegKey "HKCU:\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" 0
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 1
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 1

# 3. Serviços
Write-Host ">>> Reativando serviços essenciais..." -ForegroundColor Gray
Set-Service -Name "DiagTrack" -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name "DiagTrack" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "   RESTAURAÇÃO DE PADRÕES CONCLUÍDA!         " -ForegroundColor Green
Write-Host "   Algumas alterações podem exigir reinicialização." -ForegroundColor White
Write-Host "===============================================" -ForegroundColor Green
