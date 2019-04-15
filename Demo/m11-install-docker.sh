if [ -x "$(command -v docker)" ]; then
  echo "Docker is already installed"
else
  echo "Installing Docker"
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

fi 