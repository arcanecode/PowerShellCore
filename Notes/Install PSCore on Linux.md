Use the GUI

1. Open the Ubuntu Software store from the toolbar (orage A icon)
2. Click the Search icon.
3. Enter PowerShell. Show the regular powershell as well as the preview. 
4. Say this is one way to install, we'll show a second. 
5. While here, do another search for VSCode, explaining we'll be using it to do our scripts. 


Use the command line
1. PowerShell can be installed via a Snapcraft package, or simply a "snap".
2. Open a terminal window. 
3. Install the snapd application.

sudo apt install snapd

4. Install the PowerShell snap. 

snap install powershell --classic

By default snaps run in isolation. The --classic is needed so the installed package can interact with the rest of the machine.

5. Launch it by running pwsh. 

6. Run a simple command like Get-Help or Get-ChildItem

7. Now install VSCode via a snap

sudo snap install --classic vscode

8. Add the PowerShell extension. Click the extensions icon over on the left, lowermost icon in the top area
9. Type in PowerShell and hit enter.
10. Click on the PowerShell item. Click Install.
11. Test by doing a file, new, then file, save as, navigate to the documents folder, and use test1.ps1 as the name.
12. Enter a simple command and press F5 to run. 


8. Azure Data Studio is not availble via a snap. Have to install via a website.
