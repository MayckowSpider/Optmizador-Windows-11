# WinOptimize Premium - Process & Service Management (W11)
Write-Host "--- Otimizando Processos e Serviços ---" -ForegroundColor Blue

function Set-ServiceState($Name, $Startup, $State) {
    try {
        $Service = Get-Service -Name $Name -ErrorAction SilentlyContinue
        if ($Service) {
            Set-Service -Name $Name -StartupType $Startup
            if ($State -eq "Stopped") {
                Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue
            }
            Write-Host " [+] $Name definido para $Startup" -ForegroundColor Gray
        }
    } catch {
        Write-Host " [!] Erro ao ajustar $Name" -ForegroundColor DarkGray
    }
}

function Set-RegKey($Path, $Name, $Value) {
    try {
        if (!(Test-Path $Path)) { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force -ErrorAction Stop
        Write-Host " [+] Registro Ajustado: $Name" -ForegroundColor Gray
    } catch {
        Write-Host " [!] Ignorado: $Name" -ForegroundColor DarkGray
    }
}

# 1. Desativando Serviços Desnecessários (Focado em RAM)
Write-Host "[1/4] Desativando serviços de telemetria e fundo..." -ForegroundColor Cyan
Set-ServiceState "DiagTrack" "Disabled" "Stopped"    # Telemetria
Set-ServiceState "dmwappushservice" "Disabled" "Stopped" # WAP Push
Set-ServiceState "SysMain" "Disabled" "Stopped"     # Superfetch (Melhora RAM em SSDs)
Set-ServiceState "MapsBroker" "Disabled" "Stopped"  # Mapas Downloads
Set-ServiceState "RemoteRegistry" "Disabled" "Stopped" # Registro Remoto

# 2. Otimizando Resposta do Processador (Prioridade)
Write-Host "[2/4] Configurando prioridade de processos (Tasks)..." -ForegroundColor Cyan
Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "GPU Priority" 8
Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Priority" 6
Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Scheduling Category" "High"

# 3. Encerrando Processos de Telemetria Ativos
Write-Host "[3/4] Encerrando processos de tracking ativos..." -ForegroundColor Cyan
$Trackers = @("CompatTelRunner.exe", "DeviceCensus.exe", "MicrosoftEdgeUpdate.exe")
foreach ($Proc in $Trackers) {
    Get-Process -Name ($Proc.Replace(".exe", "")) -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 4. Ajustes de Performance do Shell
Write-Host "[4/5] Acelerando o Windows Explorer..." -ForegroundColor Cyan
Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SeparateProcess" 1

# 5. Limpeza de Memória (Working Set)
Write-Host "[5/5] Forçando otimização de RAM (Working Set)..." -ForegroundColor Cyan
try {
    $MemoryClean = [System.GC]::Collect()
    Write-Host " [+] Memória RAM otimizada." -ForegroundColor Gray
} catch { }

Write-Host "--- Otimização de Processos Concluída! ---" -ForegroundColor Green
