# Debloat11
Free your Windows 11 OS from bloatware and AI slop

<img width="332" height="442" alt="image" src="https://github.com/user-attachments/assets/b4eaa662-025b-4b00-b28a-edf074278fe0" />

## How to use

Using this application is incredibly simple.
The only suggestion is that you fully update windows (or pause updates) before running the program so an update doesn't start after restarting to finish the script

Download the latest version from the (latest release)
Launch as administrator and just click next till the process starts

Antivirus WARNING: Antiviruses will sometimes flag this program as malware, which is a false-positive. The project is open source and you can build it yourself if you like.
NOTE: Do not worry if you see a warning, windows installations differ so if something fails it's probably already removed

## Features

### Automatic Restore Point Creation
- Problems when running the script are **extremely unlikely**, but for the very rare potential cases, the application can automatically create a restore point to ensure safety.
 
### Remove AI slop
- Removes annoying AI slop that also slows down your PC and spies on you like Microsoft Copilot

### Remove bloatware
- Removes distractions and bloatware that slows down your PC (a LOT, surprisingly even more than i expected)
- Example: Outlook, Mixed Reality Apps, Xbox Apps (Re-installable if you need it again, through Store)
- Removes those stupid little widgets on the taskbar that show stocks or whatever and literally take half your screen when hovering over them

### Remove a lot of telemetry
- Removes a lot of telemetry (microsoft stealing your data)

### Microsoft Edge Optimization
- Edge can be useful especially if you're on a low end PC since it starts up faster and is generally more efficient with RAM and other resources compared to others due to it being better integrated with the OS by Microsoft, but of course it has stupid features like Copilot AI shoehorned
- This script removes all* Copilot AI from the main UI
- Removes a lot of Edge Telemetry and data tracking (Making it significantly better for privacy)
- Turns off shopping assistant and other AI features (yes, even more slop forced into it)

### Windows Defender Optimization
- Prevents Windows Defender from reporting tracking data and telemetry back to Microsoft
- Limits scans to 20% CPU usage to prevent huge slowdowns whenever doing ... anything

### 100% Functionality
- Only "true bloatware" is removed, meaning the system is exactly 100% as functional as any other Windows installation. Anything removed can be reinstalled incase you need it again (like Xbox APP)

## What about updates?
This project will be worked on, and new versions will be released when new major Windows version come out. Sometimes Microsoft changes packages names just to break programs like this. If any bloat ever gets re-installed, simply launch the newest version and it will skip anything already removed and you will remove the new stuff.

## What is removed?
See https://github.com/Hekt000r/Debloat11-GUI/blob/main/modifications.md

### Technical Details
I wanted this to be as lightweight and simple as possible, so im using WPF + Powershell and building the exe with PS2EXE (Powershell to EXE).

Build the program by running ./build.ps1 in an Administrator Powershell window


