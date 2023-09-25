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
alias vim="nvim"

# Homebrew alias for daily management
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"

# Environment bootstrapping
alias mkpy310envrc="echo 'use flake $(realpath ~/.environments)#python310 --impure' >> .envrc && direnv allow"
alias mkpy39envrc="echo 'use flake $(realpath ~/.environments)#python39 --impure' >> .envrc && direnv allow"
alias mkgoenvrc="echo 'use flake $(realpath ~/.environments)#go --impure' >> .envrc && direnv allow"
alias mkrustenvrc="echo 'use flake $(realpath ~/.environments)#rust --impure' >> .envrc && direnv allow"
alias mkelixirenvrc="echo 'use flake $(realpath ~/.environments)#elixir --impure' >> .envrc && direnv allow"
alias mkclojureenvrc="echo 'use flake $(realpath ~/.environments)#clojure --impure' >> .envrc && direnv allow"
alias mkscalaenvrc="echo 'use flake $(realpath ~/.environments)#scala --impure' >> .envrc && direnv allow"
alias mkzigenvrc="echo 'use flake $(realpath ~/.environments)#zig --impure' >> .envrc && direnv allow"

alias devpy310="nix develop $(realpath ~/.environments)#python310 --impure --command zsh"
alias devpy39="nix develop $(realpath ~/.environments)#python39 --impure --command zsh"
alias devgo="nix develop $(realpath ~/.environments)#go --impure --command zsh"
alias devrust="nix develop $(realpath ~/.environments)#rust --impure --command zsh"
alias develixir="nix develop $(realpath ~/.environments)#elixir --impure --command zsh"
alias devclojure="nix develop $(realpath ~/.environments)#clojure --impure --command zsh"
alias devscala="nix develop $(realpath ~/.environments)#scala --impure --command zsh"
alias devzig="nix develop $(realpath ~/.environments)#zig --impure --command zsh"
