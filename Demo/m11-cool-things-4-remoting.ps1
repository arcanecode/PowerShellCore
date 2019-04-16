$session = New-PSSession -HostName acubuntu1810server -UserName arcanecode

$session

Enter-PSSession -Session $session

# You will see the prompt change to the server name. Now any commands you
# run will be executed on the server.

Get-Process | Sort-Object CPU | Select-Object -First 10

# You can also run commands on a remote machine without having to enter its
# interactive terminal. First, exit the current remote session to return
# to the local computer
Exit-PSSession

# Now create the command you want to run in the form of a script block
$command = { Get-Process |
             Sort-Object CPU |
             Select-Object Name, WorkingSet, PrivateMemorySize, VirtualMemorySize, Id, SI -First 5 |
             Format-Table -AutoSize
           }

# Now  you can run the command on the remote machine without 
# having to Enter into a PSSession (aka ssh) into it
Invoke-Command $session -ScriptBlock $command |
  Format-Table -AutoSize
