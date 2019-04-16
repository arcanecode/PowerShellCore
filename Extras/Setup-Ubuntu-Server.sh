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
# Install openssh
#------------------------------------------------------------------------------
sudo apt -y install openssh-client openssh-server 

# Next you'll need to configure the server
# sudo vim /etc/ssh/sshd_config

# Find and uncomment the line 
# PasswordAuthentication yes
# Note that bash uses # for comments like PowerShell, so in the sshd_config 
# file just remove the # from the start of the line to uncomment it.


# Next find the following line, make sure it is set to yes and uncomment it
# PubKeyAuthentication yes

# Toward the bottom of the file, you'll find the line: (it will not be commented out)
# Subsystem sftp /usr/lib/openssh/sftp-server

# After that line, first add a comment:
# Add subsystem for PowerShell

# Then add the following line, not commented out
# Subsystem powershell /snap/powershell/current/opt/powershell/pwsh -sshs -NoLogo -NoProfile

# Save the file (if in Insert mode hit ESC) with :wq

# Restart ssh
# sudo service sshd restart

# Now you can ssh in from the terminal. You can do it two ways.
# First, you can login using the ipaddress and user name
# ssh arcanecode@172.17.66.77

# Or you can login with the username and machine name
# ssh arcanecode@acubntu1810server

# Either way you are prompted to see if you want to loign, just type
# yes (have to type in full yes, just a y won't work) then enter your
# password. 

# Logging in with Keys
# In addition to logging in with a password you can login using a
# key. This is great for unattended scripts. 

# First, you need to create a public / private key pair. Use the following
# command on the client computer(the one sshing from) and accept all 
# the defaults.
# ssh-keygen -t rsa

# Note: During the key generation you are prompted for a pass phrase.
# For this simple demo you can just hit enter to accept a blank pass phrase.
# However in a production system you should ALWAYS use a pass phrase.
# Make sure to store the pass phrase in a safe location others in your
# company can get to, such as a corporate LastPass account or similar 
# repository. 

# If I catch you use a blank pass phrase in production, I'll come 
# through this monitor and smack you with your keyboard. 

# If you want to see the key files, you can look in the .ssha folder
# cd ~/.ssh
# ls -l

# Now you can copy your key to the server
# ssh-copy-id acubuntu1810server

# Now you should be able to login with a simple:
# ssh acubuntu1810server
# (or whatever the server name is, or use the IP address)




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
