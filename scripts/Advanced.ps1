# WinOptimize Premium - Advanced Tweaks (Latency & Storage) - REVISTO
Write-Host "--- Aplicando Ajustes Avançados (Rede e Disco) ---" -ForegroundColor Yellow

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null }
        if ($Name -eq "(Default)") {
            Set-Item -Path $Path -Value $Value -Force -ErrorAction Stop
        } else {
            Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        }
        Write-Host " [+] Ajustado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado: $Name" -ForegroundColor DarkGray
    }
}

# 1. Otimização de Ping/Rede (Gaming)
Write-Host "[1/3] Otimizando latência de rede (Gaming)..." -ForegroundColor Cyan
Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 0xffffffff

# Aplicar em todas as interfaces de rede encontradas
$Interfaces = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
foreach ($Interface in $Interfaces) {
    Set-RegKey $Interface.PSPath "TcpAckFrequency" 1
    Set-RegKey $Interface.PSPath "TCPNoDelay" 1
}

# 2. Recuperar Espaço em Disco
Write-Host "[2/3] Liberando espaço em disco (Reservado e Hibernação)..." -ForegroundColor Cyan
try {
    powercfg -h off
    DISM.exe /Online /Set-ReservedStorageState /State:Disabled /ErrorAction SilentlyContinue | Out-Null
} catch { }

# 3. Menu de Contexto Clássico (Windows 11)
Write-Host "[3/3] Habilitando Menu de Contexto Clássico (W10 Style)..." -ForegroundColor Cyan
$ContextKey = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
Set-RegKey $ContextKey "(Default)" ""

Write-Host "--- Ajustes Avançados Concluídos! ---" -ForegroundColor Green
Write-Host "Nota: Algumas mudanças de rede só funcionam após reiniciar." -ForegroundColor DarkGray
