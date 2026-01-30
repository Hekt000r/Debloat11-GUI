Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# --- XAML UI Definition ---
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Debloat11" Height="500" Width="450" ResizeMode="NoResize"
        WindowStartupLocation="CenterScreen" Background="#F3F3F3" FontFamily="Segoe UI Variable Display, Segoe UI">
    
    <Grid Margin="30">
        <!-- STEP 1: START SCREEN -->
        <Grid x:Name="Step1" Visibility="Visible">
            <StackPanel VerticalAlignment="Center">
                <TextBlock Text="Debloat11" FontSize="36" FontWeight="Bold" Foreground="#0067C0" HorizontalAlignment="Center" Margin="0,0,0,10"/>
                <TextBlock Text="Remove Windows 11 bloat features and optimize your system in a few simple steps." 
                           TextWrapping="Wrap" TextAlignment="Center" FontSize="16" Foreground="#555555" Margin="0,0,0,40"/>
                <Button x:Name="BtnContinue" Content="Continue" Height="40" Width="150" 
                        Background="#0067C0" Foreground="White" FontWeight="SemiBold" FontSize="14" Cursor="Hand">
                    <Button.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="6" />
                        </Style>
                    </Button.Resources>
                </Button>
            </StackPanel>
        </Grid>

        <!-- STEP 2: SYSTEM RESTORE SCREEN -->
        <Grid x:Name="Step2" Visibility="Collapsed">
            <StackPanel VerticalAlignment="Top">
                <!-- System Restore Icon (Path) -->
                <Path Data="M13,3A9,9 0 0,0 4,12H1L4.89,15.89L4.96,16.03L9,12H6A7,7 0 0,1 13,5A7,7 0 0,1 20,12A7,7 0 0,1 13,19C11.07,19 9.32,18.21 8.06,16.94L6.64,18.36C8.27,20 10.5,21 13,21A9,9 0 0,0 22,12A9,9 0 0,0 13,3M12,8V13L16.28,15.54L17,14.33L13.5,12.25V8H12Z" 
                      Fill="#0067C0" Height="60" Width="60" Stretch="Uniform" HorizontalAlignment="Center" Margin="0,20,0,20"/>
                
                <TextBlock Text="System Restore" FontSize="24" FontWeight="SemiBold" HorizontalAlignment="Center" Margin="0,0,0,10"/>
                <TextBlock Text="A System Restore point allows you to undo changes by reverting to a previous state. This is highly recommended." 
                           TextWrapping="Wrap" TextAlignment="Center" FontSize="14" Foreground="#444444" Margin="0,0,0,30"/>
                
                <CheckBox x:Name="ChkRestore" Content="Create System Restore Point (Recommended)" 
                          IsChecked="True" FontSize="14" HorizontalAlignment="Center" Margin="0,0,0,40"/>
                
                <Button x:Name="BtnNext" Content="Next" Height="40" Width="150" 
                        Background="#0067C0" Foreground="White" FontWeight="SemiBold" FontSize="14" Cursor="Hand">
                    <Button.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="6" />
                        </Style>
                    </Button.Resources>
                </Button>
            </StackPanel>
        </Grid>

        <!-- STEP 3: CONFIRMATION SCREEN -->
        <Grid x:Name="Step3" Visibility="Collapsed">
            <StackPanel VerticalAlignment="Center">
                <TextBlock Text="Ready to start!" FontSize="28" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,0,0,10"/>
                <TextBlock Text="Debloat11 will now begin removing unnecessary features and optimizing your system based on the research script." 
                           TextWrapping="Wrap" TextAlignment="Center" FontSize="16" Foreground="#555555" Margin="0,0,0,40"/>
                <Button x:Name="BtnStart" Content="Start Debloat11" Height="42" Width="200" 
                        Background="#0067C0" Foreground="White" FontWeight="Bold" FontSize="15" Margin="0,0,0,12" Cursor="Hand">
                    <Button.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="6" />
                        </Style>
                    </Button.Resources>
                </Button>
                <Button x:Name="BtnCancel" Content="Cancel Debloat" Height="36" Width="120" 
                        Background="#E1E1E1" Foreground="#333333" FontWeight="SemiBold" FontSize="13" Cursor="Hand">
                    <Button.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="6" />
                        </Style>
                    </Button.Resources>
                </Button>
            </StackPanel>
        </Grid>

        <!-- STEP 4: PROGRESS SCREEN -->
        <Grid x:Name="Step4" Visibility="Collapsed">
            <StackPanel VerticalAlignment="Center">
                <TextBlock x:Name="TxtStatus" Text="Optimization in progress..." FontSize="20" FontWeight="SemiBold" HorizontalAlignment="Center" Margin="0,0,0,20"/>
                <ProgressBar x:Name="ProgressBar" Height="10" IsIndeterminate="True" Margin="0,0,0,20">
                    <ProgressBar.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="5" />
                        </Style>
                    </ProgressBar.Resources>
                </ProgressBar>
                <TextBlock x:Name="TxtLog" Text="Preparing..." FontSize="12" Foreground="#888888" HorizontalAlignment="Center" TextWrapping="Wrap" TextAlignment="Center"/>
            </StackPanel>
        </Grid>

        <!-- STEP 5: COMPLETED SCREEN -->
        <Grid x:Name="Step5" Visibility="Collapsed">
            <StackPanel VerticalAlignment="Center">
                <TextBlock Text="Operation Completed!" FontSize="28" FontWeight="Bold" HorizontalAlignment="Center" Foreground="#28A745" Margin="0,0,0,10"/>
                <TextBlock Text="Your Windows 11 system has been optimized. A system restart is required for all changes to take effect." 
                           TextWrapping="Wrap" TextAlignment="Center" FontSize="16" Foreground="#555555" Margin="0,0,0,40"/>
                <Button x:Name="BtnFinish" Content="Finish" Height="42" Width="150" 
                        Background="#0067C0" Foreground="White" FontWeight="Bold" FontSize="15" Cursor="Hand">
                    <Button.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="6" />
                        </Style>
                    </Button.Resources>
                </Button>
            </StackPanel>
        </Grid>
    </Grid>
</Window>
"@

# --- Admin Check ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $response = [System.Windows.MessageBox]::Show("This script requires Administrator privileges to perform debloating. Do you want to restart as Admin?", "Admin Required", "YesNo", "Warning")
    if ($response -eq 'Yes') {
        # The -Wait is CRITICAL for IExpress builds to prevent temp folder cleanup
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -Wait
    }
    exit
}

# Helper function to load XAML
$reader = [XML.XmlReader]::Create([IO.StringReader]::new($xaml))
$window = [Windows.Markup.XamlReader]::Load($reader)

# Map Elements
$step1 = $window.FindName("Step1")
$step2 = $window.FindName("Step2")
$step3 = $window.FindName("Step3")
$step4 = $window.FindName("Step4")
$step5 = $window.FindName("Step5")

$btnContinue = $window.FindName("BtnContinue")
$btnNext = $window.FindName("BtnNext")
$btnStart = $window.FindName("BtnStart")
$btnCancel = $window.FindName("BtnCancel")
$btnFinish = $window.FindName("BtnFinish")
$chkRestore = $window.FindName("ChkRestore")
$progressBar = $window.FindName("ProgressBar")
$txtStatus = $window.FindName("TxtStatus")
$txtLog = $window.FindName("TxtLog")

# --- Logic Functions ---

# Use a synchronized hashtable for thread-safe communication
$SyncHash = [hashtable]::Synchronized(@{})
$SyncHash.Window = $window
$SyncHash.TxtStatus = $txtStatus
$SyncHash.TxtLog = $txtLog
$SyncHash.ProgressBar = $progressBar
$SyncHash.Step1 = $step1
$SyncHash.Step2 = $step2
$SyncHash.Step3 = $step3
$SyncHash.Step4 = $step4
$SyncHash.Step5 = $step5

function Switch-Step($targetName) {
    $SyncHash.Window.Dispatcher.Invoke({
        $SyncHash.Step1.Visibility = "Collapsed"
        $SyncHash.Step2.Visibility = "Collapsed"
        $SyncHash.Step3.Visibility = "Collapsed"
        $SyncHash.Step4.Visibility = "Collapsed"
        $SyncHash.Step5.Visibility = "Collapsed"
        
        $target = $SyncHash.$targetName
        if ($target) { $target.Visibility = "Visible" }
    })
}

function Write-Log($message, $status = $null) {
    if ($SyncHash.Window) {
        $SyncHash.Window.Dispatcher.Invoke({
            if ($status) { $SyncHash.TxtStatus.Text = $status }
            $SyncHash.TxtLog.Text = $message
        })
    }
}

function Set-RegValue-Inner {
    param ($Path, $Name, $Value, $Type = "DWord")
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

function Invoke-Debloat {
    param($SyncHash, $shouldRestore)
    
    # We need to redefine helper functions inside the runspace if they aren't passed
    function Internal-Log($msg, $stat = $null) {
        $SyncHash.Window.Dispatcher.Invoke({
            if ($stat) { $SyncHash.TxtStatus.Text = $stat }
            $SyncHash.TxtLog.Text = $msg
        })
    }
    
    function Internal-Step($name) {
        $SyncHash.Window.Dispatcher.Invoke({
            $SyncHash.Step1.Visibility = "Collapsed"
            $SyncHash.Step2.Visibility = "Collapsed"
            $SyncHash.Step3.Visibility = "Collapsed"
            $SyncHash.Step4.Visibility = "Collapsed"
            $SyncHash.Step5.Visibility = "Collapsed"
            $target = $SyncHash.$name
            if ($target) { $target.Visibility = "Visible" }
        })
    }

    try {
        Internal-Log "Initializing..." "Processing..."
        
        # 1. System Restore
        if ($shouldRestore) {
            Internal-Log "Action: Creating System Restore Point..."
            try {
                Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
                Checkpoint-Computer -Description "Debloat 11 Backup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
            } catch {
                Internal-Log "Warning: Could not create restore point. Continuing..."
            }
        }

        # 2. Lists & Definitions
        $Whitelist = @(
            "Microsoft.WindowsTerminal", "Microsoft.XboxIdentityProvider", "Microsoft.WebView2Runtime",
            "Microsoft.StartExperiencesApp", "Microsoft.Windows.ShellExperienceHost", "Microsoft.VCLibs",
            "Microsoft.UI.Xaml", "Microsoft.NET.Native.Framework", "Microsoft.NET.Native.Runtime",
            "Microsoft.WindowsStore", "Microsoft.Windows.Photos", "Microsoft.WindowsCalculator", "Microsoft.Windows.Notepad"
        )

        $Blacklist = @(
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
            "Microsoft.XboxApp", "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay", 
            "Microsoft.XboxSpeechToTextOverlay", "Microsoft.WindowsSoundRecorder",
            "Microsoft.QuickAssist", "Microsoft.ParentalControls",
            "Microsoft.VP9VideoExtensions", "Microsoft.WebMediaExtensions", "Microsoft.HEIFImageExtension", 
            "Microsoft.RawImageExtension", "Microsoft.Paint", "Microsoft.Services.Store.Engagement", "Microsoft.AsyncTextService",
            "MicrosoftWindows.Client.WebExperience", # Windows 11 Widgets
            "Microsoft.Windows.Ai.Shell.Desktop", "Microsoft.Copilot" # AI & Copilot logic
        )

        $Capabilities = @(
            "App.Support.QuickAssist~~~~0.0.1.0", "App.StepsRecorder~~~~0.0.1.0", "Hello.Face~~~~0.0.1.0",
            "MathRecognizer~~~~0.0.1.0", "OneCoreUAP.OneSync~~~~0.0.1.0", "OpenSSH.Client~~~~0.0.1.0",
            "Msix.PackagingTool.Driver~~~~0.0.1.0", "Browser.InternetExplorer~~~~0.0.1.0"
        )

        # 3. App Removal
        $total = $Blacklist.Count
        $current = 0
        foreach ($AppPattern in $Blacklist) {
            $current++
            if ($Whitelist -match [regex]::Escape($AppPattern)) { continue }
            
            Internal-Log "AppX removal: $AppPattern"
            try {
                $Provisioned = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -match $AppPattern }
                $Installed = Get-AppxPackage -Name $AppPattern -AllUsers -ErrorAction SilentlyContinue
                
                if ($Provisioned -or $Installed) {
                    if ($Provisioned) { 
                        foreach($p in $Provisioned) {
                            Remove-AppxProvisionedPackage -Online -PackageName $p.PackageName -ErrorAction Stop 
                        }
                    }
                    if ($Installed) { 
                        Remove-AppxPackage -Package $Installed.PackageFullName -AllUsers -ErrorAction Stop 
                    }
                }
            } catch {
                Internal-Log "Warning: Failed to remove $AppPattern. Proceeding..."
                Start-Sleep -Seconds 2
            }
        }

        # 4. Capabilities Removal
        foreach ($CapName in $Capabilities) {
            Internal-Log "Action: Removing Capability $CapName"
            $Cap = Get-WindowsCapability -Online -Name $CapName -ErrorAction SilentlyContinue
            if ($Cap -and $Cap.State -eq "Installed") {
                Remove-WindowsCapability -Online -Name $CapName -ErrorAction SilentlyContinue
            }
        }

        # 5. Service & Task Optimization
        $Services = @("DiagTrack", "SysMain", "WpcMonService", "dmwappushservice", "OneSyncSvc", "MapsBroker", "lfsvc")
        foreach ($Svc in $Services) {
            if (Get-Service -Name $Svc -ErrorAction SilentlyContinue) {
                Internal-Log "Action: Stopping Service $Svc"
                Stop-Service -Name $Svc -Force -ErrorAction SilentlyContinue
                Set-Service -Name $Svc -StartupType Disabled -ErrorAction SilentlyContinue
            }
        }

        $Tasks = @(
            "\Microsoft\Windows\Application Experience\", "\Microsoft\Windows\Customer Experience Improvement Program\",
            "\Microsoft\Windows\Feedback\", "\Microsoft\Windows\Maps\", "\Microsoft\Windows\CloudExperienceHost\"
        )
        foreach ($tp in $Tasks) {
            Internal-Log "Action: Disabling Task Path $tp"
            $ts = Get-ScheduledTask -TaskPath $tp -ErrorAction SilentlyContinue
            if ($ts) { $ts | Disable-ScheduledTask -ErrorAction SilentlyContinue }
        }

        # 6. Deep Telemetry & Registry
        Internal-Log "Action: Applying Deep Registry Blocks..."
        $regFix = {
            param($p, $n, $v, $t="DWord")
            if (-not (Test-Path $p)) { New-Item -Path $p -Force | Out-Null }
            Set-ItemProperty -Path $p -Name $n -Value $v -Type $t -Force
        }
        
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "DisableWebSearch" 1
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0
        
        # Windows Widgets Removal
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0
        
        # Disable Search Highlights (Weather/News in search box)
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDynamicSearchBoxEnabled" 0
        
        # Disable Tailored Experiences
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" 0
        
        # Disable Activity History
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0

        # --- EDGE DEBLOATING (DuckDuckGo & Optimization) ---
        Internal-Log "Action: Debloating Microsoft Edge..."
        $edgeKey = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
        &$regFix $edgeKey "DefaultSearchProviderEnabled" 1
        &$regFix $edgeKey "DefaultSearchProviderName" "DuckDuckGo"
        &$regFix $edgeKey "DefaultSearchProviderSearchURL" "https://duckduckgo.com/?q={searchTerms}"
        &$regFix $edgeKey "HomepageLocation" "https://duckduckgo.com" "String"
        &$regFix $edgeKey "RestoreOnStartup" 4 # Open a list of URLs
        &$regFix $edgeKey "RestoreOnStartupURLs" "https://duckduckgo.com" "String"
        &$regFix $edgeKey "HideFirstRunExperience" 1
        &$regFix $edgeKey "EdgeCollectionsEnabled" 0
        &$regFix $edgeKey "DiscoverPageContextEnabled" 0
        &$regFix $edgeKey "HubsSidebarEnabled" 0 # Removes Copilot sidebar
        &$regFix $edgeKey "MetricsReportingEnabled" 0 # Disable Telemetry
        &$regFix $edgeKey "PersonalizationReportingEnabled" 0 # Disable Data Collection
        
        # --- ROBUST AI & COPILOT REMOVAL ---
        Internal-Log "Action: Disabling Copilot and AI elements..."
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton" 0
        &$regFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1
        &$regFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RemindMeAboutWindowsCopilot" 0
        
        # UI Hardening: Classic Context Menu
        if (-not (Test-Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")) {
            New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force | Out-Null
        }

        Internal-Log "Action: Optimizing Windows Defender..."
        Set-MpPreference -ScanAvgCPULoadFactor 20 -MAPSReporting Disabled -ErrorAction SilentlyContinue

        # 7. Finalization
        Internal-Log "Action: Running System Health Check..."
        DISM /Online /Cleanup-Image /CheckHealth | Out-Null

        Internal-Log "Complete!" "Optimization Finished"
        Internal-Step "Step5"
    } catch {
        Internal-Log "Error occurred: $($_.Exception.Message)" "Error"
    }
}

# --- Event Handlers ---

$btnContinue.Add_Click({ Switch-Step "Step2" })
$btnNext.Add_Click({ Switch-Step "Step3" })
$btnCancel.Add_Click({ $window.Close() })
$btnFinish.Add_Click({ $window.Close() })

$btnStart.Add_Click({
    $shouldRestore = $chkRestore.IsChecked
    Switch-Step "Step4"
    
    $rs = [runspacefactory]::CreateRunspace()
    $rs.ApartmentState = "STA"
    $rs.ThreadOptions = "ReuseThread"
    $rs.Open()
    
    $ps = [powershell]::Create()
    $ps.Runspace = $rs
    $ps.AddScript(${function:Invoke-Debloat}).AddArgument($SyncHash).AddArgument($shouldRestore)
    
    $ps.BeginInvoke()
})

# Show Window
$window.ShowDialog() | Out-Null
