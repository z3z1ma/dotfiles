.PHONY: all tmux nvim git zsh

all: tmux nvim git zsh

tmux:
	ln -sfn $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

nvim:
	mkdir -p ~/.config/
	ln -sfn $(CURDIR)/nvim $(HOME)/.config/nvim

git:
	ln -sfn $(CURDIR)/gitconfig $(HOME)/.gitconfig

zsh:
	ln -sfn $(CURDIR)/zshrc $(HOME)/.zshrc
	ln -sfn $(CURDIR)/zshrc.d $(HOME)/.zshrc.d

