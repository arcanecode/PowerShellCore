<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Using PowerShell in the Terminal

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 

  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
-----------------------------------------------------------------------------#>

<#-----------------------------------------------------------------------------
  Notes on this script

  The examples here are not show in the VSCode environment. Instead they are
  demonstrated in the terminal during the course. However they have been 
  included here as an easy reference. 
-----------------------------------------------------------------------------#>


# All commands in PowerShell are in the form of a verb-noun syntax
Get-ChildItem

# A command in PowerShell is known as a cmdlet

# Here it produces a list of items in the current location. 
# The current location is displayed in the prompt, here it is a folder
# in the file system. 

# You can find a list of the currently loaded commands by using:
Get-Command

# Note the 'currently loaded'. You can extend the commands available to 
# you through the addition of modules. We will talk briefly about modules
# in a later module. 

# If you want to learn more about a command, you can always get help
# on it. 
Get-Help Get-Command 

# Right after installing PowerShell, and periodically thereafer, you
# should update your help library
# Unfortunately there is currently a bug in PowerShell Core on Ubuntu
# that prevents it from working. 
# (https://github.com/PowerShell/PowerShell/Issues/7452)
Update-Help


# Reading Markdown
# Note, you must be using PowerShell Core 6.1 or greater!

# First set a variable to your root path where you extracted the code
# An example for Linux
$rootPath = '/home/arcanecode/Documents/code/PowerShellCore/Notes/'

# If you are on Windows (yes, I know the course is for Linux / macOS but
# PowerShell Core works on Windows too) here's an example
$rootPath = 'C:\Users\arcan\OneDrive\Pluralsight\PowerShell Core\Notes\'

# Clear the output window
Clear-Host

# Now just pick the MD file you want and run that one line of code to see the output

# Shows how to configure Ubuntu with some basic utilities
ConvertFrom-Markdown -Path "$($rootPath)Install PSCore on Ubuntu.md" -AsVT100EncodedString | Show-Markdown

# Steps on how to configure VSCode to work with GIT
ConvertFrom-Markdown -Path "$($rootPath)Configure VSCode.md" -AsVT100EncodedString | Show-Markdown

# How to install Docker on Ubuntu
ConvertFrom-Markdown -Path "$($rootPath)Install Docker on Ubuntu.md" -AsVT100EncodedString | Show-Markdown

# How to install PowerShell Core, VSCode, and Azure Data Studio on Ubuntu
ConvertFrom-Markdown -Path "$($rootPath)Install PSCore on Ubuntu.md" -AsVT100EncodedString | Show-Markdown

# How to install PowerShell Core, VSCode, and Azure Data Studio on macOS
ConvertFrom-Markdown -Path "$($rootPath)Install PSCore on macOS.md" -AsVT100EncodedString | Show-Markdown

# Install SQL Server in a Docker container on Ubuntu
ConvertFrom-Markdown -Path "$($rootPath)Install SQL Server in Docker on Ubuntu.md" -AsVT100EncodedString | Show-Markdown

# Even though Windows is not covered in this course, these demos will still work
# if you install PowerShell Core on a Windows Machine. By default though, VSCode
# will want to use PowerShell 5.1 as the default terminal. The instructions here
# show how to change that to PowerShell Core.
ConvertFrom-Markdown -Path "$($rootPath)Using PowerShell 5.1 and 6.0 with VSCode.md" -AsVT100EncodedString | Show-Markdown


