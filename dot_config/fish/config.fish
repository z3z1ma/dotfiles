#! /usr/bin/env fish
fish_vi_key_bindings
for export in (set -Ux)
    set -eg (string split " " $export)[1]
end
starship init fish | source
zoxide init fish | source
fish_add_path "$HOME/.local/bin"
