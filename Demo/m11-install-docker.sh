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

# This script will install docker

if [ -x "$(command -v docker)" ]; then
  echo "Docker is already installed"
else
  echo "Installing Docker"
  sudo snap install docker
fi 