<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Cool Things You Can Do with PowerShell - Docker

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 

  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
-----------------------------------------------------------------------------#>

# First, make sure to set the location correctly for your system. Two 
# examples are below.

# Linux
Set-Location '/home/arcanecode/Documents/code/PowerShellCore'

# macOS
Set-Location '/Users/arcanecode/Documents/code/pscore/PowerShellCore' 

#------------------------------------------------------------------------------
# Creating our Docker container with SQL Server
#------------------------------------------------------------------------------

# Now install Docker (if needed) then download and run the container
# for SQL Server.

<#
  Installing Docker

  Linux (Ubuntu)
  As a demo, we've included a bash shell script to check to see if
  Docker is already installed. If not, the script will install it.
  In addition, this shows how you can run a bash shell script from
  inside of PowerShell. The script is included with the project files.

  bash ./Demo/m11-install-docker.sh 

  macOS
  For macOS, it's presumed you followed the instructions in the 
  included document "Install PSCore on macOS.md", found in the Notes
  folder of the project. 
#>

<#
  Installing the Docker Container with SQL Server

  Assuming you have Docker already installed, and be sure to run it 
  manually at least once and login, you can run the following docker 
  command to download the container holding SQL Server 2017:
#>

docker pull mcr.microsoft.com/mssql/server:2017-latest

# If you want, you can verify it now exists
docker image ls 

<#
  With the container downloaded, we can now run it. The following will 
  launch the container. First we need to tell SQL Server we accept
  the license. Then we need to provide a password for the SA account.

  Next we give the port numbers SQL Server will listen on. By default, 
  SQL Server uses port 1433, so we will use that for both from and to.

  Next we provide a friendly name for our container, here I'm using 
  arcanesql. This is the name we can then use to start, stop, delete,
  and issue other docker commands to for that container. 

  Finally, we tell docker what image we want to use.

  OK it's time to run our container. You can enter these one line at
  a time, the \ is the "command continued" or (in a script) line continuation
  character in bash. 

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=passW0rd!' \
  -p 1433:1433 --name arcanesql \
  -d mcr.microsoft.com/mssql/server:2017-latest

  Or if you prefer you can just cut and paste this in a single line:
#>

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=passW0rd!' -p 1433:1433 --name arcanesql -d mcr.microsoft.com/mssql/server:2017-latest

# You can verify the container was installed and is running by 
# listing the containers on your system
docker container ls

#------------------------------------------------------------------------------
# Working with SQL Server from PowerShell
#------------------------------------------------------------------------------

# Now we eed to install the PowerShell SqlServer Module, so we can access
# SQL Server inside PowerShell. (You only need to do the install once.)
Install-Module SqlServer

# After installing you can update your module using:
Update-Module SqlServer

$serverName = 'localhost,1433'
$dbName = 'master'
$userName = 'sa'
$pw = 'passW0rd!'
$queryTimeout = 50000

$sql = "SELECT * FROM master.INFORMATION_SCHEMA.Tables"
Invoke-Sqlcmd -Query $sql `
              -ServerInstance $serverName `
              -Database $dbName `
              -Username $userName `
              -Password $pw `
              -QueryTimeout $queryTimeout


# Splatting
# As you see, Invoke-SqlCmd has a lot of parameters. If we are going to execute
# this cmdlet over and over, we can save typing and space by using a technique
# called 'splatting'. Essentiall, you create a hash table with the parameter
# / value pairs, then pass that to the cmdlet. In this case Invoke-Sqlcmd, but
# the technique will work on any cmdlet.

# Note in this example we are filling from variables, but we could also 
# hard code the values or use any other method to generate a value
$sqlParams = @{ "ServerInstance" = $serverName;
                "Database" = $dbName;
                "Username" = $userName;
                "Password" = $pw;
                "QueryTimeout" = $queryTimeout
              }

$sql = @"
CREATE DATABASE TeenyTinyDB 
"@
Invoke-Sqlcmd -Query $sql @sqlParams

# As you can see the above was much simplier to enter, to read, and makes the
# code much more compact. Do note one thing, when passing in the hashtable
# you'll need to replace the $ with an @ symbol. This tells PowerShell to
# look for a hashtable type variable and use the contents as parameters

# We can also update values in the hashtable, just like we would normally.
$dbName = 'TeenyTinyDB'
$sqlParams["Database"] = $dbName

# Now proceed normally with the updated database name
# Let's create a table
$sql = @'
CREATE TABLE [dbo].[FavoriteYouTubers]
(
    [FYTID]       INT            NOT NULL PRIMARY KEY
  , [YouTubeName] NVARCHAR(200)  NOT NULL
  , [YouTubeURL]  NVARCHAR(1000) NOT NULL
)
'@
Invoke-Sqlcmd -Query $sql @sqlParams

# Next insert some data into the table
$sql = @'
INSERT INTO [dbo].[FavoriteYouTubers]
  ([FYTID], [YouTubeName], [YouTubeURL])
VALUES
  (1, 'AnnaKatMeow', 'https://www.youtube.com/channel/UCmErtDPkJe3cjPPhOw6wPGw')
, (2, 'AdultsOnlyMinecraft', 'https://www.youtube.com/user/AdultsOnlyMinecraft')
, (3, 'Arcane Training and Consulting', 'https://www.youtube.com/channel/UCTH58i-Gl1bZeATOeC4f25g')
, (4, 'Arcane Tube', 'https://www.youtube.com/channel/UCkR0kwYjQ_gngZ8jE3ki7xw')
, (5, 'PowerShell Virtual Chapter', 'https://www.youtube.com/channel/UCFX97evt_7Akx_R9ovfiSwQ')
'@
Invoke-Sqlcmd -Query $sql @sqlParams

# Let's read back what we just wrote
$sql = @'
SELECT [FYTID]
     , [YouTubeName]
     , [YouTubeURL] 
  FROM dbo.FavoriteYouTubers
'@
Invoke-Sqlcmd -Query $sql @sqlParams

# We can also take the data and place it in a variable
$data = Invoke-Sqlcmd -Query $sql @sqlParams

# And display it back, or work with it however we want
$data

#------------------------------------------------------------------------------
# Cleanup
#------------------------------------------------------------------------------

# When done you may wish to cleanup. First, get a listing to refresh 
# yourself on names and other info
docker container ls

# The above version only lists running containers. If you want to see all
# containers, running or not, you can use:
docker ps -a 

# Next, stop your SQL Server container, passing in the name from the 
# Names column
docker stop arcanesql 
docker ps -a 

# Stopping the container will help save memory. If you want to start it
# back up, simply use
docker container start arcanesql 

# You can also delete the docker container all together. First, stop it,
# then use the rm command to remove it.
docker stop arcanesql 
docker rm arcanesql

# You can also combine these into a single step using the force switch
docker rm --force arcanesql

# Now we can use the listing command to validate it is gone
docker ps -a 

# This removed the container, but the downloaded image for
# SQL Server is still on our system. Let's verify this:
docker image ls 

# We can remove the image using the same name we used to pull it
docker image rm mcr.microsoft.com/mssql/server:2017-latest

# And let's verify it is gone
docker image ls 
