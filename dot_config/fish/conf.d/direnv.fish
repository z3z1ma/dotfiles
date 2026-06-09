status is-interactive
or exit 0

# Shadow the vendor direnv hook so opening a shell does not spawn direnv unless
# this directory is actually governed by a direnv file.
set -g __direnv_lazy_last_file ''

function __direnv_lazy_find_file --argument-names dir
    while test -n "$dir"
        if test -f "$dir/.envrc"
            printf '%s\n' "$dir/.envrc"
            return 0
        end
        if test -f "$dir/.env"
            printf '%s\n' "$dir/.env"
            return 0
        end

        set -l parent (path dirname -- "$dir")
        if test "$parent" = "$dir"
            return 1
        end

        set dir "$parent"
    end

    return 1
end

function __direnv_lazy_export --argument-names mode
    set -l direnv_file (__direnv_lazy_find_file "$PWD")
    if test $status -ne 0
        set direnv_file ''
    end

    if test "$mode" != --force
        if test "$direnv_file" = "$__direnv_lazy_last_file"
            if test -n "$direnv_file"; or not set -q DIRENV_DIR
                return 0
            end
        end
    end

    command -sq direnv
    or return 127

    direnv export fish | source
    set -g __direnv_lazy_last_file "$direnv_file"
end

function __direnv_lazy_on_prompt --on-event fish_prompt
    __direnv_lazy_export
end

function __direnv_lazy_after_command --on-event fish_postexec --argument-names command
    string match --quiet --regex '^\s*direnv(\s|$)' -- "$command"
    and set -g __direnv_lazy_last_file ''
end

function direnv-refresh --description 'Force direnv to re-evaluate for the current directory'
    __direnv_lazy_export --force
end
