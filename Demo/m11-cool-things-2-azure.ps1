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




# Remove the ResourceGroup
Remove-AzResourceGroup $rg
Get-MyRGs




$securePW = ConvertTo-SecureString 'Ammie.6611.mvp' -AsPlainText -Force
$psCredential = New-Object System.Management.Automation.PSCredential('rccain@gmail.com', $securePW)
Connect-AzAccount -ServicePrincipal -Credential $psCredential -TenantId