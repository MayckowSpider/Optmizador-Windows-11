# WinOptimize Premium - Disk Cleaner (Windows 11 Optimized)
Write-Host "--- Iniciando Limpeza de Disco Premium (W11) ---" -ForegroundColor Cyan

# 1. Temporários Usuário
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
# 2. Temporários Sistema
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
# 3. Prefetch
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
# 4. Cache Navegadores
$Browsers = @("$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache", "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache")
foreach ($P in $Browsers) { if (Test-Path $P) { Remove-Item -Path "$P\*" -Recurse -Force -ErrorAction SilentlyContinue } }
# 5. Cache de Widgets (Win 11)
$W = "$env:LOCALAPPDATA\Packages\MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy\LocalCache"
if (Test-Path $W) { Remove-Item -Path "$W\*" -Recurse -Force -ErrorAction SilentlyContinue }
# 6. Esvaziar Lixeira
Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue

Write-Host "--- Limpeza Concluída! ---" -ForegroundColor Green
