# Steps to install PowerShell Core on macOS

## Install brew

First, install brew:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Then update brew using the following command: 
```bash
brew update
```
Next, you need to let brew examine your system for any inconsistencies. The following command will produce a report with any steps you need to take to remove older brew libraries and the like. This is important, as if brew is not up to date later installs can fail. 
```bash
brew doctor
```
Make sure to follow any recommendations that the doctor gives before you proceed. You can always run brew doctor again when you are done, if it comes up with no suggestions then you are ready to proceed.

## Install PowerShell Core
Now that brew is ready, you can use it to install PowerShell core, using the following command:
```bash
brew cask install powershell
```
Note that one error you may receive is that gcc is mssing. Brew makes it easy to install:
```bash
brew install gcc
```
If you already installed PowerShell and just want to update it, you can use the following command:
```bash
brew cask upgrade
```

This will upgrade all casks on your system, including PowerShell. 

If you have issues during the install, check out these web pages

https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6

https://apple.stackexchange.com/questions/209624/how-to-fix-homebrew-error-invalid-active-developer-path-after-upgrade-to-os-x

After installing, issue the following command in your terminal to launch PowerShell core:
```bash
pwsh
```
Once PowerShell starts, you can veify you are on the right version by looking at the built in PowerShell version variable.
```powershell
$PSVersionTable
```

## Install VSCode
You can install VSCode on macOS using one of two methods.

### Method 1 - Download from Microsoft
The first method is straight forward, simply go to the VSCode site and download the correct version for your machine.

https://code.visualstudio.com/download

### Method 2 - Using brew
You can also use brew to install VSCode.
```bash
brew cask update
brew install visual-studio-code
```

You may also wish to do a cleanup with brew to remove any outdated info from its local repository.
```bash
brew cleanup
```

## Azure Data Studio
For some of the demos we will work with SQL Server. You may wish to install Azure Data Studio. Just like with VSCode, there are two methods.

### Method 1 - Download from Microsoft
The first method involves going to the website for Azure Data Studio, downloading and installing as you would any other app.

https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017 

### Method 2 - Using brew
You can also install Azure Data Studio using brew.
```bash
brew cask update
brew cask install azure-data-studio
```
(Note if you just did an update to install VSCode, you could skip the first line)

### References
https://coolestguidesontheplanet.com/installing-homebrew-on-macos-sierra-package-manager-for-unix-apps/