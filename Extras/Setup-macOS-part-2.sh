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


# This is the second half of the Setup-macOS-part-1 script. It picks up after
# you have run brew doctor and corrected any issues it found.

# Some of the installs have a dependacy on gcc, so let's make sure it is
# installed
brew install gcc

# Now you can install PowerShell Core
brew cask install powershell

# Next, install VSCode
brew cask upgrade
brew cask install visual-studio-code

# The last of the tools to install is Azure Data Studio
brew cask install azure-data-studio

# Finally you may want to cleanup your brew repository to remove 
# outdated info
brew cleanup



