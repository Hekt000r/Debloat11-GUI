<#
.SYNOPSIS
    Windows 11 Research Debloat Tool (Balanced / Extended Edition)
    
    PURPOSE: Comprehensive system optimization with stability checks.
    SCOPE: Block Bloat/Telemetry but KEEP Photos, Calc, Notepad, and Xbox Foundation.
    POLICY: Efficiency focused but User-Friendly.
    REQUIREMENTS: Administrator Privileges.
#>

# Ensure Administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator."
    Pause
    Exit
}

# --- Helper Functions ---
function Set-RegValue {
    param (
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = "DWord"
    )
    if (-not (Test-Path $Path)) {
        try { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null } catch { return }
    }
    try {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force -ErrorAction Stop
    } catch {
        if ($Name -eq "(Default)") {
            try { Set-Item -Path $Path -Value $Value -Force -ErrorAction Stop } catch { }
        }
    }
}

function Disable-SchTask {
    param ([string]$TaskPath)
    $Task = Get-ScheduledTask -TaskPath $TaskPath -ErrorAction SilentlyContinue
    if ($Task) {
        $Task | Disable-ScheduledTask -ErrorAction SilentlyContinue
        Write-Host "  [DISABLED TASK] $TaskPath" -ForegroundColor DarkGray
    }
}

function Remove-WinCap {
    param ([string]$Name)
    $Cap = Get-WindowsCapability -Online -Name $Name -ErrorAction SilentlyContinue
    if ($Cap -and $Cap.State -eq "Installed") {
        Write-Host "  [REMOVING CAPABILITY] $Name" -ForegroundColor Yellow
        Remove-WindowsCapability -Online -Name $Name -ErrorAction SilentlyContinue
        return $true
    }
    return $false
}

# Safety Confirmation
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "                     Debloat 11                           " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " RETAINED: Photos, Calculator, Notepad, Xbox (Installable)" -ForegroundColor Green
Write-Host ""
$Confirm = Read-Host "Proceed with optimization? (y/n)"
if ($Confirm -ne "y") { Write-Host "Cancelled."; Exit }

# System Restore Point
$Restore = Read-Host "Create a System Restore Point? (Recommended) (y/n)"
if ($Restore -eq "y") {
    Write-Host "  [INIT] Creating System Restore Point (This may take a moment)..." -ForegroundColor Yellow
    try {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description "Debloat 11 Backup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Host "  [SUCCESS] Restore Point Created." -ForegroundColor Green
    } catch {
        Write-Warning "Failed to create Restore Point. Ensure System Protection is enabled manually if desired."
        Write-Host "  Error data: $_" -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

# 1. Metrics Baseline
Write-Host "`n[1/7] Gathering baseline metrics..." -ForegroundColor Green
$PreProcessCount = (Get-Process).Count


# 2. Lists & Definitions
Write-Host "[2/7] Initializing Definition Lists..." -ForegroundColor Green

$Whitelist = @(
    "Microsoft.WindowsTerminal", "Microsoft.XboxIdentityProvider", "Microsoft.WebView2Runtime",
    "Microsoft.StartExperiencesApp", "Microsoft.Windows.ShellExperienceHost", "Microsoft.VCLibs",
    "Microsoft.UI.Xaml", "Microsoft.NET.Native.Framework", "Microsoft.NET.Native.Runtime",
    "Microsoft.WindowsStore", 
    # User Request: Explicitly Keep these
    "Microsoft.Windows.Photos", "Microsoft.WindowsCalculator", "Microsoft.Windows.Notepad"
)

$Blacklist = @(
    # Standard Bloat
    "Microsoft.BingNews", "Microsoft.BingWeather", "Clipchamp.Clipchamp", 
    "Microsoft.MicrosoftSolitaireCollection", "Microsoft.Teams", "Microsoft.OutlookForWindows", 
    "Microsoft.PowerAutomateDesktop", "Microsoft.Todos", "Microsoft.WindowsStickyNotes", 
    "Microsoft.WindowsFeedbackHub", "Microsoft.WindowsMaps", "Microsoft.YourPhone",
    "Microsoft.ZuneMusic", "Microsoft.ZuneVideo", "Microsoft.MicrosoftOfficeHub",
    "Microsoft.Office.OneNote", "Microsoft.GetHelp", "Microsoft.People", 
    "Microsoft.MixedReality.Portal", "Microsoft.ScreenSketch", "Microsoft.Paint3D",
    "Microsoft.WindowsAlarms", "Microsoft.WindowsCamera", "Microsoft.WindowsConsole",
    "Microsoft.Getstarted", "Microsoft.GamingApp", "Microsoft.MicrosoftStickyNotes",
    "Microsoft.OneConnect", "Microsoft.Print3D", "Microsoft.SkypeApp",
    "Microsoft.Wallet", "Microsoft.BingSearch", "Microsoft.549981C3F5F10",
    
    # Extended Scope (Gaming, Productivity, Tools)
    "Microsoft.XboxApp", "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay", 
    "Microsoft.XboxSpeechToTextOverlay", "Microsoft.WindowsSoundRecorder",
    "Microsoft.QuickAssist", "Microsoft.ParentalControls",
    
    # Extended Scope (Codecs, Extensions, Legacy)
    "Microsoft.VP9VideoExtensions", "Microsoft.WebMediaExtensions", "Microsoft.HEIFImageExtension", 
    "Microsoft.RawImageExtension", "Microsoft.Paint", 
    "Microsoft.ScreenSketch", "Microsoft.Services.Store.Engagement", "Microsoft.AsyncTextService"

    # NOTE: Protected SystemApps excluded to avoid errors
)

$Capabilities = @(
    "App.Support.QuickAssist~~~~0.0.1.0", "App.StepsRecorder~~~~0.0.1.0", "Hello.Face~~~~0.0.1.0",
    "MathRecognizer~~~~0.0.1.0", "OneCoreUAP.OneSync~~~~0.0.1.0", "OpenSSH.Client~~~~0.0.1.0",
    "Msix.PackagingTool.Driver~~~~0.0.1.0", "Browser.InternetExplorer~~~~0.0.1.0"
)

# 3. App Removal
Write-Host "[3/7] Scanning and Removing Apps..." -ForegroundColor Green
$AppsRemovedCount = 0
$AppsChecked = 0
foreach ($AppPattern in $Blacklist) {
    if ($Whitelist -match $AppPattern) { continue }
    $AppsChecked++
    
    $Provisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -match $AppPattern }
    $Installed = Get-AppxPackage -Name $AppPattern -AllUsers
    
    if ($Provisioned -or $Installed) {
        Write-Host "  [REMOVING] $AppPattern" -ForegroundColor Yellow
        if ($Provisioned) { $Provisioned | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue } }
        if ($Installed) { Remove-AppxPackage -Package $Installed.PackageFullName -AllUsers -ErrorAction SilentlyContinue }
        $AppsRemovedCount++
    }
}
Write-Host "  > Scanned $AppsChecked targets. Removed $AppsRemovedCount items." -ForegroundColor Gray

# 4. Capabilities Removal
Write-Host "[4/7] Managing Windows Capabilities..." -ForegroundColor Green
$CapsRemoved = 0
foreach ($CapName in $Capabilities) {
    if (Remove-WinCap -Name $CapName) { $CapsRemoved++ }
}
Write-Host "  > Capabilities removed: $CapsRemoved" -ForegroundColor Gray

# 5. Service & Task Optimization
Write-Host "[5/7] Optimizing Services and Tasks..." -ForegroundColor Green
# NOTE: Removed Xbox services (XblAuthManager etc) from this list to allow re-installation
$Services = @("DiagTrack", "SysMain", "WpcMonService", "dmwappushservice", "OneSyncSvc", "MapsBroker", "lfsvc")
foreach ($Svc in $Services) {
    if (Get-Service -Name $Svc -ErrorAction SilentlyContinue) {
        Stop-Service -Name $Svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $Svc -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "  [STOPPED SCOPE] $Svc" -ForegroundColor DarkGray
    }
}

Disable-SchTask "\Microsoft\Windows\Application Experience\"
Disable-SchTask "\Microsoft\Windows\Customer Experience Improvement Program\"
Disable-SchTask "\Microsoft\Windows\Feedback\"
Disable-SchTask "\Microsoft\Windows\Maps\"
Disable-SchTask "\Microsoft\Windows\CloudExperienceHost\"

# 6. Deep Telemetry & Consumer Reset
Write-Host "[6/7] Applying Deep Registry Blocks..." -ForegroundColor Green

# Telemetry
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "DisableWebSearch" 1

# Consumer Features
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

# UI Hardening
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0

# Defender Only (Notepad redirect removed per user request)
Set-MpPreference -ScanAvgCPULoadFactor 20 -MAPSReporting Disabled -ErrorAction SilentlyContinue

# Hardware Bypasses Removed per user request

# 7. Finalization
Write-Host "[7/7] Generating Report..." -ForegroundColor Green
Start-Sleep -Seconds 3
$PostProcessCount = (Get-Process).Count
Write-Host " Process Count:      $PreProcessCount -> $PostProcessCount"
Write-Host "================================================" -ForegroundColor Cyan

DISM /Online /Cleanup-Image /CheckHealth
Write-Host "`nSystem Optimization Complete. RESTART REQUIRED." -ForegroundColor Green
Pause
