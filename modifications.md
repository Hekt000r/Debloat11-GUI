| Category | Targeted Component | Modification Type | Action Taken |
| :--- | :--- | :--- | :--- |
| **System Apps** | Microsoft Bing News & Weather | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Microsoft Teams (Work/School) | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Outlook For Windows (New) | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Windows Widgets (WebExperience) | AppX Package | Uninstalled & Registry Blocked |
| **System Apps** | Microsoft Copilot / AI Shell | AppX Package | Core AI Logic Removed |
| **System Apps** | Windows Feedback Hub | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Get Help / Tips (GetStarted) | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Xbox / Gaming App Suite | AppX Package | Removed (Overlay/Gaming/Speech) |
| **System Apps** | Zune Music & Video | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Office Hub / OneNote | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Paint 3D / Print 3D | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Your Phone (Link to Windows) | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Solitaire / Clipchamp / Todos | AppX Package | Fully Deprovisioned & Removed |
| **System Apps** | Power Automate Desktop | AppX Package | Fully Deprovisioned & Removed |
| **Capabilities**| Internet Explorer 11 (Legacy) | System Feature | Uninstalled (Optional Feature) |
| **Capabilities**| Quick Assist / Steps Recorder | System Feature | Uninstalled (Optional Feature) |
| **Capabilities**| Hello Face / Math Recognizer | System Feature | Uninstalled (Optional Feature) |
| **Capabilities**| OpenSSH Client | System Feature | Uninstalled (Optional Feature) |
| **Services** | DiagTrack (Connected User Exp) | System Service | Stopped & Permanently Disabled |
| **Services** | SysMain (Superfetch) | System Service | Stopped & Permanently Disabled |
| **Services** | dmwappushservice (WAP Push) | System Service | Stopped & Permanently Disabled |
| **Services** | lfsvc (Geolocation Service) | System Service | Stopped & Permanently Disabled |
| **Services** | MapsBroker (Download Maps) | System Service | Stopped & Permanently Disabled |
| **Services** | WpcMonService (Family Safety) | System Service | Stopped & Permanently Disabled |
| **OS Registry** | Windows Telemetry (Collection) | Policy Key | Set `AllowTelemetry = 0` |
| **OS Registry** | Cortana Virtual Assistant | Policy Key | Set `AllowCortana = 0` |
| **OS Registry** | Start Menu Web Search | Policy Key | Set `BingSearchEnabled / DisableWebSearch = 1` |
| **OS Registry** | Advertisement Tracking ID | User Key | Set `AdvertisingInfo \ Enabled = 0` |
| **OS Registry** | Tailored Experiences | User Key | Set `TailoredExperiencesEnabled = 0` |
| **OS Registry** | Windows Activity Feed | Policy Key | Set `EnableActivityFeed = 0` |
| **OS Registry** | Context Menu (Classic Style) | CLSID Redirect | Forced Windows 10 style right-click |
| **OS Registry** | Taskbar Chat / Search Icons | User Key | Set `TaskbarDa / TaskbarMn = 0` |
| **OS Registry** | Windows Defender (Optimization)| Policy Key | Set AvgCPULoadFactor 20 / MapsReport Disabled |
| **Update Pause**| Long-term Update Pause | Policy Key | Unlocked 82-year pause option in Settings |
| **AI Removal**  | Windows Copilot System-wide | Policy Key | Set `TurnOffWindowsCopilot = 1` |
| **AI Removal**  | Copilot Taskbar Button | User Key | Set `ShowCopilotButton = 0` |
| **AI Removal**  | "Remind me about Copilot" Nags | User Key | Set `RemindMeAboutWindowsCopilot = 0` |
| **Edge Policy** | Search Engine (DuckDuckGo) | HKLM Policy | Set DDG Search URL & Suggest URL |
| **Edge Policy** | New Tab & Homepage (DDG) | HKLM Policy | URL set to DDG (Redirect from Bing Chat) |
| **Edge Policy** | Tracking Prevention | Policy Key | Forced to 'Level 3' (Strict) |
| **Edge Policy** | Metrics & Diagnostic Data | Policy Key | Set `PersonalizationReportingEnabled = 0` |
| **Edge Policy** | Hubs & Discover Features | Policy Key | Set `HubsSidebarEnabled / DiscoverPage = 0` (Favorites Bar Kept) |
| **Edge Policy** | AI / Copilot Integration | Policy Key | Blocked: Context, ChatIcon, GenAI Model |
| **Edge Policy** | Background Mode / Boost | Policy Key | Set `StartupBoostEnabled / BackgroundMode = 0` |
| **Edge Policy** | Shopping Assistant / Rewards | Policy Key | Set `EdgeShoppingAssistant / Rewards = 0` |
| **Edge Policy** | First Run Experience | Policy Key | Set `HideFirstRunExperience = 1` |
| **Edge Update** | Update Logic (Google/Native) | System Service | Set to Manual to allow Account Sync stability |
| **Edge Network** | DNS & SSL Security | Policy Key | Forced `HttpsOnlyMode` / Disabled Survey prompts |