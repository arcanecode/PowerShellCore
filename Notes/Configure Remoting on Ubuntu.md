# Configure Remoting on Ubuntu

The instructions in this document show how to install then configure SSH. SSH is a prerequisite to remoting from inside PowerShell to a server. 

The first thing you'll need to do, if you've not done so already is install the openssh tools. You'll need to install the tools on both the client (the machine you want to remote _from_) and the server (the machine you want to remote _to_).
```bash
sudo apt -y install openssh-client openssh-server 
```
Next you'll need to configure the server. Login to the server itself, then use the following command to launch the vim editor with the file you need to edit. 
```bash
sudo vim /etc/ssh/sshd_config
```

In the sshd_config file, find and uncomment the following line. Note that in bash the # is used for comments, just like in PowerShell, so just delete the # from the beginning of the line and you'll be good to go. 
```bash
PasswordAuthentication yes
```

Next find the following line, make sure it is set to yes and uncomment it
```bash
PubKeyAuthentication yes
```
Toward the bottom of the file, you'll find the line: (it will not be commented out)
```bash
Subsystem sftp /usr/lib/openssh/sftp-server
```
Don't touch this line, but right after it hit enter to insert a blank line (just for looks) then add a comment:
```bash
# Add subsystem for PowerShell
```

Then add the following on the next line
```bash
Subsystem powershell /snap/powershell/current/opt/powershell/pwsh -sshs -NoLogo -NoProfile
```
This is assuming you are following along the previous demos, and installed PowerShell via a snap. If you installed it in a different manner, be sure to update the path above to reflect the location where PowerShell is installed on your system.

You're done editing, time to save the file (if in Insert mode hit ESC first) with :wq

For the changes to take effect, you'll need to restart ssh
```bash
sudo service sshd restart
```

Now you can ssh in from the terminal. You can do it two ways.

First, you can login using the ipaddress and user name. This is an example, you can determine the IP address to use by logging directly onto your server and running ifconfig. Of course you should replace 'arcanecode' with the user name you created.
```bash
ssh arcanecode@172.17.66.77
```
Alternatively, you can login with the username and machine name
```bash
ssh arcanecode@acubntu1810server
```
Either way you are prompted to see if you want to login, just type yes (you have to type in the full word yes, just a y won't work) then enter your password. 

## Logging in with Keys
In addition to logging in with a password you can login using a key. This is great for unattended scripts. 

First, you need to create a public / private key pair for ssh. Use the following command on the client computer (the one you will be sshing _from_) and (for purposes of this demo) accept all the defaults.
```bash
ssh-keygen -t rsa
```
Note: During the key generation you are prompted for a pass phrase. For this simple demo you can just hit enter to accept a blank pass phrase. However in a production system you should **_ALWAYS_** use a pass phrase. Make sure to store the pass phrase in a safe location others in your company can get to, such as a corporate LastPass account or similar repository. 

**If I catch you use a blank pass phrase in production, I'll come through this monitor and smack you with your keyboard.** 

If you want to see the key files, you can look in the .ssha folder
```bash
cd ~/.ssh
ls -l
```
Now you can copy your key to the server
```bash
ssh-copy-id acubuntu1810server
```
Don't worry about a path, ssh-copy-id knows to look in the .ssh folder for what it needs. 

Now you should be able to login with a simple:
```bash
ssh acubuntu1810server
```
(or whatever the server name is, or use the IP address)

Keys are specific to a client computer and the Id of the user logging into the server. Hence you'll need to create a key (using keygen) and ssh-copy it up to the target server. 


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

