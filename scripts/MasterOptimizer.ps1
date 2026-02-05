# WinOptimize Premium - MASTER OPTIMIZER (Windows 11)
# Executa todos os módulos de otimização em sequência.

Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "       WINOPTIMIZE PREMIUM - MASTER MODE       " -ForegroundColor White -BackgroundColor Blue
Write-Host "===============================================" -ForegroundColor Cyan

$ScriptDir = $PSScriptRoot
$BackupScript = Join-Path $ScriptDir "BackupManager.ps1"

Write-Host "RECOMENDAÇÃO: Crie um ponto de restauração antes de continuar." -ForegroundColor Yellow
$resp = Read-Host "Deseja criar um ponto de restauração agora? (S/N)"
if ($resp -eq 'S' -or $resp -eq 's') {
    if (Test-Path $BackupScript) {
        # Carrega as funções do BackupManager
        . $BackupScript
        Create-RestorePoint
    } else {
        Write-Host "ERRO: BackupManager.ps1 não encontrado!" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Iniciando otimização completa do Windows 11..." -ForegroundColor Gray
Write-Host ""


# Função para rodar scripts
function Run-Optimization($Name, $File) {
    Write-Host ">>> Rodando: $Name..." -ForegroundColor Yellow
    $Path = Join-Path $ScriptDir $File
    if (Test-Path $Path) {
        & $Path
    } else {
        Write-Host "ERRO: Arquivo $File não encontrado!" -ForegroundColor Red
    }
    Write-Host "-------------------------------------------" -ForegroundColor DarkGray
}

# Sequência de Otimização (Executada passo a passo)
Run-Optimization "Limpeza de Disco" "Cleaner.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Privacidade e Telemetria" "Privacy.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Modo de Alta Performance" "Performance.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Remoção de Bloatware" "Debloater.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Ajustes Avançados (Rede/Disco)" "Advanced.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Manutenção Pro (Segurança)" "Maintenance.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Gestão de Processos e Serviços" "Processes.ps1"
Write-Host "Pressione qualquer tecla para ir para o próximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Conforto e Estabilidade (Extra)" "Comfort.ps1"

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "   TODAS AS OTIMIZAÇÕES FORAM CONCLUÍDAS!    " -ForegroundColor Green
Write-Host "   Recomendamos reiniciar o seu computador.    " -ForegroundColor White
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""
