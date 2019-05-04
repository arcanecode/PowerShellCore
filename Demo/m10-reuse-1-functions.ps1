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
  file, we'll create a simple function you can call. 

  In the script m10-reuse-2-calling-a-script.ps1, we'll show how to execute
  this script of functions so that the functions will be in memory for you
  to use. 
-----------------------------------------------------------------------------#>

Write-Host 'Loading m10-reuse-1-functions.ps1'

function Add-SomeNumbers ($a, $b)
{
<#
.SYNOPSIS
Adds two numbers

.DESCRIPTION
This function adds two numbers together 

.INPUTS
a and b, both numbers

.OUTPUTS
A number

.EXAMPLE
Example 1 - Simple use
Add-Numbers 1 2

#>

  $result = $a + $b
  return $result 
}

Write-Host 'Done Loading m10-reuse-1-functions.ps1'
