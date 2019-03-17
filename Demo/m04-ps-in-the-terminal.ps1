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
Update-Help



