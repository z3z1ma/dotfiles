fish_add_path -g "~/bin" "~/.local/bin" "/usr/local/bin" "/opt/google-cloud-sdk/" 

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx PAGER  "less"
set -gx MANPAGER "nvim +Man!"
set -gx CLICOLOR "1"
set -gx LSCOLORS "ExFxBxDxCxegedabagacad"

set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --glob '!.git'"
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --margin=1 --padding=1"

set -gx GOPATH "$HOME/go"
set -gx GOBIN "$GOPATH/bin"
fish_add_path -g "$GOPATH" "$GOBIN"

set -gx CARGO_HOME "$HOME/.cargo"
fish_add_path -g "$CARGO_HOME/bin"

fish_vi_key_bindings

fish_config theme choose gruvbox

starship init fish | source

