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


# This script will do the setup of brew, PowerShell, and other components

# First, install Brew. Note, brew has a requirement on the XCode libraries, 
# and will download them if needed. It's about a 6 gig download, so if you
# plan to run this repeatedly on macOS virtual machines, you may want
# to go download it manually once then install as needed from your local
# download. Do know you have to have an Apple Developer ID in order to 
# download from Apple. 
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Next, we'll want to update the brew libraries
brew update

# Third, we need to run brew doctor. On some systems brew will find outdated
# libraries that must be cleaned up prior to other installs
# This is why the script is broken into two pieces. After 
# brew doctor runs, address any issues it finds. You can run 
# brew doctor repeatedly until it shows no issues. 
# After you get a clean bill of health, proceed to the 
# Setup-macOS-part-2.sh script.
brew doctor
