Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# --- Global Item Definitions ---
$GlobalWhitelist = @(
    "Microsoft.WindowsTerminal", "Microsoft.XboxIdentityProvider", "Microsoft.WebView2Runtime",
    "Microsoft.StartExperiencesApp", "Microsoft.Windows.ShellExperienceHost", "Microsoft.VCLibs",
    "Microsoft.UI.Xaml", "Microsoft.NET.Native.Framework", "Microsoft.NET.Native.Runtime",
    "Microsoft.WindowsStore", "Microsoft.Windows.Photos", "Microsoft.WindowsCalculator", "Microsoft.Windows.Notepad"
)

$GlobalBlacklist = @(
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

$GlobalCapabilities = @(
    "App.Support.QuickAssist~~~~0.0.1.0", "App.StepsRecorder~~~~0.0.1.0", "Hello.Face~~~~0.0.1.0",
    "MathRecognizer~~~~0.0.1.0", "OneCoreUAP.OneSync~~~~0.0.1.0", "OpenSSH.Client~~~~0.0.1.0",
    "Msix.PackagingTool.Driver~~~~0.0.1.0", "Browser.InternetExplorer~~~~0.0.1.0"
)

$GlobalServices = @("DiagTrack", "SysMain", "WpcMonService", "dmwappushservice", "MapsBroker", "lfsvc")

$GlobalTasks = @(
    "\Microsoft\Windows\Application Experience\", "\Microsoft\Windows\Customer Experience Improvement Program\",
    "\Microsoft\Windows\Feedback\", "\Microsoft\Windows\Maps\", "\Microsoft\Windows\CloudExperienceHost\"
)

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

                <Button x:Name="BtnAdvanced" Content="Advanced install" Height="36" Width="180" 
                        Background="Transparent" Foreground="#0067C0" BorderBrush="#0067C0" BorderThickness="1" 
                        FontWeight="SemiBold" FontSize="13" Margin="0,0,0,20" Cursor="Hand">
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

        <!-- STEP ADVANCED: SELECTION SCREEN -->
        <Grid x:Name="StepAdvanced" Visibility="Collapsed">
            <StackPanel VerticalAlignment="Top">
                <TextBlock Text="Advanced Selection" FontSize="24" FontWeight="SemiBold" HorizontalAlignment="Center" Margin="0,0,0,2"/>
                <TextBlock Text="This is for advanced users" FontSize="12" Foreground="#888888" HorizontalAlignment="Center" Margin="0,0,0,10"/>
                <ScrollViewer Height="300" Margin="0,0,0,10">
                    <StackPanel x:Name="AdvancedSelectionList" Margin="10,0,10,0">
                        <!-- Categories will be dynamically populated here or hardcoded for simplicity in XAML -->
                        <Expander Header="Bloatware Apps (AppX)" IsExpanded="False" Margin="0,2">
                            <StackPanel x:Name="ListAppX" Margin="20,5,0,5"/>
                        </Expander>
                        <Expander Header="Optional Capabilities" IsExpanded="False" Margin="0,2">
                            <StackPanel x:Name="ListCaps" Margin="20,5,0,5"/>
                        </Expander>
                        <Expander Header="Optimization Services" IsExpanded="False" Margin="0,2">
                            <StackPanel x:Name="ListSvc" Margin="20,5,0,5"/>
                        </Expander>
                        <Expander Header="System Settings &amp; Privacy" IsExpanded="False" Margin="0,2">
                            <StackPanel Margin="20,5,0,5">
                                <CheckBox x:Name="OptReg" Content="Apply Privacy Registry Fixes" IsChecked="True" Margin="0,5"/>
                                <CheckBox x:Name="OptEdge" Content="Aggressive Edge Debloating" IsChecked="True" Margin="0,5"/>
                                <CheckBox x:Name="OptAI" Content="Disable Copilot &amp; AI Components" IsChecked="True" Margin="0,5"/>
                                <CheckBox x:Name="OptDefender" Content="Optimize Windows Defender" IsChecked="True" Margin="0,5"/>
                                <CheckBox x:Name="OptHealth" Content="Run System Health Check" IsChecked="True" Margin="0,5"/>
                            </StackPanel>
                        </Expander>
                    </StackPanel>
                </ScrollViewer>
                
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Center">
                    <Button x:Name="BtnBack" Content="Back" Height="38" Width="100" Margin="0,0,10,0"
                            Background="#E1E1E1" Foreground="#333333" FontWeight="SemiBold" FontSize="14" Cursor="Hand">
                        <Button.Resources>
                            <Style TargetType="Border"><Setter Property="CornerRadius" Value="6" /></Style>
                        </Button.Resources>
                    </Button>
                    <Button x:Name="BtnStartAdvanced" Content="Start Selected" Height="38" Width="150" 
                            Background="#0067C0" Foreground="White" FontWeight="Bold" FontSize="14" Cursor="Hand">
                        <Button.Resources>
                            <Style TargetType="Border"><Setter Property="CornerRadius" Value="6" /></Style>
                        </Button.Resources>
                    </Button>
                </StackPanel>
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
$stepAdvanced = $window.FindName("StepAdvanced")
$step4 = $window.FindName("Step4")
$step5 = $window.FindName("Step5")

$btnContinue = $window.FindName("BtnContinue")
$btnNext = $window.FindName("BtnNext")
$btnStart = $window.FindName("BtnStart")
$btnAdvanced = $window.FindName("BtnAdvanced")
$btnBack = $window.FindName("BtnBack")
$btnStartAdvanced = $window.FindName("BtnStartAdvanced")
$btnCancel = $window.FindName("BtnCancel")
$btnFinish = $window.FindName("BtnFinish")
$chkRestore = $window.FindName("ChkRestore")
$progressBar = $window.FindName("ProgressBar")
$txtStatus = $window.FindName("TxtStatus")
$txtLog = $window.FindName("TxtLog")

# Options Panels for dynamic population
$listAppX = $window.FindName("ListAppX")
$listCaps = $window.FindName("ListCaps")
$listSvc = $window.FindName("ListSvc")

# Options Checkboxes (Static)
$optReg = $window.FindName("OptReg")
$optEdge = $window.FindName("OptEdge")
$optAI = $window.FindName("OptAI")
$optDefender = $window.FindName("OptDefender")
$optHealth = $window.FindName("OptHealth")

# Dynamic UI Helper
function Add-SelectionItem($panel, $name, $value) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Content = $value
    $cb.Name = "Auto_" + ($value -replace '[^a-zA-Z0-9]', '_')
    $cb.IsChecked = $true
    $cb.Margin = "0,2"
    $cb.Tag = $value # Store original value
    $panel.Children.Add($cb) | Out-Null
    return $cb
}

$dynamicAppX = foreach ($app in $GlobalBlacklist) { Add-SelectionItem $listAppX "AppX" $app }
$dynamicCaps = foreach ($cap in $GlobalCapabilities) { Add-SelectionItem $listCaps "Caps" $cap }
$dynamicSvc = foreach ($svc in $GlobalServices) { Add-SelectionItem $listSvc "Svc" $svc }

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
$SyncHash.StepAdvanced = $stepAdvanced
$SyncHash.Step4 = $step4
$SyncHash.Step5 = $step5

function Switch-Step($targetName) {
    $SyncHash.Window.Dispatcher.Invoke({
        $SyncHash.Step1.Visibility = "Collapsed"
        $SyncHash.Step2.Visibility = "Collapsed"
        $SyncHash.Step3.Visibility = "Collapsed"
        $SyncHash.StepAdvanced.Visibility = "Collapsed"
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
    param($SyncHash, $shouldRestore, $Options)
    
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
            $SyncHash.StepAdvanced.Visibility = "Collapsed"
            $SyncHash.Step4.Visibility = "Collapsed"
            $SyncHash.Step5.Visibility = "Collapsed"
            $target = $SyncHash.$name
            if ($target) { $target.Visibility = "Visible" }
        })
    }

    try {
        Internal-Log "Initializing..." "Processing..."
        
        $InternalRegFix = {
            param($path, $name, $value, $type="DWord")
            if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
            Set-ItemProperty -Path $path -Name $name -Value $value -Type $type -Force
        }
        
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
        $Whitelist = $Options.Whitelist # Use the passed whitelist

        # 3. App Removal
        if ($Options.AppX) {
            foreach ($AppPattern in $Options.AppXList) {
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
        }

        # 4. Capabilities Removal
        if ($Options.Caps) {
            foreach ($CapName in $Options.CapsList) {
                Internal-Log "Action: Removing Capability $CapName"
                $Cap = Get-WindowsCapability -Online -Name $CapName -ErrorAction SilentlyContinue
                if ($Cap -and $Cap.State -eq "Installed") {
                    Remove-WindowsCapability -Online -Name $CapName -ErrorAction SilentlyContinue
                }
            }
        }

        # 5. Service & Task Optimization
        if ($Options.Svc) {
            foreach ($Svc in $Options.SvcList) {
                if (Get-Service -Name $Svc -ErrorAction SilentlyContinue) {
                    Internal-Log "Action: Stopping Service $Svc"
                    Stop-Service -Name $Svc -Force -ErrorAction SilentlyContinue
                    Set-Service -Name $Svc -StartupType Disabled -ErrorAction SilentlyContinue
                }
            }

            $Tasks = $Options.Tasks
            foreach ($tp in $Tasks) {
                Internal-Log "Action: Disabling Task Path $tp"
                $ts = Get-ScheduledTask -TaskPath $tp -ErrorAction SilentlyContinue
                if ($ts) { $ts | Disable-ScheduledTask -ErrorAction SilentlyContinue }
            }
        }

        # 6. Deep Telemetry & Registry
        if ($Options.Reg) {
            Internal-Log "Action: Applying Deep Registry Blocks..."
            
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "DisableWebSearch" 1
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0
            
            # Windows Widgets Removal
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0
            
            # Disable Search Highlights (Weather/News in search box)
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDynamicSearchBoxEnabled" 0
            
            # Disable Tailored Experiences
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" 0
            
            # Disable Activity History
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0

            # --- LONG-TERM UPDATE PAUSE (Unlocking Options) ---
            Internal-Log "Action: Unlocking long-term update pause options..."
            $updateKey = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
            &$InternalRegFix $updateKey "FlightSettingsMaxPauseDays" 30000
        }


        # --- EDGE DEBLOATING (Ultra-Aggressive Edge-Debloat Policies) ---
        if ($Options.Edge) {
            Internal-Log "Action: Applying Ultra-Aggressive Edge Policies..."
            
            $edgeKey = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
            
            # 1. Search & Homepage (DuckDuckGo + Hardening)
            &$InternalRegFix $edgeKey "DefaultSearchProviderEnabled" 1
            &$InternalRegFix $edgeKey "DefaultSearchProviderName" "DuckDuckGo" "String"
            &$InternalRegFix $edgeKey "DefaultSearchProviderSearchURL" "https://duckduckgo.com/?q={searchTerms}" "String"
            &$InternalRegFix $edgeKey "DefaultSearchProviderKeyword" "ddg" "String"
            &$InternalRegFix $edgeKey "DefaultSearchProviderSuggestURL" "https://duckduckgo.com/ac/?q={searchTerms}" "String"
            &$InternalRegFix $edgeKey "HomepageLocation" "https://duckduckgo.com" "String"
            &$InternalRegFix $edgeKey "RestoreOnStartup" 4
            &$InternalRegFix $edgeKey "RestoreOnStartupURLs" "https://duckduckgo.com" "String"
            &$InternalRegFix $edgeKey "NewTabPageLocation" "https://duckduckgo.com" "String"
            &$InternalRegFix $edgeKey "NewTabPageSearchBox" "redirect" "String"
            
            # 2. Privacy & Telemetry Hardening
            &$InternalRegFix $edgeKey "MetricsReportingEnabled" 0
            &$InternalRegFix $edgeKey "PersonalizationReportingEnabled" 0
            &$InternalRegFix $edgeKey "DiagnosticData" 0
            &$InternalRegFix $edgeKey "Edge3PSerpTelemetryEnabled" 0
            &$InternalRegFix $edgeKey "ExperimentationAndConfigurationServiceControl" 0
            &$InternalRegFix $edgeKey "SearchSuggestEnabled" 0
            &$InternalRegFix $edgeKey "TrackingPrevention" 3
            &$InternalRegFix $edgeKey "ConfigureDoNotTrack" 1
            &$InternalRegFix $edgeKey "AlternateErrorPagesEnabled" 0
            &$InternalRegFix $edgeKey "ResolveNavigationErrorsUseWebService" 0
            
            # 3. Features & Sidebar Disabling
            &$InternalRegFix $edgeKey "HubsSidebarEnabled" 0
            &$InternalRegFix $edgeKey "SearchInSidebarEnabled" 2 # 2 = Disabled
            &$InternalRegFix $edgeKey "StandaloneHubsSidebarEnabled" 0
            &$InternalRegFix $edgeKey "EdgeCollectionsEnabled" 0
            &$InternalRegFix $edgeKey "ShoppingListEnabled" 0
            &$InternalRegFix $edgeKey "EdgeShoppingAssistantEnabled" 0
            &$InternalRegFix $edgeKey "ShowMicrosoftRewards" 0
            &$InternalRegFix $edgeKey "WalletDonationEnabled" 0
            &$InternalRegFix $edgeKey "EdgeWalletCheckoutEnabled" 0
            &$InternalRegFix $edgeKey "EdgeWorkspacesEnabled" 0
            &$InternalRegFix $edgeKey "SplitScreenEnabled" 0
            &$InternalRegFix $edgeKey "TabServicesEnabled" 0
            &$InternalRegFix $edgeKey "TranslateEnabled" 0
            &$InternalRegFix $edgeKey "QuickViewOfficeFilesEnabled" 0
            &$InternalRegFix $edgeKey "ReadAloudEnabled" 0
            &$InternalRegFix $edgeKey "LiveCaptionsAllowed" 0
            &$InternalRegFix $edgeKey "SpeechRecognitionEnabled" 0
            &$InternalRegFix $edgeKey "AccessibilityImageLabelsEnabled" 0
            
            # 4. AI & Copilot Elements
            &$InternalRegFix $edgeKey "CopilotPageContext" 0
            &$InternalRegFix $edgeKey "CopilotPageContextEnabled" 0
            &$InternalRegFix $edgeKey "EdgeEntraCopilotPageContext" 0
            &$InternalRegFix $edgeKey "Microsoft365CopilotChatIconEnabled" 0
            &$InternalRegFix $edgeKey "NewTabPageBingChatEnabled" 0
            &$InternalRegFix $edgeKey "ShareBrowsingHistoryWithCopilotSearchAllowed" 0
            &$InternalRegFix $edgeKey "ComposeInlineEnabled" 0
            &$InternalRegFix $edgeKey "AIGenThemesEnabled" 0
            &$InternalRegFix $edgeKey "BuiltInAIAPIsEnabled" 0
            &$InternalRegFix $edgeKey "EdgeHistoryAISearchEnabled" 0
            &$InternalRegFix $edgeKey "GenAILocalFoundationalModelSettings" 1
            
            # 5. UI & Nags
            &$InternalRegFix $edgeKey "HideFirstRunExperience" 1
            &$InternalRegFix $edgeKey "ShowHomeButton" 1
            &$InternalRegFix $edgeKey "FavoritesBarEnabled" 1
            &$InternalRegFix $edgeKey "PinBrowserEssentialsToolbarButton" 0
            &$InternalRegFix $edgeKey "PromotionalTabsEnabled" 0
            &$InternalRegFix $edgeKey "MicrosoftEdgeInsiderPromotionEnabled" 0
            &$InternalRegFix $edgeKey "DefaultBrowserSettingsCampaignEnabled" 0
            &$InternalRegFix $edgeKey "ShowPDFDefaultRecommendationsEnabled" 0
            &$InternalRegFix $edgeKey "SpotlightExperiencesAndRecommendationsEnabled" 0
            &$InternalRegFix $edgeKey "StartupBoostEnabled" 0
            &$InternalRegFix $edgeKey "BackgroundModeEnabled" 0

            # Account & Sync Restoration
            &$InternalRegFix $edgeKey "BrowserSignin" 1
            &$InternalRegFix $edgeKey "SyncDisabled" 0
            &$InternalRegFix $edgeKey "ImplicitSigninEnabled" 1
            
            # 6. Safety & Network
            &$InternalRegFix $edgeKey "HttpsOnlyMode" "force_enabled" "String"
            &$InternalRegFix $edgeKey "SafeBrowsingSurveysEnabled" 0
            &$InternalRegFix $edgeKey "TyposquattingCheckerEnabled" 0
            &$InternalRegFix $edgeKey "BuiltInDnsClientEnabled" 0
            
            # 7. User Path (Immediate Effect)
            $edgeKeyHKCU = "HKCU:\Software\Policies\Microsoft\Edge"
            &$InternalRegFix $edgeKeyHKCU "DefaultSearchProviderEnabled" 1
            &$InternalRegFix $edgeKeyHKCU "DefaultSearchProviderName" "DuckDuckGo" "String"
            &$InternalRegFix $edgeKeyHKCU "DefaultSearchProviderSearchURL" "https://duckduckgo.com/?q={searchTerms}" "String"
            &$InternalRegFix $edgeKeyHKCU "HideFirstRunExperience" 1
            
            # Layer 4: Ensure Edge Update Services (Restricted for stability)
            $edgeServices = @("edgeupdate", "edgeupdatem", "MicrosoftEdgeElevationService")
            foreach ($svc in $edgeServices) {
                if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
                    Set-Service -Name $svc -StartupType Manual -ErrorAction SilentlyContinue
                }
            }
            
            # Layer 5: Force Group Policy Refresh
            Internal-Log "Action: Forcing Group Policy refresh..."
            Start-Process -FilePath "gpupdate.exe" -ArgumentList "/force", "/wait:0" -WindowStyle Hidden -Wait -ErrorAction SilentlyContinue
        }
        
        # --- ROBUST AI & COPILOT REMOVAL ---
        if ($Options.AI) {
            Internal-Log "Action: Disabling Copilot and AI elements..."
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton" 0
            &$InternalRegFix "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1
            &$InternalRegFix "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RemindMeAboutWindowsCopilot" 0
            
            # UI Hardening: Classic Context Menu
            if (-not (Test-Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")) {
                New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force | Out-Null
            }
        }

        if ($Options.Defender) {
            Internal-Log "Action: Optimizing Windows Defender..."
            Set-MpPreference -ScanAvgCPULoadFactor 20 -MAPSReporting Disabled -ErrorAction SilentlyContinue
        }

        # 7. Finalization
        if ($Options.Health) {
            Internal-Log "Action: Running System Health Check..."
            DISM /Online /Cleanup-Image /CheckHealth | Out-Null
        }

        Internal-Log "Complete!" "Optimization Finished"
        Internal-Step "Step5"
    } catch {
        Internal-Log "Error occurred: $($_.Exception.Message)" "Error"
    }
}

# --- Event Handlers ---

$btnContinue.Add_Click({ Switch-Step "Step2" })
$btnNext.Add_Click({ Switch-Step "Step3" })
$btnAdvanced.Add_Click({ Switch-Step "StepAdvanced" })
$btnBack.Add_Click({ Switch-Step "Step3" })
$btnCancel.Add_Click({ $window.Close() })
$btnFinish.Add_Click({ $window.Close() })

function Start-Process-Worker($options) {
    $shouldRestore = $chkRestore.IsChecked
    Switch-Step "Step4"
    
    $rs = [runspacefactory]::CreateRunspace()
    $rs.ApartmentState = "STA"
    $rs.ThreadOptions = "ReuseThread"
    $rs.Open()
    
    $ps = [powershell]::Create()
    $ps.Runspace = $rs
    
    # Add shared data to options
    $options.Whitelist = $GlobalWhitelist
    $options.Tasks = $GlobalTasks
    
    $ps.AddScript(${function:Invoke-Debloat}).AddArgument($SyncHash).AddArgument($shouldRestore).AddArgument($options)
    
    $ps.BeginInvoke()
}

$btnStart.Add_Click({
    $options = @{
        AppX = $true; AppXList = $GlobalBlacklist
        Caps = $true; CapsList = $GlobalCapabilities
        Svc = $true; SvcList = $GlobalServices
        Reg = $true; Edge = $true; AI = $true; Defender = $true; Health = $true
    }
    Start-Process-Worker $options
})

$btnStartAdvanced.Add_Click({
    $selAppX = $dynamicAppX | Where-Object { $_.IsChecked } | Select-Object -ExpandProperty Tag
    $selCaps = $dynamicCaps | Where-Object { $_.IsChecked } | Select-Object -ExpandProperty Tag
    $selSvc = $dynamicSvc | Where-Object { $_.IsChecked } | Select-Object -ExpandProperty Tag

    $options = @{
        AppX = $selAppX.Count -gt 0
        AppXList = $selAppX
        Caps = $selCaps.Count -gt 0
        CapsList = $selCaps
        Svc = $selSvc.Count -gt 0
        SvcList = $selSvc
        Reg = $optReg.IsChecked
        Edge = $optEdge.IsChecked
        AI = $optAI.IsChecked
        Defender = $optDefender.IsChecked
        Health = $optHealth.IsChecked
    }
    Start-Process-Worker $options
})

# Show Window
$window.ShowDialog() | Out-Null
