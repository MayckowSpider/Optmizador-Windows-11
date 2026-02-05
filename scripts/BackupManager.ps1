# WinOptimize Premium - Backup Manager (Windows 11)
# Responsável por criar pontos de restauração e backups do registro.

function Create-RestorePoint {
    Write-Host ">>> Criando Ponto de Restauração do Sistema..." -ForegroundColor Cyan
    try {
        # Habilita restauração na unidade C: caso esteja desativada (comum no W11)
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        
        Checkpoint-Computer -Description "WinOptimize_Before_Optimization" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Host "[OK] Ponto de restauração criado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "[!] Erro ao criar ponto de restauração." -ForegroundColor Yellow
        Write-Host "    Certifique-se de estar rodando como ADMINISTRADOR." -ForegroundColor Gray
    }
}

function Open-SystemRestoreUI {
    Write-Host ">>> Abrindo Interface de Restauração do Sistema..." -ForegroundColor Gray
    Start-Process "rstrui.exe"
}

# Menu de Backup
function Show-BackupMenu {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "       SISTEMA DE BACKUP E RESTAURAÇÃO         " -ForegroundColor White -BackgroundColor Blue
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "1. Criar Ponto de Restauração (Recomendado)"
    Write-Host "2. Abrir Restauração do Sistema"
    Write-Host "3. Voltar"
    Write-Host ""
    
    $choice = Read-Host "Escolha uma opção"
    
    switch ($choice) {
        "1" { Create-RestorePoint; pause }
        "2" { Open-SystemRestoreUI; pause }
        "3" { return }
        default { Write-Host "Opção inválida!"; pause; Show-BackupMenu }
    }
}

# Verificação simples para evitar erro de execução
if ($MyInvocation.InvocationName -ne '.') {
    # Menu desativado por padrão ao importar
}
