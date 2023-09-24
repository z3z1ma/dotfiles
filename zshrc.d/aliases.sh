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
alias mkpy310envrc="echo 'use flake ~/.environments#python310 --impure --command zsh' >> .envrc && direnv allow"
alias mkpy39envrc="echo 'use flake ~/.environments#python39 --impure --command zsh' >> .envrc && direnv allow"
alias mkgoenvrc="echo 'use flake ~/.environments#go --impure --command zsh' >> .envrc && direnv allow"
alias mkrustenvrc="echo 'use flake ~/.environments#rust --impure --command zsh' >> .envrc && direnv allow"
alias mkelixirenvrc="echo 'use flake ~/.environments#elixir --impure --command zsh' >> .envrc && direnv allow"
alias mkclojureenvrc="echo 'use flake ~/.environments#clojure --impure --command zsh' >> .envrc && direnv allow"
alias mkscalaenvrc="echo 'use flake ~/.environments#scala --impure --command zsh' >> .envrc && direnv allow"
alias mkzigenvrc="echo 'use flake ~/.environments#zig --impure --command zsh' >> .envrc && direnv allow"

alias devpy310="nix develop ~/.environments#python310 --impure --command zsh"
alias devpy39="nix develop ~/.environments#python39 --impure --command zsh"
alias devgo="nix develop ~/.environments#go --impure --command zsh"
alias devrust="nix develop ~/.environments#rust --impure --command zsh"
alias develixir="nix develop ~/.environments#elixir --impure --command zsh"
alias devclojure="nix develop ~/.environments#clojure --impure --command zsh"
alias devscala="nix develop ~/.environments#scala --impure --command zsh"
alias devzig="nix develop ~/.environments#zig --impure --command zsh"
