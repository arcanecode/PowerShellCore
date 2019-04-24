# Install SQL Server as a Docker Container
## Download SQL Server 
First, download the Docker container for SQL Server
```bash
sudo docker pull mcr.microsoft.com/mssql/server:2017-latest
```

## Run SQL Server
Now launch the container with SQL Server.
```bash
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
   -p 1433:1433 --name sql1 \
   -d mcr.microsoft.com/mssql/server:2017-latest
```

## Connecting from Azure Data Studio
To connect to SQL Server inside Azure Data Studio in Ubuntu, use localhost,1433 as the server name, sa as user, and enter your password. 

## Other tips and tricks
To view your containers:
```bash
sudo docker ps -a   
```

To open a bash session inside the docker container
```bash
sudo docker exec -it arcanesql "bash"
```
From there you can test SQL by entering a sqlcmd session
```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '<YourNewStrong!Passw0rd>'
```
You can then see what is in master:
```sql
SELECT * FROM master.INFORMATION_SCHEMA.TABLES
GO
```

Source:
https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-ver15#pullandrun2019


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

