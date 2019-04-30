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
  # First, install some packages that will allow us to use a repository over https
  sudo apt-get -y install apt-transport-https 
  sudo apt-get -y install ca-certificates 
  sudo apt-get -y install curl 
  sudo apt-get -y install gnupg-agent 
  sudo apt-get -y install software-properties-common
  
  # Next we'll add dockers offical GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  
  # Now we can add the docker repository
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  
  # Finally! We can install Docker
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
  
fi 