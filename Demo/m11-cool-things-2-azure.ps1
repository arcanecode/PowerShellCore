<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Cool Things You Can Do with PowerShell - Azure

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 

  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
-----------------------------------------------------------------------------#>

# The Azure module can be found in the PowerShell Gallery. The PSGallery
# can be thought of as a repository. 

# First verify it is in the gallery and see its version
Find-Module Az

# See if the module is already on the system
Get-Module Az* -ListAvailable  

# Install the module
Install-Module Az


