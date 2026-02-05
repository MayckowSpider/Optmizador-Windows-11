# WinOptimize Premium - Backup Manager (Windows 11)
# Responsável por criar pontos de restauração e backups do registro.

function Create-RestorePoint {
    Write-Host ">>> Criando Ponto de Restauração do Sistema..." -ForegroundColor Cyan
    try {
        Checkpoint-Computer -Description "WinOptimize_Before_Optimization" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Host "[✓] Ponto de restauração criado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "[!] Erro ao criar ponto de restauração. Verifique se a Proteção do Sistema está ativada." -ForegroundColor Yellow
        Write-Host "    Pode ser necessário executar como Administrador ou ativar manualmente no Painel de Controle." -ForegroundColor Gray
    }
}

function Open-SystemRestoreUI {
    Write-Host ">>> Abrindo Interface de Restauração do Sistema..." -ForegroundColor Gray
    rstrui.exe
}

# Menu de Backup
function Show-BackupMenu {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "       SISTEMA DE BACKUP E RESTAURAÇÃO         " -ForegroundColor White -BackgroundColor Blue
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "1. Criar Ponto de Restauração (Recomendado)"
    Write-Host "2. Abrir Restauração do Sistema (Para voltar alterações)"
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

# Se o script for chamado diretamente, mostra o menu. 
# Se for importado como módulo, as funções ficam disponíveis.
if ($MyInvocation.InvocationName -ne '.') {
    # Show-BackupMenu
}
