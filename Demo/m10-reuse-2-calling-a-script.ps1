<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Constructing Reusable Functions

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

  As you get comfortable writing reusable functions, you will want to place
  them in one or more scripts you can call over and over again. In this
  file, we'll show how to execute the script m10-reuse-1-functions. This
  will then place then functions contained in that script into memory.

  Then, we'll call the function inside this script to demonstrate the 
  ability to reuse a set of functions across multiple scripts.
-----------------------------------------------------------------------------#>

# Set the location
# Linux
Set-Location '/home/arcanecode/Documents/code/PowerShellCore'

# Try to execute the function before it is loaded 
Add-SomeNumbers 1 2

# ...or try and get help on it
Get-Help Add-SomeNumbers

# And you'll get errors. So now run the script to load its functions into memory

. ./Demo/m10-reuse-1-functions.ps1

Get-Help Add-SomeNumbers

Add-SomeNumbers 1 2
