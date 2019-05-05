<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Cool Things You Can Do with PowerShell - Processes

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 
  
  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
  -----------------------------------------------------------------------------#>
  
# In this demo we'll look at how to manage processes with PowerShell

# Let's start by seeing what processes are running
Get-Process

<#
  So what is this output? Here's a list of the columns returned

  Handles: The number of handles that the process has opened.
  NPM(K): The amount of non-paged memory that the process is using in kilobytes
  PM(K): The amount of pageable memory that the process is using, in kilobytes.
  WS(K): The size of the working set of the process, in kilobytes. The working
         set consists of the pages of memory that were recently referenced by 
         the process.
  VM(M): The amount of virtual memory that the process is using, in megabytes.
         Virtual memory includes storage in the paging files on disk.
  CPU(s): The amount of processor time that the process has used on all 
          processors, in seconds.
  ID: The process ID (PID) of the process.
  ProcessName: The name of the process. For explanations of the concepts 
               related to processes, see the Glossary in Help and Support
               Center and the Help for Task Manager.
#>


# That's a lot of rows returned! Let's narow down to one specific process.
# Let's check to see what VSCode is doing. On Linux, the process is called code
Get-Process -ProcessName code

# In macOS, it runs under the process called Electron (as VSCode is an 
# Electron app)
Get-Process -ProcessName Electron

# We can also launch a process, let's start Azure Data Studio
Start-Process 'azuredatastudio'

# Get the right label for the process, depending on the OS. Note that
# on macOS, when ADS runs it's proce name changes to 'Azure Data Stud'
# (and yes that is truncated). Run the right line for your OS
$procName = 'azuredatastudio' # Linux
$procName = 'Azure Data Stud' # macOS

# Let's see what it is doing. Note that even though we use 'azuredatastudio
Get-Process -Name $procName | Format-List

# We can also see the file that launched the process
Get-Process -Name $procName -FileVersionInfo | Select-Object FileName 

# We can see what user is running the process
Get-Process -Name $procName -IncludeUserName

# Get-Process returns object(s) with a lot of useful properties
# We can use Get-Member to list them
Get-Process | Get-Member

# Let's use a few of them to create a slightly different output
Get-Process -Name $procName |
  Format-Table ProcessName, Id, SI, CPU, TotalProcessorTime, Path, StartTime

# We can also stop it
Stop-Process -Name $procName

# If we try to call Get-Process on it now, it will error out
Get-Process -Name $procName

# Let's do something a bit more automated.
Start-Process 'azuredatastudio'

# You can use wildcards in the call
Get-Process 'azure*'

# Now let's pipe that list to stop process
Get-Process 'azure*' | Stop-Process 

# Let's see what is running
Get-Process 'azure*'

# Note how using a wild card prevents the error. When we looked for a specific
# process name, if it doesn't find it PowerShell returns an error. However,
# when we use a wildcard we're saying 'give me everything that starts with 
# azure and ends with anything else' so it returned all the processes it found,
# which in this demo were none.
