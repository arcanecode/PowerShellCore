<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Working with Variables in PowerShell

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 

  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
-----------------------------------------------------------------------------#>


#-----------------------------------------------------------------------------#
# Variables
#-----------------------------------------------------------------------------#
#region Variables

Clear-Host

# All variables start with a $. Show a simple assignment
$hi = "Hello World"

# Print the value
$hi

# This is a shortcut to Write-Host
Write-Host $hi

# Variables are objects. Show the type
$hi.GetType()

# Display all the members of this variable (object)
$hi | Get-Member

# Use some of those members
$hi.ToUpper()
$hi.ToLower()
$hi.Length

# Types are mutable
Clear-Host
$hi = 5
$hi.GetType()

$hi | Get-Member

# Variables can be strongly typed 
Clear-Host
[System.Int32]$myint = 42  
$myint
$myint.GetType()

$myint = "This won't work"

# There are shortcuts for most .net types
[int] $myotherint = 42
$myotherint.GetType()
Clear-Host

[string] $mystring="PowerShell"
$mystring.GetType()

# Others include short, float, decimal, single, bool, byte, etc

# Not just variables have types - so do static values
"PowerShell Rocks".GetType()

# Accessing methods on objects
"PowerShell Rocks".ToUpper()
"PowerShell Rocks".Contains("PowerShell")

# For nonstrings you need to wrap in () so PS will evaluate as an object
(33).GetType()  


# Comparisons
$var = 33       # Equal Sign = is used to assign values

$var -gt 30
$var -lt 30
$var -eq 33

# List is:
#   -eq        Equals
#   -ne        Not equal to
#   -lt        Less Than
#   -gt        Greater then
#   -le        Less than or equal to
#   -ge        Greater then or equal to

#   -in        See if value in an array
#   -notin     See if a value is missing from an array
#   -Like      Like wildcard pattern matching
#   -NotLike   Not Like 
#   -Match     Matches based on regular expressions
#   -NotMatch  Non-Matches based on regular expressions

# Calculations are like any other language
Clear-Host
$var = 3 * 11  # Also uses +, -, and / 
$var

# Supports post unary operators ++ and --
# In post unary, the value is read, then incremented
Clear-Host
1 + $var++   
$var

# And pre unary operators as well
# In pre unary, the variable is incremented, then the value is read
1 + ++$var 
$var

Clear-Host
$var = 33
$post = $var++
$post
$var

Clear-Host
$var = 33
$post = ++$var
$post
$var



# Be cautious of Implicit Type Conversions
"42" -eq 42
42 -eq "42"

# Whatever is on the right is converted to the data type on the left
# Can lead to some odd conversions
42 -eq "042"   # True because the string on the right is coverted to an int
"042" -eq 42   # False because int on the right is converted to a string

##


#-----------------------------------------------------------------------------#
# Built in variables
# Note - Case is not imporant, $false, $False, and $FALSE are all the same
#-----------------------------------------------------------------------------#
# Automatic Variables
Clear-Host

# False and true
$false
$true

# Null 
$NULL

# Current directory
$pwd

# Users Home Directory
$Home  

# Info about a users scripting environment
$host

# Process ID
$PID

# Info about the current version of Powershell
$PSVersionTable

$_   # Current Object

# Windows
Set-Location 'C:\ps\01 - intro'
# Linux
Set-Location '/home/arcanecode/code/PowerShellCore/PowerShellCore/Demo'
# macOS

Get-ChildItem | Where-Object {$_.Name -like "*.ps1"}

#endregion Variables

##










#-----------------------------------------------------------------------------#
# Using the *-Variable cmdlets
#-----------------------------------------------------------------------------#
Clear-Host

# Normal variable usage
$normal = 33
$normal

$text = "In The Morning"
$text

# Long version of $var = 33
New-Variable -Name myNewVar -Value 33
$myNewVar

# Note if you try to use New-Variable and it already exists, you get an error
# Try again with $var already existing
New-Variable -Name myNewVar -Value 99
$myNewVar

# Displays the variable and it's value
Get-Variable myNewVar

# Display on the value of a variable
Get-Variable myNewVar -valueonly
# (Same as putting $myNewVar alone on a line)

# Without params it shows all variables
Get-Variable

# Assign a new value to an existing variable
# $myNewVar = "In The Morning"
Set-Variable -Name myNewVar -Value "In The Morning"
$myNewVar

# Clear the contents of a variable
# Same as $var = $null
Clear-Variable -Name myNewVar
$myNewVar   

# Variable is now set to null
$myNewVar -eq $null

# Even though null, it still exists
Get-Variable myNewVar   


# Wipe out a variable
Remove-Variable -Name myNewVar
# Now var is gone, if you try to remove or clear again an error occurs
# (note if you try to access it by just doing a $var the var is recreated)

Get-Variable myNewVar   # Now produces an error


##



