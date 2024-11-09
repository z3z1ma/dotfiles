function fs
    if test -n "$argv"
        du -sh -- $argv
    else
        du -sh .[^.]* ./*
    end
end
