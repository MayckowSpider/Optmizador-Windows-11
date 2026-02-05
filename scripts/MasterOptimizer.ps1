# WinOptimize Premium - MASTER OPTIMIZER (Windows 11)
# Executa todos os modulos de otimizacao em sequencia.

Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "       WINOPTIMIZE PREMIUM - MASTER MODE       " -ForegroundColor White -BackgroundColor Blue
Write-Host "===============================================" -ForegroundColor Cyan

$ScriptDir = $PSScriptRoot
$BackupScript = Join-Path $ScriptDir "BackupManager.ps1"

Write-Host "RECOMENDACAO: Crie um ponto de restauracao antes de continuar." -ForegroundColor Yellow
$resp = Read-Host "Deseja criar um ponto de restauracao agora? (S/N)"
if ($resp -eq 'S' -or $resp -eq 's') {
    if (Test-Path $BackupScript) {
        # Carrega as funcoes do BackupManager
        . $BackupScript
        Create-RestorePoint
    } else {
        Write-Host "ERRO: BackupManager.ps1 nao encontrado!" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Iniciando otimizacao completa do Windows 11..." -ForegroundColor Gray
Write-Host ""

# Funcao para rodar scripts
function Run-Optimization($Name, $File) {
    Write-Host ">>> Rodando: $Name..." -ForegroundColor Yellow
    $Path = Join-Path $ScriptDir $File
    if (Test-Path $Path) {
        & $Path
    } else {
        Write-Host "ERRO: Arquivo $File nao encontrado!" -ForegroundColor Red
    }
    Write-Host "-------------------------------------------" -ForegroundColor DarkGray
}

# Sequencia de Otimizacao (Executada passo a passo)
Run-Optimization "Limpeza de Disco" "Cleaner.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Privacidade e Telemetria" "Privacy.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Modo de Alta Performance" "Performance.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Remocao de Bloatware" "Debloater.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Ajustes Avancados (Rede/Disco)" "Advanced.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Manutencao Pro (Seguranca)" "Maintenance.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Gestao de Processos e Servicos" "Processes.ps1"
Write-Host "Pressione qualquer tecla para ir para o proximo passo..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host

Run-Optimization "Conforto e Estabilidade (Extra)" "Comfort.ps1"

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "   TODAS AS OTIMIZACOES FORAM CONCLUIDAS!    " -ForegroundColor Green
Write-Host "   Recomendamos reiniciar o seu computador.    " -ForegroundColor White
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""
