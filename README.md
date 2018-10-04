# Personal setup

Things I have configured on my Mac that make it easier to do things.

Show services directly in context menu instead of Services submenu:

    defaults write -g NSServicesMinimumItemCountForContextSubmenu -int 999
    
Put screenshots in a directory, not the Desktop

    defaults write com.apple.screencapture location ~/Pictures/Screenshots
    
Show xcode build times

    defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES
    
Show why build commands were run (helps debug long build times)

    defaults write com.apple.dt.Xcode ExplainWhyBuildCommandsAreRun -bool YES
    
## Services
50% Alpha - makes an image 50% translucent, useful for pasting images on top of each other to compare them

Open commit on github - select a commit hash, click this then it will open that commit on github (only works on one repo I use all the time)

Switch branch - select a branch name, it checks it out in the last active terminal window
