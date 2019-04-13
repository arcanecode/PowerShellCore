

Adding Git
1. Create the folder code\pscore under documents
2. Ctrl+Shift+P to bring up the command pallet
3. Git:Clode
4. Enter the url
   https://github.com/arcanecode/PowerShellCore 
5. Enter user id and password

Make changes
Go to the source control tab to see list of changes
Enter a comment, and press Ctrl+Enter or hit the check mark
Once committed, use the ... menu and pick Push.
To pull changes, go to SCM and use a Pull.

To cache your passwords:

All OS:
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com


Linux:
$ git config --global credential.helper cache
# Set git to use the credential memory cache, default timeout of 15 minutes

OR you can specify a time limit

$ git config --global credential.helper 'cache --timeout=3600'
# Set the cache to timeout after 1 hour (setting is in seconds) 

# We'll use
$ git config --global credential.helper 'cache --timeout=28800'

Windows
1. Install Git
2. Restart VSCode
3. Open, do a Git: Clone
4. Open a new terminal window
5. Use the following command to cache credentials:
   git config --global credential.helper wincred

macos
Install Git and the osxkeychain helper and tell Git to use it.

    Find out if Git and the osxkeychain helper are already installed:

    $ git credential-osxkeychain
    # Test for the cred helper
    > Usage: git credential-osxkeychain <get|store|erase>

    If the osxkeychain helper isn't installed and you're running OS X version 10.9 or above, your computer will prompt you to download it as a part of the Xcode Command Line Tools:

    $ git credential-osxkeychain
    > xcode-select: note: no developer tools were found at '/Applications/Xcode.app',
    > requesting install. Choose an option in the dialog to download the command line developer tools.

    Alternatively, you can install Git and the osxkeychain helper by using Homebrew:

    $ brew install git

    Tell Git to use osxkeychain helper using the global credential.helper config:

    $ git config --global credential.helper osxkeychain
    # Set git to use the osxkeychain credential helper

The next time you clone an HTTPS URL that requires a password, you'll be prompted for your username and password, and to grant access to the OSX keychain. After you've done this, the username and password are stored in your keychain and you won't be required to type them in to Git again.

From:
https://help.github.com/en/articles/caching-your-github-password-in-git