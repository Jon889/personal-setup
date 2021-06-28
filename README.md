# Personal setup

Things I have configured on my Mac that make it easier to do things:

Set the display to maximum resolution

Switch to bash.

Set trackpad gestures to 4 fingers, and enable 3 finger drag (System Preferences > Accessiblity > Pointer Control > Trackpad Options)

Disable all the useless services (like convert to Chinese, open man page)

Show services directly in context menu instead of Services submenu:

    defaults write -g NSServicesMinimumItemCountForContextSubmenu -int 999
    
Disable the floating screenshot thumbnail (Cmd+Shift+5 > Options), put `~/Pictures/Screenshots` as a stack+fan in the dock, sorted by Date Added.
    
Put screenshots in a directory, not the Desktop (or in Cmd+Shift+5 > Options)

    defaults write com.apple.screencapture location ~/Pictures/Screenshots
    
Create ~/Stack folder and put it as a stack+fan in the dock sorted by Date Added (used for moving files between apps, eg for uploading, or just keeping track of files that relevant roughly now)

Add the following folders to the Finder sidebar: ~, DerivedData, Screenshots, Stack.
    
Show xcode build times

    defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES
    
Set TextEdit to create plain text files
    
## Services
50% Alpha - makes an image 50% translucent, useful for pasting images on top of each other to compare them

Open commit on github - select a commit hash, click this then it will open that commit on github (only works on one repo I use all the time)

Switch branch - select a branch name, it checks it out in the last active terminal window
