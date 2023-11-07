# Set XDG config home
export XDG_CONFIG_HOME="${HOME}/.config"

# Ensure bin is on path
export PATH="${HOME}/bin:/usr/local/bin:${PATH}"

# Set up ZSH
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="" # Use starship instead

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
  starship
  fd
  fzf
  ripgrep
  git
  tmux
  direnv
  docker
  kubectl
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Activate oh-my-zsh
source "${ZSH}/oh-my-zsh.sh"

# Source aliases, functions, and exports
source "${HOME}/.zshrc.d/aliases.sh"
source "${HOME}/.zshrc.d/functions.sh"
source "${HOME}/.zshrc.d/exports.sh"

# Vim keys
bindkey -v

# Edit command line in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# Adds nix packages installed via nix-env -i to path
# https://nixos.org/
source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

