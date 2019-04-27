# Install updates and useful tools

Start the process by applying any updates to your system. We'll then install a few useful tools. 

Install any updates to your system
```bash
sudo yum upgrade -y
```

Note you may get the error that PackageKit has a lock on yum. You may have to kill it to finish the upgrade. Open a second terminal and issue the following command:

```bash
sudo pkill PackageKit
```
After you do so, the upgrade in the original terminal will begin.

Note that CentOS comes with VIM and net-tools preinstalled. 

Install Git

The installation of git is optional, but it is likely you will want to use it in association with VSCode to store your code in version control system, either on premisis or in the cloud. GitHub offers one such repository, and is free to use. 

Git can be installed via the Yum package manager

```bash
sudo yum -y install git-core
```

You can issue the `git` command to validate it is installed. Y

Note that the file _Configure VSCode.md_ has instructions on configuring git as part of the VSCode configuration.

On my system I also like to have firefox handy.
sudo yum -y install firefox


# Install PowerShell Core on CentOS

These instructions will walk you through installing PowerShell Core on CentOS. 

First, you need to register the Microsoft RedHat repository
```bash
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
```

Once the repository has been registered, you can now install PowerShell via Yum
```bash
# Install PowerShell
sudo yum install -y powershell
```

Now you can start a PowerShell session in your terminal
```bash
# Start PowerShell
pwsh
```

Test it by running a simple command

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

# Install VSCode on CentOS

Start by adding the Microsoft Keys to your system
```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

Next, check for any updates to the repo, then finally you can use dnf to install VSCode
```bash
yum check-update
sudo yum -y install code
```

# Install Azure Data Studio

Now that PowerShell and VSCode are installed, you will want to install Azure Data Studio if you intend to work with SQL Server or other data platforms.

First, go download the latest version from:
https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017

Scroll down and get the _rpm_ version of ADS.

(The remaining instructions assume you are saving to your Downloads folder)

The installer uses the following format:
yum install ./Downloads/azuredatastudio-linux-<version string>.rpm

Just replace the version string with the most current version. As of April 2019 this is:

```bash
cd ~
yum install ./Downloads/azuredatastudio-linux-1.6.0.rpm
```



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


