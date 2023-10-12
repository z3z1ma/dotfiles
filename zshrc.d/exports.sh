#!/usr/bin/env bash

# Make vim the default editor
export EDITOR="nvim"

export VISUAL="nvim"
export PAGER="less"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add gcloud to path
export PATH="${PATH}:/opt/google-cloud-sdk/bin"

# Set default options for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --margin=1 --padding=1"

# Add .local bin to path used by pipx
export PATH="${PATH}:${HOME}/.local/bin"

# Add go bin to path
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOPATH}"
export PATH="${GOBIN}:${PATH}"

# Add rust bin to path
export PATH="${PATH}:${HOME}/.cargo/bin"

# Add nvim bins to path
export PATH="${HOME}/.local/share/bob/nvim-bin:${PATH}"

# Add nix to path
export PATH="/nix/var/nix/profiles/default/bin/:${PATH}"
