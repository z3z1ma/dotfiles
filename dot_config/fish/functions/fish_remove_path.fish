function fish_remove_path --description "Shows user added PATH entries and removes the selected one"
    echo "User added PATH entries"
    set -l PATH_ENTRIES
    echo $fish_user_paths | tr " " "\n" | nl
    echo "Select the number of entry to be removed, if more than one separate the values by spaces"
    read -d " " -a PATH_ENTRIES
    for entry in $PATH_ENTRIES
        if string match -qr '^[0-9]+$' $entry
            # "$entry it is a number!"
            set -l FISH_ENTRIES (count $fish_user_paths)
            if test $entry -gt $FISH_ENTRIES
                echo "Index out of bounds, must be between 1 and $FISH_ENTRIES" 1>&2
            else
                echo "Erasing $fish_user_paths[$entry]"
                echo "Press y to continue"
                set -l confirmation
                read confirmation
                if test "$confirmation" = y
                    set --erase --universal fish_user_paths[$entry]
                else
                    echo "skipping..."
                end
            end
        else
            echo "Provided argument $entry is not a number" 1>&2
        end
    end
end
