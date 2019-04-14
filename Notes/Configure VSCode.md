
# Linux
## Adding Git
1. If git is not installed go to https://git-scm.com/download and install it
2. On your local drive, create the folder code\pscore under documents
3. Now in VSCode, use Ctrl+Shift+P to bring up the command pallet
3. Enter the command Git:Clone
4. Enter the url for your repository. For this example I'm using
   https://github.com/arcanecode/PowerShellCore 
5. Enter your user id and password

## After you make changes in VSCode
Go to the source control tab to see list of changes
Enter a comment, and press Ctrl+Enter or hit the check mark
Once committed, use the ... menu and pick Push.
To pull changes, go to SCM and use a Pull.

## To cache your passwords:

All OS:
```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```
### Three Choices for caching. First, using caching in memory with a default timeout
```bash
$ git config --global credential.helper cache
```
### Second, you can specify a time limit
In this example we'll set the cache to one hour (timeout takes the number of seconds as a parameter)
```bash
$ git config --global credential.helper 'cache --timeout=3600'
```
### Third choice, you can put your credentials in the credentail helper store and never enter again!

In this example replace my repository with the name of your own repository.

```bash
$ git config credential.helper store
$ git push https://github.com/arcanecode/PowerShellCore
```
When prompted enter your user id and password

If successful, you'll see "Everything up-to-date".

Be aware this is stored in plain text on your drive, you'll have to decide if this
is worth the trade off. For more info see:
https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitcredentials.html#_avoiding_repetition

(Note I chose to store them using the last method because I have drive encryption
enabled as well as a good login password. And I'm lazy.)

# Windows
1. Install Git
2. Restart VSCode
3. Open, do a Git: Clone
4. Open a new terminal window
5. Use the following command to cache credentials permanently:
   git config --global credential.helper wincred

(The wincred will take the credentials you last used for loging and store them in the cache)


# macos

## Git and the osxkeychain helper
First, install Git and the osxkeychain helper and tell Git to use it.

    Find out if Git and the osxkeychain helper are already installed:
```bash
    $ git credential-osxkeychain
```    

    If the osxkeychain helper isn't installed and you're running OS X version 10.9 or above, your computer will prompt you to download it as a part of the Xcode Command Line Tools, as in the example below:
```bash
    $ git credential-osxkeychain
    > xcode-select: note: no developer tools were found at '/Applications/Xcode.app',
    > requesting install. Choose an option in the dialog to download the command line developer tools.
```
    Alternatively, you can install Git and the osxkeychain helper by using Homebrew:

```bash
    $ brew install git
```
    Tell Git to use osxkeychain helper using the global credential.helper config:
```bash
    $ git config --global credential.helper osxkeychain
```

The next time you clone an HTTPS URL that requires a password, you'll be prompted for your username and password, and to grant access to the OSX keychain. After you've done this, the username and password are stored in your keychain and you won't be required to type them in to Git again.

From:
https://help.github.com/en/articles/caching-your-github-password-in-git