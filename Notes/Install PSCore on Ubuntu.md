# Install PowerShell Core on Linux Ubuntu

These instructions work on Ubuntu 18.10, or other distros that support snapcraft packages. (See below for older versions of Ubuntu or distros that don't support snapcraft.)

## Method 1: Use the GUI

1. Open the Ubuntu Software store from the toolbar (orage A icon)
2. Click the Search icon.
3. Enter PowerShell. Show the regular powershell as well as the preview. 
4. Say this is one way to install, we'll show a second. 
5. While here, do another search for VSCode, explaining we'll be using it to do our scripts. 

## Method 2: Use the command line
1. PowerShell can be installed via a Snapcraft package, or simply a "snap".
2. Open a terminal window. 
3. Install the snapd application.
```bash
sudo apt install snapd
```
4. Install the PowerShell snap. 
```bash
snap install powershell --classic
```
By default snaps run in isolation. The --classic is needed so the installed package can interact with the rest of the machine.

5. Launch PowerShell core it by running pwsh in your terminal window. 

6. Test it by running a simple command

```powershell
Get-Help
```

Or try this to get the contents of your current folder:
```powershell
Get-ChildItem
```

To verify your version, enter:
```powershell
$PSVersionTable
```
This is a variable built into PowerShell that contains information on the currently running version of PowerShell.

## Installing on non-snapchat distros 
Microsoft has complete instructions and download links at:
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6

## Install VSCode via a snap
1. Now install VSCode via a snap
```bash
sudo snap install --classic code
```
That's it! Now you will want to add some extensions to make VSCode work better with PowerShell.

1. Add the PowerShell extension. Click the extensions icon over on the left, lowermost icon in the top area
2. Type in PowerShell and hit enter.
3. Click on the PowerShell item. Click Install.
4. Test by doing a file, new, then file, save as, navigate to the documents folder, and use test1.ps1 as the name.
5. Enter a simple command and press F5 to run. 

## Install VSCode without using snaps
To install VSCode on systems that do not support snapcraft, please see the documentation on Microsoft's webste at:
https://code.visualstudio.com/docs/setup/linux

## Azure Data Studio
At the time of this writing, Azure Data Studio is not availble via a snap. You will have to install via their website.

https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017

Be sure to read through the documentation, toward the bottom they mention additional dependancies you may need on your system. These have already been included in the Setup-Ubuntu.sh script.

Once you have it downloaded (this assumes you take the default to save in the Downloads folder) you can install with this command:
```bash
sudo dpkg -i ./Downloads/azuredatastudio-linux-1.5.2.deb
```
Make sure to update the version number to the most current version for the file you download.

#------------------------------------------------------------------------------
# Install openssh
#------------------------------------------------------------------------------
# Make sure to follow the instructions in Configure Remoting on Ubuntu.md
sudo apt -y install openssh-client openssh-server 

#------------------------------------------------------------------------------
# Azure Data Studio
#------------------------------------------------------------------------------

# There are some prerequsites we can install for Azure Data Studio
sudo apt-get -y install libxss1
sudo apt-get -y install libgconf-2-4
sudo apt-get -y install libunwind8

# Note - ADS still not working right, need a good d/l link. Disabled for now.
# Now download Azure Data Studio
wget -P ~/Downloads "https://go.microsoft.com/fwlink/?linkid=2083327"

# When you download it, the process names it the same as the linked file, which is incorrect
# Let's rename it to something that makes sense
cd ~/Downloads
mv index.html?linkid=2083327 azuredatastudio-linux.deb

# And install it. Note at the time this was created, 1.5.2 was the current
# version. You should check online at 
# https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017
# for the current version number, then update the file name below to match it.
cd ~
sudo dpkg -i ./Downloads/azuredatastudio-linux.deb
