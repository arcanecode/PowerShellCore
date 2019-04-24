# Installing Docker on Ubuntu

Installing Docker on Ubuntu from the command line is a multistep process

First, install some packages that will allow us to use a repository over https
```bash
  sudo apt-get install apt-transport-https 
  sudo apt-get install ca-certificates 
  sudo apt-get install curl 
  sudo apt-get install gnupg-agent 
  sudo apt-get install software-properties-common
```

In order to fully install Docker, you'll need to add Dockers offical GPG key to the system
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```  

Now we can add the docker repository
```bash
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
```  
Finally! We can install Docker
```bash
  sudo apt-get install docker-ce docker-ce-cli containerd.io
```

If you want to go ahead and install SQL Server, first you need to download its image
```bash
sudo docker pull mcr.microsoft.com/mssql/server:2017-latest
```

Now you can run what we just downlaoded. A few notes:
The -e is extra pieces info. Make sure to use a good password for the SA account
The -p is the port number to use, 1433 is the default for SQL Server. 
The --name is what you want to name your server, use a name of your selection here
Finally -d is the image we should run, which should match the image name we downloaded in the previous step.
```bash
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=passW0rd!' \
     -p 1433:1433 --name arcanesql \
     -d mcr.microsoft.com/mssql/server:2017-latest
```


## Extra - checking to see if docker exists
You might want to include some code to see if Docker already exists on your system. If so you can use this simple template
```bash
if [ -x "$(command -v docker)" ]; then
  echo "Docker is already installed"
else
  echo "Install Docker"
fi
```
### References
https://docs.docker.com/install/linux/docker-ce/ubuntu/



---


## Author Information

### Author
Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites
Github: http://arcanerepo.com
Main: http://arcanecode.me 

### Copyright Notice
This document is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarentee is implied or expressly granted. 

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.

