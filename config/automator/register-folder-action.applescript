on run argv
    set folderPath to item 1 of argv
    set workflowPath to item 2 of argv
    set folderAlias to POSIX file folderPath as alias
    set folderHFSPath to folderAlias as text
    set workflowHFSPath to (POSIX file workflowPath as alias) as text

    tell application "System Events"
        set registeredAction to missing value
        repeat with currentAction in folder actions
            set currentPath to path of currentAction
            if currentPath is folderPath or currentPath is folderHFSPath then
                set registeredAction to currentAction
                exit repeat
            end if
        end repeat

        set alreadyAttached to false
        if registeredAction is not missing value then
            repeat with currentScript in scripts of registeredAction
                if POSIX path of currentScript is workflowPath then
                    set enabled of currentScript to true
                    set alreadyAttached to true
                    exit repeat
                end if
            end repeat
        end if

        if not alreadyAttached then
            set registeredAction to attach action to folder folderPath using workflowHFSPath
        end if
        -- セットアップ前からフォルダにある画像は処理しない。
        if not (enabled of registeredAction) then
            enable registeredAction process new changes no
        end if
        set folder actions enabled to true
    end tell
end run
