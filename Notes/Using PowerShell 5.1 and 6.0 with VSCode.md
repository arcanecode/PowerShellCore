# Using PowerShell Core (aka PowerShell 6) and PowerShell for Windows (aka PowerShell 5.1) Together

While this course was designed for Linux and macOS, the code has also been tested on Windows 10. The only issue can come in with VSCode. Thus if you don't have easy access to a Linux or macOS computer (or a VM) you can still test and use the code samples. 

By default though, the terminal that appears for PowerShell files within VSCode is Windows PowerShell version 5.1. It is possible though to get VSCode to use PowerShell Core (also known as PowerShell 6) as the default PowerShell terminal. 

These instructions assume you have installed PowerShell Core from the Microsoft site. If you haven't, you can find the instructions at:

https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6

or you can jump right to the PowerShell Core github site and download the installer from:

https://github.com/PowerShell/PowerShell/releases 

Also note, these instructions also assume you are using the default install directory for PowerShell Core. If you chose a different location you'll need to adjust the path accordingly. 

1. Within VSCode, select File, Preferences, Settings on the menu. 
2. With the Settings open, in the upper right corner of VSCode you will see a set of curly braces {}. Click on them to open the settings as a json file.
3. In the settings.json you'll need to add two lines.
```json
    "terminal.integrated.shell.windows": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
    "powershell.powerShellExePath": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
```
   The first line tells VSCode what terminal it should use as its default, in this case PowerShell version 6. The second line tells VSCode where to find the version PowerShell you want to use in order run PowerShell scripts. Once you set these, restart VSCode and you should now see VSCode using PowerShell as the terminal. As a test, you can issue the following command.
   ```powershell
   $PSVersionTable
   ```
   (And yes, I know technically it's not really a command but you are displaying the contents of a PowerShell built in variable.) If you did things right you should now see the following output.
```powershell
Name                           Value
----                           -----
PSVersion                      6.2.0
PSEdition                      Core
GitCommitId                    6.2.0
OS                             Microsoft Windows 10.0.17763
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0   
```
Depending on your version of Windows and what version of PowerShell you are on this may look a tad different, the important part being PSVersion should show 6 or above. 

For full documentation purposes, here is the complete contents of my settings.json file. 
```json
{
    "terminal.integrated.shell.windows": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
    "powershell.powerShellExePath": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
    "git.enableSmartCommit": true,
    "git.autofetch": true,
    "window.zoomLevel": 1,
    "workbench.colorTheme": "PowerShell ISE"
}
```
Do **NOT** copy and paste this into your settings, you may overwrite settings important to your system. I've included this to show you where the two additional lines fit into the settings and what an example of a full settings file might look like. 


---


## Author Information

### Author
Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites
Github: http://arcanerepo.com
Main: http://arcanecode.me 

### Copyright Notice
This document is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarentee is implied or expressly granted. 

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.

