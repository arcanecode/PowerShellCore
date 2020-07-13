# Configuring VSCode

There are some tweaks you may want to make when working with VSCode. This document covers some of them, note though they are not required.

In the first section we cover an importatn note on running VSCode in a Parallels Virtual Machine. In the second section we go over installing, configuring and using git in VSCode. The final section is some extra settings you may want to apply in terms of fonts and tabs.

---

## Important Note running VSCode on MacOS in a Parallels VM

There is currently a bug when you run VSCode in a MacOS in Parallels Virtual Machine. The graphics acceleration causes VSCode to render incorrectly. To avoid this you need to run VSCode with graphics acceleration disabled. You'll have to do it from the command line. Open a terminal, then run VSCode with this command:

```bash
"/Applications/Visual Studio Code.app/Contents/MacOS/Electron" --disable-gpu
```

Because there are spaces in the name you'll need to wrap the path in quotes.

To be clear, this bug ONLY affects Visual Studio Code when you create a macOS virtual machine using Parallels and run VSCode in it.

When you run VSCode directly on macOS this is not an issue, and you can just VSCode normally.

---

# Git

If you intend to use VSCode with a git based version control system, such as GitHub, you'll need to install Git.

## Installing Git on Linux

If git is not installed go to https://git-scm.com/download and install it _or_ install over the command line.

```bash
sudo apt -y install git-all
```

## Installing Git on macOS

If you intend to have VSCode interact with git based repositories, such as github, you'll need to install git. You can do so using brew.

```bash
brew install git
```

## Installing Git on Windows

Typically VSCode installs Git with it, but if not you can go to this URL, download and install it.

https://git-scm.com/download/win

## Activating Git

VSCode has a weird quirk that the source control doesn't appear to work. There's a simple work around though. If you don't have one already, create a git repository; github.com is free and works well for it. Next, create a folder on your drive to hold the repository.

In VSCode, bring up the command pallet. This is usually Ctrl+Shift+P on Linux/Windows or Command+P on the Mac.

In the command pallet, enter the command Git:Clone and hit Enter. Then input the url for your repository. For this example I'm using https://github.com/arcanecode/PowerShellCore, but you should use a repository you control . It will prompt you for your user id and password, and a place to store the code.

After you make changes in VSCode, go to the source control tab to see list of changes. Enter a comment, and press Ctrl+Enter or hit the check mark. This will commit the files to the _local_ repository. Now you need to push the files up to your full repository (in this example github.com). Use the ... menu and pick Push to save your changes.

If you are working with an existing project and want to bring the latest version to your computer, you will want to do a "Pull". Go to the Source Control pane, select the ... menu, and pick Pull.

## To cache your passwords:

One annoying thing is continually having to enter your user ID and Password with each push/pull. It is possible to cache your password, but be aware that git doesn't guarentee the security of your password so use at your own risk.

To enter all of these commands, you can use the terminal window built into VSCode, or a standard terminal window.

First, on all operating systems configure your user name and email.

```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

Next you can store your password, either in memory or to disk. When you store in memory at some point the memory cache will expire and you'll have to re-enter your credentials. 

First, you can cache in memory with a default timeout

```bash
$ git config --global credential.helper cache
```

Alternatively, you can specify a time limit. In this example we'll set the cache to one hour (timeout takes the number of seconds as a parameter).

```bash
$ git config --global credential.helper 'cache --timeout=3600'
```

You can also cache your credentials to disk. The method depends on the OS.

## Caching Git Credentials on Linux

In this example replace my repository with the name of your own repository.

```bash
$ git config credential.helper store
$ git push https://github.com/arcanecode/PowerShellCore
```

When prompted enter your user id and password

If successful, you'll see "Everything up-to-date".

Note that the login method for storing your credentials has altered slightly since the original course. Instead of entering your credentials on the command line, VSCode now opens up a web browser and prompts you to login to github, then asks you to authorize the app. Once you do, VSCode will now let you check in / out without having to enter credentials each time.

Be aware this is stored in plain text on your drive, you'll have to decide if this
is worth the trade off. For more info see:

https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitcredentials.html#_avoiding_repetition

(Note I chose to store them using the last method because I have drive encryption
enabled as well as a good login password. And I'm lazy.)

## Caching Git Credentials on Windows

Use the following command to cache credentials permanently:

```bash
git config --global credential.helper wincred
```

Note that this will take the credentials you last used for logging and store them in the cache.

## Caching Git Credentials on macOS

Git stores its information in the osxkeychain helper. This is installed with the XCode tools, which you should install as part of the instructions in _Install PSCore on macOS.md_ file. To test the install, you can use the following command:

```bash
    $ git credential-osxkeychain
```

If the osxkeychain helper isn't installed and you're running OS X version 10.9 or above, your computer will prompt you to download it as a part of the Xcode Command Line Tools, as in the example below:

```bash
    $ git credential-osxkeychain
    > xcode-select: note: no developer tools were found at '/Applications/Xcode.app',
    > requesting install. Choose an option in the dialog to download the command line developer tools.
```

Once you've confirmed it's installed, tell Git to use osxkeychain helper using the global credential.helper config:

```bash
    $ git config --global credential.helper osxkeychain
```

The next time you clone an HTTPS URL that requires a password, you'll be prompted for your username and password, and to grant access to the OSX keychain. After you've done this, the username and password are stored in your keychain and you won't be required to type them in to Git again.

From:
https://help.github.com/en/articles/caching-your-github-password-in-git

---

# Other tweaks

Personally, I can't stand tabs in my code, I convert them to spaces. This next step is of course completely optional, but if you want to replace tabs, in the VSCode menu select File, Preferences. In the upper right corner, click on the curly brace icon to switch the settings into json mode.

Now paste in the following code block:

```json
    // The number of spaces a tab is equal to
    "editor.tabSize": 2,

    // Insert spaces when pressing tab
    "editor.insertSpaces": true,

    // When opening a file, tab size and insert spaces will be detected based on the file type
    "editor.detectIndentation": true
```

If there are other settings in the file above the spot where you are pasting in, don't forget to put a comma at the end of the previous setting. Likewise, if there are settings below where you paste in, make sure to put a comma after the true at the end of the detectIndentation line. Save and re-open VSCode after making the changes.

If you have an existing file that is already full of tabs, select everything, then hit CTRL+SHIFT+P (Command+P on macOS) to bring up the command pallet. Then use the command:

```bash
Convert Indentation to Spaces
```

---

## Author Information

### Author

Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites

Github: [http://arcanerepo.com](http://arcanerepo.com)
Main: [http://arcanecode.me](http://arcanecode.me)

### Copyright Notice

This document is Copyright (c) 2015, 2019, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
