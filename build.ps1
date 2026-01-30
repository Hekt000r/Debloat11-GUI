# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[ERROR] Administrator privileges required." -ForegroundColor Red
    Write-Host "Please right-click and select 'Run as Administrator'."
    Start-Sleep -Seconds 3
    exit
}

$ErrorActionPreference = "Stop"
$ScriptPath = $PSScriptRoot
$ScriptName = "Debloat11.ps1"
$ExeName = "Debloat11.exe"
$Source = Join-Path $ScriptPath $ScriptName
$Target = Join-Path $ScriptPath $ExeName

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "          Debloat11-GUI Build System (ps2exe)" -ForegroundColor Cyan
Write-Host "============================================================"
Write-Host ""

if (-not (Test-Path $Source)) {
    Write-Host "[ERROR] Source file '$ScriptName' not found!" -ForegroundColor Red
    Start-Sleep 3
    exit
}

# Check/Install ps2exe Module (correct name)
if (-not (Get-Module -ListAvailable -Name ps2exe)) {
    Write-Host "[INIT] ps2exe module not found. Installing from PSGallery..." -ForegroundColor Yellow
    try {
        # Trust PSGallery if needed
        $repo = Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue
        if ($repo.InstallationPolicy -ne 'Trusted') {
            Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
        }
        
        Install-Module -Name ps2exe -Scope CurrentUser -Force -AllowClobber
        Write-Host "[INIT] Module installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to install ps2exe module." -ForegroundColor Red
        Write-Host "Error details: $_"
        Start-Sleep 5
        exit
    }
}

# Compile EXE
try {
    Write-Host "[BUILD] Compiling '$ScriptName' to '$ExeName'..." -ForegroundColor Cyan
    
    # Import Module
    Import-Module ps2exe
    
    # Run Build using Invoke-ps2exe
    # -noConsole: Hides the console window
    # -requireAdmin: Adds manifest to require Admin privileges
    # -x64: Targets 64-bit architecture
    Invoke-ps2exe -inputFile $Source -outputFile $Target -noConsole -requireAdmin -x64
    
    if (Test-Path $Target) {
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host "[SUCCESS] Build Complete: $ExeName" -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor Green
    } else {
        throw "Target file was not created."
    }

} catch {
    Write-Host ""
    Write-Host "[ERROR] Build compilation failed." -ForegroundColor Red
    Write-Host "Error details: $_"
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
