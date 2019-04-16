<#-----------------------------------------------------------------------------
  Getting Started with PowerShell Core on Linux and macOS
  Cool Things You Can Do with PowerShell - Azure

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 
  
  This module may not be reproduced in whole or in part without the express
  written consent of the author and/or Pluralsight. It can be used within
  your own projects.
  -----------------------------------------------------------------------------#>
  
# The Azure module can be found in the PowerShell Gallery. The PSGallery
# can be thought of as a repository. 

# First verify it is in the gallery and see its version
Find-Module Az

# See if the module is already on the system
Get-Module Az* -ListAvailable  

# Install the module
Install-Module Az

# Login to Azure Interactively
Connect-AzAccount

# Get your subscriptions - This lists all the subscriptions associated with
# your accounts login
Get-AzSubscription

# To see which of the subscriptions you are currently running under, get
# the context
Get-AzContext

# You can change which subscription you are using by changing the context to 
# the SubscriptionName
Set-AzContext 'Visual Studio Ultimate with MSDN'

#-----------------------------------------------------------------------------#
# Resource Groups
#-----------------------------------------------------------------------------#

# Resource Groups are the basis for all things Azure. Everything must go in
# a resource group. Let's see what resource groups we have...
Get-AzResourceGroup

# That's a bit hard to read, let's make it a nice table
Get-AzResourceGroup |
  Select-Object ResourceGroupName, Location |
  Sort-Object ResourceGroupName |
  Format-Table

# This is a useful little command, let's make it a function
function Get-MyRGs ()
{
  Get-AzResourceGroup |
  Select-Object ResourceGroupName, Location |
  Sort-Object ResourceGroupName |
  Format-Table
} 

# And test it...
Get-MyRGs

# Let's create a new resource group
$rgName = 'PowerShellCoreCourse'
$locName = 'southcentralus'
New-AzResourceGroup -Name $rgName -Location $locName

# Just to make sure it is really there....
Get-MyRGs


#-----------------------------------------------------------------------------#
# Storage Accounts
#-----------------------------------------------------------------------------#

# For our next task, let's create a storeage account. Storage accounts hold a 
# wide variety of things, like files, virtual machines, and databases.

# Let's see if we have any storage accounts
Get-AzStorageAccount -ResourceGroupName $rgName

# When we create a storage account, we need to create it in a resource group,
# so we'll be using the RG we just created. 

# In addition there are a few things you need to know about.
# SkuName - Standard_LRS - Locally redundant storage
#           Standard_ZRS - Zone redundant storage
#           Standard_GRS - Geo-redundant storage
#           Standard_RAGRS - Read access geo redundant storage
#           Premium_LRS    - Premium locally redundant storage
# (SkuName was known as Type in the AzureRm version of this cmdlet)

# Storage account names must be between 3 and 24 characters in length,
# and can only be lowercase and numbers
$saName = 'pscorestorage'
New-AzStorageAccount -ResourceGroupName $rgName `
                     -Name $saName `
                     -Location $locName `
                     -SkuName Standard_LRS 


# Storage Context
# Storage Accounts manage one or more storage containers. It is the containers
# that actually hold things like files and databases. Rather than having to pass
# storage account credentials around, each account can return a token called
# the Storage Context. 

# Before you can retrieve the context token, you have to have the key 
# associated with this storage account, so let's first get that.

$saKeys = Get-AzStorageAccountKey -ResourceGroupName $rgName `
                                  -Name $saName

# Let's take a second to look at what this returns
$saKeys

# When we run this, it actually returns an array of objects. Each account
# has two keys associated with it. For our purposes we only need one, so 
# lets just grab the value property from the first key object in the array
# (Remember, in PowerShell arrays are 0 based)
$saKey = $saKeys[0].Value

# Now that we have the key, we can generate a new token. Note that this cmdlet
# only generates a new context token in memory, it doesn't actually change
# anything on the Azure servers
$saContext = New-AzStorageContext -StorageAccountName $saName `
                                  -StorageAccountKey $saKey 


# OK, we now have a storage account, got the key for it, and from it was able
# to create a context. Now we're finally ready to create a container. Before
# we do, there's on parameter that needs some explanation

# Permission - Off - Only the storage account owner can see this container
#              Blob - Provides anonymous access the ability to a specific
#                     blob, but not to other data in the container
#              Container - Provides full read access to everything in the 
#                          container
# For our purposes we can use Container, since this is just a demo

# Also note that just like storage accounts, container names must be between 
# 3 and 24 characters in length, and can only be lowercase and numbers

$containerName = 'pscorecoursecontainer'
New-AzStorageContainer -Name $containerName `
                       -Context $saContext `
                       -Permission Container

# When we want we can see the containers associated with the storage account
# by passing in the storage account's context
Get-AzStorageContainer -Context $saContext

# Let's upload some files. 
$localLocation = Get-Location
Set-Location "$($localLocation)\Demo"

# Get a list of all the PowerShell files
$psfiles = Get-ChildItem *.ps1
$timeOut = 500000

foreach($psfile in $psfiles)
{
  # FullName is the full path and file name
  # Name is only the name of the file (with extension)
  # I have a slow internet, so to prevent time outs I set it to a high number
  # The Force switch will overwrite a file if it already exists
  Set-AzStorageBlobContent -File $psfile.FullName `
                           -Container $containerName `
                           -Blob $psfile.Name `
                           -Context $saContext `
                           -ServerTimeoutPerRequest $timeOut `
                           -ClientTimeoutPerRequest $timeOut `
                           -Force 
}

# Now let's see what made it
Get-AzStorageBlob -Container $containerName -Context $saContext

#-----------------------------------------------------------------------------#
# Databases
#-----------------------------------------------------------------------------#

# For this next demo we're going to create an Azure SQL database. We'll do
# so by taking a backup (in the form of a bacpac) and uploading it to Azure.
# To make things easy, I've included a sample bacpac as part of this project.
# To get access to the full TeenyTinyDB project, see the project on my github 
# site at: https://github.com/arcanecode/TeenyTinyDB

# First thing is to get a reference to the file
$bacpac = Get-ChildItem 'TeenyTinyDB.bacpac'

# Next we'll upload it to the Azure storage container. We'll just use the
# one we created in the previous steps.
Set-AzStorageBlobContent -File $bacpac.FullName `
                         -Container $containerName `
                         -Blob $bacpac.Name `
                         -Context $saContext `
                         -ServerTimeoutPerRequest $timeOut `
                         -ClientTimeoutPerRequest $timeOut `
                         -Force 

# Now we need to generate a SQL Server
$serverName = 'pscorecoursesqlserver'
$adminName = 'ArcaneCode'
$pw = 'myModeratelyInsecurePassword1'

# As part of this we'll need a set of secure credentials
$pwSecure = $pw | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object pscredential ($adminName, $pwSecure)

New-AzSqlServer -ResourceGroupName $rgName `
                -ServerName $serverName `
                -Location $locName `
                -SqlAdministratorCredentials $cred

# We now have a server, but can't get to it. We need to add a firewall rule 
# to let us in
$firewallRuleName = 'ArcaneCodesFirewallRule'

# You then need to set an IP address range that the firewall rule will let in.
# As the network commands have not yet been implemented as of version 6.2 of
# PowerShell Core (the version used for this course) you'll have to enter
# the address manually. For one computer you can use the same address for
# both the start adn ending IP address. Or, you can use a range of addresses.
# (To use noncontinguous addresses add one rule for each address, you can
#  have as many rules as you need)

# For demo purposes we'll select a wide range, especially as this will 
# only exist for the duration of the demo. When setting this up for production
# use make sure to use a narrow, specific range of IP addresses.
$startIP = '0.0.0.0'
$endIP = '255.255.255.255'

# Now create the rule
New-AzSqlServerFirewallRule -ResourceGroupName $rgName `
                            -ServerName $serverName `
                            -FirewallRuleName $firewallRuleName `
                            -StartIpAddress $startIP `
                            -EndIpAddress $endIP

# Now we can begin the process to import the bacpac file into our new
# SQL Server. First we need to choose the database edition we want, 
# for this we can just use Basic. (See online documentation for other levels)
$dbEdition = 'Basic'
$serviceObjectiveName = 'Basic'
$dbName = 'TeenyTinyDB'
$dbMaxSizeBytes = 5000000

# Before we can import the bacpac, we need to know where it is. This will give
# us the equivalent to the URL (web address) of the file in the container
# Note for simplicity I used the same name for both the backup file and the
# database we'll restore to, although this isn't required. 
$storageUri = ( Get-AzStorageBlob `
                 -blob "$($dbName).bacpac" `
                 -Container $containerName `
                 -Context $saContext `
              ).ICloudBlob.uri.AbsoluteUri


$request = New-AzSqlDatabaseImport `
              -ResourceGroupName $rgName `
              -ServerName $serverName `
              -DatabaseName $dbName `
              -StorageKeyType StorageAccessKey `
              -StorageKey $saKey `
              -StorageUri $storageUri `
              -AdministratorLogin $cred.UserName `
              -AdministratorLoginPassword $cred.Password `
              -Edition $dbEdition `
              -ServiceObjectiveName $serviceObjectiveName `
              -DatabasemaxSizeBytes $dbMaxSizeBytes  

# After starting the import, Azure immediately returns control to PowerShell.
# We will need to call another cmdlet to check the status. Here we've created
# a loop to call it ever 10 seconds and check the status. For a large database
# you will likely want to up the time to minutes or maybe even hours. The loop
# will end once we no longer get the InProgress message.

# Just a flag to keep the while loop going
$keepGoing = $true

# It can be useful to know how long loads take. Using a stopwatch can
# make this easy.
$processTimer = [System.Diagnostics.Stopwatch]::StartNew()

# Keep looping until we find out it is done. 
while ($keepGoing -eq $true)
{
  # This will tell us the status, but we will need the request object
  # returned by our function New-PSAzureSQLDatabaseImport
  $status = Get-AzSqlDatabaseImportExportStatus `
               -OperationStatusLink $request.OperationStatusLink
  
  if ($status.Status -eq 'InProgress') # Display a progress message
  {
    Write-Host "$((Get-Date).ToLongTimeString()) - $($status.StatusMessage)" `
      -ForegroundColor DarkYellow
    Start-Sleep -Seconds 10
  }
  else                                 # Let user know we're done
  {
    $processTimer.Stop()
    Write-Host "$($status.Status) - Elapsed Time $($processTimer.Elapsed.ToString())" `
      -ForegroundColor Yellow
    $keepGoing = $false
  }
}

Get-AzSqlDatabase -ResourceGroupName $rgName `
                  -ServerName $serverName |
  Select-Object ResourceGroupName, ServerName, DatabaseName, Status

# Now let's run a simple SQL query against the database. In order to do a SQL
# query though, you'll first need to install the SQL Server module onto this
# computer from the PSGallery, if you've not done so already.
# Uncomment the next line in order to install it, note you only have to do
# this once.
# Install-Module SqlServer

# As we did in the previous demo (m11-cool-things-1-docker) let's use
# splatting to make parameter reuse easier
$queryTimeout = 500000

$sqlParams = @{ "ServerInstance" = "$serverName.database.windows.net" ;
                "Database" = $dbName ;
                "Username" = "$adminName@$serverName" ;
                "Password" = $pw ;
                "QueryTimeout" = $queryTimeout
              }


$sql = 'SELECT * FROM dbo.FavoriteYouTubers'
Invoke-Sqlcmd -Query $sql @sqlParams

# Here we only ran one statement, but you could easily run scripts.
# This array holds the SQL files we want to run. For this demo we only have
# one, but you could easily add more 
$sqlScripts = @( 'DebugLog.sql'
               #, 'DB-AddUser.sql'
               )

# Just a simple array that reads each file into memory. The -Raw is very 
# important, without it the script will be loaded as an array. With -Raw,
# the file is loaded as one big text string into the $sql variable.
foreach ($sqlScript in $sqlScripts)
{ 
  # Show a nice little message letting user know what we're doing
  Write-Host "Executing $sqlScript" -ForegroundColor Yellow

  # Create a variable with the full path\file to load. (Note $pwd is a built
  # in variable in PowerShell)
  $sqlFile = "$pwd\$sqlScript"

  # Read in the contents of the file into a variable
  $sql = Get-Content -Path $sqlFile -Raw

  # Invoke-Sqlcmd is use to run SQL scripts against SQL databases,
  # whether local or AzureSQL. For AzureSQL, the full server name will be
  # the name of the server followed by .database.windows.net

  # The username will be the user name followed by @ and the server name
  # (without the database.windows.net)
  
  # The password should be the unencrypted, plain text password

  Invoke-Sqlcmd -Query $sql @sqlParams
}

Write-Host "Done updating $dbName" -ForegroundColor Yellow

# Now let's test it.
$sql = "EXEC dbo.LogMessage 'A test log message at $(Get-Date)'"
Invoke-Sqlcmd -Query $sql @sqlParams

$sql = @'
SELECT * 
  FROM dbo.DebugLog
 ORDER BY [Log Time] DESC
'@
Invoke-Sqlcmd -Query $sql @sqlParams

# You could of course use Invoke-SqlCmd to create tables, read or update data,
# and more. Anything you could do in normal T-SQL can be done via the
# Invoke-Sqlcmd cmdlet.

#-----------------------------------------------------------------------------#
# Cleanup
#-----------------------------------------------------------------------------#

# Well we've got quite a mess now, with files, databases, SQL Servers, and
# more cluttering up our Azure instance. We can remove individual items, or
# we can remove everything in one fell swoop. 

# Let's first look at removing individual objects, as it's more likely you
# will want to create then remove individual objects. A quick note,
# on all of these we are using the -Force switch. This prevents the  "Are you
# sure" messages from popping up. 

# Remove just the SQL Database (You could also use Invoke-SQLcmd 
# to drop the database, tables, etc)
Remove-AzSqlDatabase -ResourceGroupName $rgName `
                     -ServerName $serverName `
                     -DatabaseName $dbName `
                     -Force

# You can also remove a firewall rule, for example you no longer need
# a certain IP address to have access to the server
Remove-AzSqlServerFirewallRule `
                     -ResourceGroupName $rgName `
                     -ServerName $serverName `
                     -FirewallRuleName $firewallRuleName `
                     -Force

# You can remove the entire SQL Server. Be warned, when you do this it
# removes the server and all of the data inside it! So be absolutely
# sure this is what you want to do. 
Remove-AzSqlServer -ResourceGroupName $rgName `
                   -ServerName $serverName `
                   -Force

# In addition to the database we can also remove the storage components
# First we'll get rid of the container. This deletes everything stored in 
# the container, then the container itself. 
Remove-AzStorageContainer -Name $containerName -Context $saContext -Force

# We can also remove the storage account, which removes everything associated
# with it, such as one or more containers.
Remove-AzStorageAccount -ResourceGroupName $rgName -Name $saName -Force

# Before we hit the last item, I want to mention that it is not necessary
# to remove children of an object in order to remove the object itself.
# For example, if we delete the SQL Server, it automatically rolls down
# and deletes all the databases, firewall rules, etc. 

# Likewise if you delete a storage account, it automatically deletes all
# of the things, such as containers, associated with it. 

# That said, we now come to the final option: Deleting the Resource Group.
# Removing the resource group deletes EVERYTHING associated with it. Depending
# on how you organize your Azure instance this could be catastropic. As in
# dust off your resume and begin contacting recruiters catastropic. 

# You need to be very very very very very very very very very very very very
# very very very very very very very very very very very very very very very 
# careful with it. 

# That said, it can be a quick and efficient way for you to clean up after
# are done experimenting, or perhaps you want to reset Azure so you can 
# do another test of some scripts which will setup your Azure instance as
# you need it. 

# Remove the ResourceGroup. (Note for safety not using -Force here!)
Remove-AzResourceGroup $rgName

# Remember this function we created back at the start? Lets use it one last 
# time to verify our resource group is gone.
Get-MyRGs

