Steps to install PowerShell Core

Install Brew:
https://coolestguidesontheplanet.com/installing-homebrew-on-macos-sierra-package-manager-for-unix-apps/

First, install brew:
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Then do: brew update
followed by: brew doctor
Follow recommendations that the doctor gives


brew cask install powershell

If you already installed PowerShell and just want to update it, you can use

brew cask upgrade

This will upgrade all casks on your system, including PowerShell. 

You may have to install gcc

brew install gcc

If you have issues during the install, check out these web pages

https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6

https://apple.stackexchange.com/questions/209624/how-to-fix-homebrew-error-invalid-active-developer-path-after-upgrade-to-os-x

After installing, do a
pwsh
to enter powershell. If it works, issue a Update-Help to update all the help files