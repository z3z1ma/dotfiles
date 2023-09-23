#!/usr/bin/env bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# List all files colorized in long format
alias l="ls -l --color"

# List all files colorized in long format, excluding . and ..
alias ll="ls -lA --color"

# List only directories
alias lsd="ls -l --color | grep --color=never '^d'"

# Use neovim instead of vim
alias vim='nvim'

# Homebrew alias for daily management
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# Environment bootstrapping
alias mkpy10env="echo 'use flake ~/code_projects/dotfiles/environments/python#python310 --impure' > .envrc && direnv allow"

