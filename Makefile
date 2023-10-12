.PHONY: all tmux nvim git zsh starship font alacritty nix direnv deps environments update-flakes

all: tmux nvim git zsh starship alacritty nix direnv environments

tmux:
	ln -sfn $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

nvim:
	mkdir -p ~/.config/
	ln -sfn $(CURDIR)/nvim $(HOME)/.config/nvim

git:
	ln -sfn $(CURDIR)/gitconfig $(HOME)/.gitconfig
	ln -sfn $(CURDIR)/gitmessage $(HOME)/.gitmessage
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore

zsh:
	ln -sfn $(CURDIR)/zshrc $(HOME)/.zshrc
	ln -sfn $(CURDIR)/zshrc.d $(HOME)/.zshrc.d
	touch ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions/.check || git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	touch ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.check || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

alacritty:
	mkdir -p ~/.config/alacritty
	ln -sfn $(CURDIR)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

font:
	cd ~/Library/Fonts && curl -fLO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf
	cd ~/Library/Fonts && curl -fLO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Bold/JetBrainsMonoNerdFontMono-Bold.ttf
	cd ~/Library/Fonts && curl -fLO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Italic/JetBrainsMonoNerdFontMono-Italic.ttf
	cd ~/Library/Fonts && curl -fLO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/BoldItalic/JetBrainsMonoNerdFontMono-BoldItalic.ttf

starship:
	starship --version || (curl -sS https://starship.rs/install.sh | sh)
	ln -sfn $(CURDIR)/starship.toml $(HOME)/.config/starship.toml

nix:
	mkdir -p ~/.config/nix
	nix-env --version || (curl -sSL https://nixos.org/nix/install | sh)
	ln -sfn $(CURDIR)/nix.conf $(HOME)/.config/nix/nix.conf

direnv:
	direnv --version || (curl -sfL https://direnv.net/install.sh | sh)
	mkdir -p ~/.config/direnv
	ln -sfn $(CURDIR)/direnv.toml $(HOME)/.config/direnv/direnv.toml

deps: /bin/bash
	xcode-select --install || true
	brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install luajit tmux alacritty fzf ripgrep fd jq yq adr-tools changie htop lazygit wget || true
	rustup --version || (curl https://sh.rustup.rs -sSf | sh)
	bob --version || cargo install bob-nvim
	bob use nightly

environments:
	ln -sf $(CURDIR)/environments $(HOME)/.environments

update-flakes:
	for i in ./environments/*/; do nix flake update "$$i"; done
	nix flake update ./environments

