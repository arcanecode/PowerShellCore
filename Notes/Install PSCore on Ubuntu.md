# Install PowerShell Core on Linux Ubuntu

These instructions work on Ubuntu 18.04, 18.10, 19.04, or other distros that support snapcraft packages. (See below for older versions of Ubuntu or distros that don't support snapcraft.)

## Install Useful Tools

Before we install PowerShell Core and it's accompanying tools, there are some useful tools we should install in order to support the various instructions in this and other documents. 

Before you install anything though, you want to be sure your tools are up to date. 

```bash
sudo apt-get -y update
```

(Note we'll be using -y throughout these instructions to auto accept confirmation answers).

Next, let's install VIM (if it's not there)

```bash
sudo apt -y install VIM
```

Another useful group of tools are the net-tools, so you can do things like get the IP address of the computer you are using. 

To install them, run:

```bash
sudo apt -y install net-tools
```

Once installed, you can test (and see your IP address) by running:

```bash
ifconfig
```

If you plan to use VSCode with repositories like GitHub, you want to be sure git is installed. 

```bash
sudo apt -y install git-all
```

Finally, PowerShell and other tools can be installed through what is called a snap package. (see https://snapcraft.io for more info). To support them we need to make sure the snap installer is present. (Note snaps only work with Ubuntu 18.x and above.)

```bash
sudo apt -y install snapd
```

## Install PowerShell Core

Now we're ready to install PowerShell Core. There are two methods.

### Method 1: Use the GUI

1. Open the Ubuntu Software store from the toolbar (orange A icon)
2. Click the Search icon.
3. Enter PowerShell. Note you will see the regular powershell icon, and you may also see the preview version of PowerShell. 
4. We're going to install via the command line, but if you want to install through the GUI just double click to install. 

## Method 2: Use the command line

1. PowerShell can be installed via a Snapcraft package, or simply a "snap". This assumes you've installed the snap app in the instructions from the previous section.
2. Open a terminal window.
3. Install the PowerShell snap. 

```bash
snap install powershell --classic
```

By default snaps run in isolation. The --classic is needed so the installed package can interact with the rest of the machine.

1. Launch PowerShell core it by running pwsh in your terminal window. 

2. Test it by running a simple command

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

#### Installing on non-snapchat distros 

Microsoft has complete instructions and download links at:
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6

## Install VSCode via a snap

In order to edit PowerShell scripts, we'll need to install VSCode. 

1. Install VSCode via a snap

```bash
snap install --classic code
```

That's it! Now you will want to add some extensions to make VSCode work better with PowerShell.

1. Add the PowerShell extension. Click the extensions icon over on the left, lowermost icon in the top area
2. Type in PowerShell and hit enter.
3. Click on the PowerShell item. Click Install.
4. Test by doing a file, new, then file, save as, navigate to the documents folder, and use test1.ps1 as the name.
5. Enter a simple command and press F5 to run.

While you are here, there are some other extensions you should consider installing.

* Markdown All in One
* Markdown Preview Enhanced
* SQL Server (mssql)
* Bash Debug

At the very least you'll want at least on of the Markdown extensions so you can display instructions in a readable format. 

### Install VSCode without using snaps

To install VSCode on systems that do not support snapcraft, please see the documentation on Microsoft's website at:

https://code.visualstudio.com/docs/setup/linux

## Azure Data Studio

Azure Data Studio is the interface we use for working with data platforms, not only those found in Azure but for local databases such as SQL Server. In the PowerShell for Linux and macOS course, we'll be using it with the Docker section. 

### Prerequisites

Before installing Azure Data Studio, there are three libraries you'll have to install. You can install all three at once with the following command:

```bash
sudo apt-get -y install libxss1 libgconf-2-4 libunwind8
```

### Install Method 1 - GUI

At the time of this writing, Azure Data Studio is not available via a snap. The officially supported method to install ADS is from a download at the Microsoft website.

https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017

Once you have it downloaded (this assumes you take the default to save in the Downloads folder) you can install with this command:

```bash
sudo dpkg -i ./Downloads/azuredatastudio-linux-1.6.0.deb
```

Make sure to update the version number to the most current version for the file you download.

### Install Method 2 - Command Line

This next method presents an automated method to download and install Azure Data Studio. Note that it is _NOT_ supported by Microsoft, however I have tested it and it does seem to work. 

First, you can download ADS to your machien using wget:

```bash
wget -P ~/Downloads "https://go.microsoft.com/fwlink/?linkid=2087415"
```

When you download it, wget uses the linkid... for the name. Let's go to the download folder, and rename it to something that makes sense. 

```bash
cd ~/Downloads
mv index.html?linkid=2087415 azuredatastudio-linux.deb
```

Now we can install it.

```bash
cd ~
sudo dpkg -i ./Downloads/azuredatastudio-linux.deb
```

## Additional VSCode Configuration

After you've installed everything, you may want to take some additional steps to configure VSCode, especially if you plan to use it with git. 

See the instructions found in _Configure VSCode.md_.

## Remoting

If you plan to use PowerShell Remoting, you'll need to install and configure openSSH. Please see the document _Configure Remoting on Ubuntu.md_ for instructions.

## Docker

If you want to experiment with running SQL Server in Docker, see the instructions found in _Install Docker on Ubuntu.md_ in order to install and configure.

## Configure the Ubuntu Desktop Favorites bar

When you install Ubuntu in a VM over and over, to setup either class room or dev environments, you may want to automate the process of setting up your "favorites" bar on the left side of the display.

If you want to see what the current set of favorites are, use:

```bash
/usr/bin/gsettings get org.gnome.shell favorite-apps
```

The easiest way to determine your favorites list is to manually configure it once, adding and removing what you want. Then run the above command again, to get the list of your favorites. Copy and paste the output, and pass it into the `gsettings -set` command.

For my own use, I use the following command to set mine, yours of course will reflect what you want.

```bash
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'code_code.desktop', 'azuredatastudio.desktop', 'org.gnome.Software.desktop', 'yelp.desktop']"
```

---

## Author Information

### Author

Robert C. Cain | @ArcaneCode | arcanecode@gmail.com

### Websites

Github: http://arcanerepo.com
Main: http://arcanecode.me 

### Copyright Notice

This document is Copyright (c) 2015, 2019, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted. 

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
