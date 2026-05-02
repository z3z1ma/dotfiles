#! /usr/bin/env fish
for export in (set -Ux)
    set -eg (string split " " $export)[1]
end

if status is-interactive
    fish_vi_key_bindings

    if test -f /etc/fish/generated/starship.fish
        source /etc/fish/generated/starship.fish
    else
        starship init fish | source
    end

    if test -f /etc/fish/generated/zoxide.fish
        source /etc/fish/generated/zoxide.fish
    else
        zoxide init fish | source
    end
end

fish_add_path "$HOME/.local/bin"
