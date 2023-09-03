.PHONY: tmux nvim

tmux : tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf

nvim: nvim/init.lua
	mkdir -p ~/.config/
	ln -s $(PWD)/nvim ~/.config/nvim

git: gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig

