# Ensure bin is on path
export PATH="${HOME}/bin:/usr/local/bin:${PATH}"

# Set up ZSH
export ZSH="${HOME}/.oh-my-zsh"

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

# Activate oh-my-zsh and theme
export ZSH_THEME="powerlevel10k/powerlevel10k"
source "${ZSH}/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source aliases, functions, and exports
source "${HOME}/.zshrc.d/aliases.sh"
source "${HOME}/.zshrc.d/functions.sh"
source "${HOME}/.zshrc.d/exports.sh"

# https://github.com/pyenv/pyenv
eval "$(pyenv init -)"

# https://github.com/Homebrew/brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# https://github.com/nvbn/thefuck
eval $(thefuck --alias pls)

# Skip forward/back a word with opt-arrow
bindkey '[C' forward-word
bindkey '[D' backward-word

# https://nixos.org/
source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

