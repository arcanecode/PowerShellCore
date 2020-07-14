PowerShell

PowerShell 7.0.x is not officially supported on Ubuntu 20.04. Microsoft is considering supporting it with the 7.1 release. However, you can still install it using the instructions in the documents that are part of this project and it seems to work fine.



Setup-Ubuntu.sh

Line 27 - Now have to use vim in lowercase

Line 116 - The application name for the Ubuntu software store has changed in Ubuntu 20.04. When automating the adding of the favorite you need to change the name.


Configure VSCode.md

Note that the login method for storing your credentials has altered slightly. Instead of entering your credentials on the command line, VSCode now opens up a web browser and prompts you to login to github, then asks you to authorize the app. Once you do, VSCode will now let you check in / out without having to enter credentials each time.

m11-cool-things-3-remoting.ps1

Exit-PSSession hangs, just hit Ctrl+C and it will finish and exit the session.

