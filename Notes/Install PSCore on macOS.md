# Steps to install PowerShell Core on macOS

## Prerequisites

In order to fully utilize all the capabilities of VSCode, you'll need a set of libraries. The easiest way to get these installed to get these installed is to install the XCode and Command Line Tools. These will ensure all the development support tools, such as git, are installed and configured.

You can install these via the App Store. Be aware the XCode install is 6 gig, and Command Line tools are about 250 meg. If you have a slow internet connection, or intend to build multiple macOS installs, you may wish to download these from the Apple Developer site once and reuse them with each install.

Whichever method you select, make sure to launch XCode once and accept the license agreement before you proceed.

## Install brew

With the prerequisites taken care of, install brew. Note that brew has a dependancy on the XCode libraries, which are about a 200 meg download. If you plan to run this over and over, for example setting up virtual macOS machines for testing and development, you might consider downloading it once and installing manually if you have a slow internet connection. You do have to have an Apple developer account in order to download it as an installer from Apple. 

With the XCode libraries installed, or when you are on a fast internet connection, run the following command to install homebrew.

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

Note that one error you may receive is that gcc is missing. Brew makes it easy to install:

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

Once PowerShell starts, you can verify you are on the right version by looking at the built in PowerShell version variable.

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
brew cask install visual-studio-code
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
brew cask upgrade
brew cask install azure-data-studio
```

(Note if you just did an upgrade prior to installing VSCode, you could skip the first line)

## Installing Docker

### Method 1 - Download from the Docker Site

Docker has a lot of "moving pieces" in terms of services and paths. For this reason, it's safest with macOS to install from their downloadable installer. This ensures everything is installed and configured correctly. This is what is done for this course.

Here is the download link and instructions:

https://docs.docker.com/docker-for-mac/install/

### Method 2 - Command Line

If you need to script the install you can, but it requires manual intervention at several steps. For that reason you may wish to install from the Docker site. 

Installing is straightforward:

```bash
brew cask install docker
```

Read through the online Docker documentation for more information on configuration. 
https://docs.docker.com/docker-for-mac/docker-toolbox/

### References

https://coolestguidesontheplanet.com/installing-homebrew-on-macos-sierra-package-manager-for-unix-apps/

Running brew with no user intervention:

https://stackoverflow.com/questions/24426424/unattended-no-prompt-homebrew-installation-using-expect

https://stackoverflow.com/questions/25128546/how-to-automate-homebrew-installation

---

## Author Information

### Author

Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites

Github: [http://arcanerepo.com](http://arcanerepo.com)
Main: [http://arcanecode.me](http://arcanecode.me)

### Copyright Notice

This document is Copyright (c) 2015, 2019, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
