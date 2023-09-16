.PHONY: all tmux nvim git zsh starship font alacritty

all: tmux nvim git zsh starship alacritty

tmux:
	ln -sfn $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

nvim:
	mkdir -p ~/.config/
	ln -sfn $(CURDIR)/nvim $(HOME)/.config/nvim

git:
	ln -sfn $(CURDIR)/gitconfig $(HOME)/.gitconfig
	ln -sfn $(CURDIR)/gitmessage $(HOME)/.gitmessage

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

