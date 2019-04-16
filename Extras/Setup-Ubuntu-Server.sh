#------------------------------------------------------------------------------
# Install Snap, PowerShell, and network tools
#------------------------------------------------------------------------------

# First make sure everything is up to date
sudo apt-get -y update

# Go ahead and install the network tools so we can use things like ifconfig
sudo apt -y install net-tools

# Now install the snap application
sudo apt -y install snapd

# With snap installed, we can install PowerShell
sudo snap install powershell --classic

#------------------------------------------------------------------------------
# Docker Installation
#------------------------------------------------------------------------------

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

# Now lets grab the docker container for SQL Server
sudo docker pull mcr.microsoft.com/mssql/server:2017-latest

# OK it's time to run what we just downlaoded
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=passW0rd!' \
   -p 1433:1433 --name ubuntusql \
   -d mcr.microsoft.com/mssql/server:2017-latest
