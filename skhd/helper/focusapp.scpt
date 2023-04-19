on run argv
    set appName to item 1 of argv -- appName from shell script

    -- get current activated app
    tell application "System Events"
        set currentApp to name of application processes whose frontmost is true
        if (currentApp as text) contains "Electron" then
            set currentApp to "Code"
        end if
    end tell

    -- get the last opened app from file 
    set lastApp to do shell script "less /Users/niklas/dev/config/dotfiles/skhd/helper/lastapp.txt"
    --display dialog "current: " & currentApp & " commandApp: " & appName & " lastApp: " & lastApp 
    
    if  (currentApp as text) contains appName then
        --display dialog appName
        --tell application "Sytem Events"
        --    set visible of every window of process (appName as text) to false
        --end tell
        tell application lastApp to activate
        do shell script "echo " & currentApp & " > /Users/niklas/dev/config/dotfiles/skhd/helper/lastapp.txt"
    else
        tell application appName to activate
        do shell script "echo " & currentApp & " > /Users/niklas/dev/config/dotfiles/skhd/helper/lastapp.txt" 
    end if
end run