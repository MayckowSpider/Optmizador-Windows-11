# WinOptimize Premium - Windows Debloater Script
# Remove aplicativos pré-instalados inúteis (Candy Crush, etc).

Write-Host "--- Iniciando Remoção de Bloatware (Debloater) ---" -ForegroundColor Red
Write-Host "Aguarde, este processo pode demorar alguns minutos..." -ForegroundColor Yellow

# Lista de pacotes comuns para remover
$AppsToRemove = @(
    "*Microsoft.ZuneVideo*",
    "*Microsoft.ZuneMusic*",
    "*Microsoft.SkypeApp*",
    "*Microsoft.Office.OneNote*",
    "*Microsoft.BingNews*",
    "*Microsoft.BingWeather*",
    "*Microsoft.Getstarted*",
    "*Microsoft.MicrosoftSolitaireCollection*",
    "*Microsoft.People*",
    "*Microsoft.WindowsMaps*",
    "*Microsoft.YourPhone*",
    "*Microsoft.WindowsFeedbackHub*",
    "*Microsoft.GetHelp*"
)

foreach ($App in $AppsToRemove) {
    Write-Host "Removendo: $App" -ForegroundColor Gray
    Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like $App } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

Write-Host "--- Debloater Concluído! ---" -ForegroundColor Green
Write-Host "Aplicativos desnecessários foram removidos do seu perfil." -ForegroundColor Cyan
