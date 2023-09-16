# Ensure bin is on path
export PATH="${HOME}/bin:/usr/local/bin:${PATH}"

# Set up ZSH
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="" # Use starship instead

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
  fzf
  git
  tmux
  dotenv
  direnv
  docker
  kubectl
)

# Activate oh-my-zsh
source "${ZSH}/oh-my-zsh.sh"

# Source aliases, functions, and exports
source "${HOME}/.zshrc.d/aliases.sh"
source "${HOME}/.zshrc.d/functions.sh"
source "${HOME}/.zshrc.d/exports.sh"

# https://github.com/pyenv/pyenv
eval "$(pyenv init -)"

# https://github.com/Homebrew/brew
eval "$(brew shellenv)"

# https://github.com/nvbn/thefuck
eval $(thefuck --alias pls)

# vim keys
bindkey -v

# https://nixos.org/
source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

eval "$(starship init zsh)"
