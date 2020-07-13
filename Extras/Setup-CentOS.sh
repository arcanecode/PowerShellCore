#------------------------------------------------------------------------------
#  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
#          http://arcanecode.com
# 
#  This script is Copyright (c) 2019 Robert C. Cain. All rights reserved.
#
#  The code herein is for demonstration purposes. No warranty or guarentee
#  is implied or expressly granted. 
#
#  This script may not be reproduced in whole or in part without the express
#  written consent of the author and/or Pluralsight. It can be used within
#  your own projects.
#------------------------------------------------------------------------------

# This script will do a complete run thru setting up most of what you 
# need on CentOS7


# Install updates and useful tools

#Install any updates to your system
sudo yum upgrade -y

# Note you may get the error that PackageKit has a lock on yum. You may have to kill it to finish the upgrade. Open a second terminal and issue the following command:

# sudo pkill PackageKit

# After you do so, the upgrade in the original terminal will begin.

# Install Git
sudo yum -y install git-core

# Install PowerShell Core on CentOS

# First, you need to register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell

# Install VSCode on CentOS

# Start by adding the Microsoft Keys to your system
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


# Next, check for any updates to the repo, then finally you can use dnf to install VSCode
dnf check-update
sudo dnf install code

# Install Azure Data Studio

# As of April 2019 version 1.6.0 is the most recent version of ADS.
# Check the ADS website at the url below to ascertain the most current version.
# https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017
cd ~
yum install ./Downloads/azuredatastudio-linux-1.6.0.rpm

# Install Docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install docker-ce --nobest
