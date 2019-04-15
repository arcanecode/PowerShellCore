# This script will do a complete run thru setting up most of what you need on Ubuntu

# First make sure everything is up to date
sudo apt-get update

# Install git
sudo apt install git-all

# Now install the snap application
sudo apt install snapd

# With snap installed, we can install PowerShell
sudo snap install powershell --classic

# Next, we can install VSCode
sudo snap install --classic code

# Go ahead and install the network tools so we can use things like ifconfig
sudo apt install net-tools

# There are some prerequsites we can install for Azure Data Studio
sudo apt-get install libxss1
sudo apt-get install libgconf-2-4
sudo apt-get install libunwind8

# Note - ADS still not working right, need a good d/l link. Disabled for now.
# Now download Azure Data Studio
# wget -p /home/Downloads "https://go.microsoft.com/fwlink/?linkid=2083327"

# And install it. Note at the time this was created, 1.5.2 was the current
# version. You should check online at 
# https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017
# for the current version number, then update the file name below to match it.
# cd ~
# sudo dpkg -i ./Downloads/azuredatastudio-linux-1.5.2.deb

# Now we'll install Docker

# First, install some packages that will allow us to use a repository over https
sudo apt-get install apt-transport-https 
sudo apt-get install ca-certificates 
sudo apt-get install curl 
sudo apt-get install gnupg-agent 
sudo apt-get install software-properties-common

# Next we'll add dockers offical GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Now we can add the docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Finally! We can install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Now lets grab the docker container for SQL Server
sudo docker pull mcr.microsoft.com/mssql/server:2017-latest

# OK it's time to run what we just downlaoded
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=passW0rd!' \
   -p 1433:1433 --name arcanesql \
   -d mcr.microsoft.com/mssql/server:2017-latest

