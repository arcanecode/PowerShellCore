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

bash ./m11-install-docker.sh 

# Need to install the SqlServer Module. (You only need to do this once.)
Install-Module SqlServer

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


$sql = @"
CREATE DATABASE TeenyTinyDB 
"@
Invoke-Sqlcmd -Query $sql `
              -ServerInstance $serverName `
              -Database $dbName `
              -Username $userName `
              -Password $pw `
              -QueryTimeout $queryTimeout


$dbName = 'TeenyTinyDB'
$sql = @'
CREATE TABLE [dbo].[FavoriteYouTubers]
(
    [FYTID]       INT            NOT NULL PRIMARY KEY
  , [YouTubeName] NVARCHAR(200)  NOT NULL
  , [YouTubeURL]  NVARCHAR(1000) NOT NULL
)
'@
Invoke-Sqlcmd -Query $sql `
              -ServerInstance $serverName `
              -Database $dbName `
              -Username $userName `
              -Password $pw `
              -QueryTimeout $queryTimeout


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
Invoke-Sqlcmd -Query $sql `
              -ServerInstance $serverName `
              -Database $dbName `
              -Username $userName `
              -Password $pw `
              -QueryTimeout $queryTimeout

$sql = 'SELECT * FROM dbo.FavoriteYouTubers'
Invoke-Sqlcmd -Query $sql `
              -ServerInstance $serverName `
              -Database $dbName `
              -Username $userName `
              -Password $pw `
              -QueryTimeout $queryTimeout

$data = Invoke-Sqlcmd -Query $sql `
                      -ServerInstance $serverName `
                      -Database $dbName `
                      -Username $userName `
                      -Password $pw `
                      -QueryTimeout $queryTimeout
$data


