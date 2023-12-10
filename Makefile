.PHONY: all tmux nvim git zsh starship font alacritty nix direnv deps environments update-flakes update-fonts

CONF_DIR = $(HOME)/.config
NERD_FONT = https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures
R = \033[0;31m
G = \033[0;32m
Y = \033[1;32m
B = \033[0;34m
NC = \033[0m

all: tmux nvim git zsh alacritty starship nix direnv font environments tmux-plugins xplr

conf_dir:
	@echo "$(B) Ensuring config directory exists $(NC)"
	mkdir -p $(CONF_DIR)

tmux: conf_dir
	@echo "$(B) Linking tmux config $(NC)"
	ln -sfn $(CURDIR)/tmux $(CONF_DIR)/tmux

nvim: conf_dir
	@echo "$(B) Linking nvim config $(NC)"
	ln -sfn $(CURDIR)/nvim $(CONF_DIR)/nvim

git:
	@echo "$(B) Linking git config $(NC)"
	ln -sfn $(CURDIR)/gitconfig $(HOME)/.gitconfig
	ln -sfn $(CURDIR)/gitmessage $(HOME)/.gitmessage
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore

zsh:
	@echo "$(B) Linking zsh config $(NC)"
	ln -sfn $(CURDIR)/zshrc $(HOME)/.zshrc
	ln -sfn $(CURDIR)/zshrc.d $(HOME)/.zshrc.d
	@echo "$(B) Ensuring zsh plugins are installed $(NC)"
	touch $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions/.check || git clone https://github.com/zsh-users/zsh-autosuggestions $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	touch $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.check || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

alacritty: conf_dir
	@echo "$(B) Linking alacritty config $(NC)"
	ln -sfn $(CURDIR)/alacritty $(CONF_DIR)/alacritty

starship: conf_dir
	@echo "$(B) Linking starship config $(NC)"
	ln -sfn $(CURDIR)/starship.toml $(CONF_DIR)/starship.toml

nix: conf_dir
	@echo "$(B) Linking nix config $(NC)"
	ln -sfn $(CURDIR)/nix $(CONF_DIR)/nix

direnv: conf_dir
	@echo "$(B) Linking direnv config $(NC)"
	ln -sfn $(CURDIR)/direnv $(CONF_DIR)/direnv

xplr: conf_dir
	@echo "$(B) Linking xplr config $(NC)"
	ln -sfn $(CURDIR)/xplr $(CONF_DIR)/xplr

font:
	@echo "$(B) Installing fonts $(NC)"
	cp fonts/* $(HOME)/Library/Fonts/

environments:
	@echo "$(B) Linking environments $(NC)"
	ln -sfn $(CURDIR)/environments $(HOME)/.environments

tmux-plugins: tmux
	@echo "$(B) Ensuring tmux plugins are installed $(NC)"
	touch $(CONF_DIR)/tmux/plugins/tpm/.check || git clone https://github.com/tmux-plugins/tpm $(CONF_DIR)/tmux/plugins/tpm
	$(CONF_DIR)/tmux/plugins/tpm/bin/install_plugins

deps: /bin/bash font
	@echo "$(B) Starting global dependency resolution $(NC)"
	@echo "$(Y) Ensuring xcode cli tools are installed $(NC)"
	xcode-select --install || true
	@echo "$(Y) Adding nix $(NC)"
	nix-env --version || (curl -sSL https://nixos.org/nix/install | sh)
	@echo "$(Y) Adding unstable channel $(NC)"
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	@echo "$(Y) Adding alacritty, tmux, starship $(NC)"
	nix-env -iA unstable.{tmux,alacritty,starship}
	@echo "$(Y) Adding langs: rust, lua, go, node, python $(NC)"
	nix-env -iA unstable.{luajit,luajitPackages.luv,luajitPackages.sqlite,rustup,go,nodejs_20,python310}
	@echo "$(Y) Adding cli tools $(NC)"
	nix-env -iA unstable.{fzf,ripgrep,fd,jq,yq,changie,adrgen,htop,lazygit,wget,direnv,opentofu,tree,gh,gnused,watchman,xplr}
	@echo "$(Y) Adding build tools $(NC)"
	nix-env -iA unstable.{cmake,gcc,openblas}
	@echo "$(Y) Adding database tools $(NC)"
	nix-env -iA unstable.{duckdb,sqlite}
	@echo "$(Y) Adding cloud tools $(NC)"
	nix-env -iA unstable.{kubectl,google-cloud-sdk}
	@echo "$(Y) Adding neovim & sshx $(NC)"
	sshx --version || (curl -sSf https://sshx.io/get | sh)
	bob --version || cargo install bob-nvim
	bob use nightly
	@echo "$(G) DONE $(NC)"

# https://github.com/keycastr/keycastr/releases/download/v0.9.15/KeyCastr.app.zip

update-flakes:
	@echo "$(B) Updating flakes $(NC)"
	for i in ./environments/*/; do nix flake update "$$i"; done
	nix flake update ./environments

update-fonts:
	@echo "$(B) Updating fonts $(NC)"
	cd fonts && curl -fLO $(NERD_FONT)/Regular/JetBrainsMonoNerdFontMono-Regular.ttf
	cd fonts && curl -fLO $(NERD_FONT)/Bold/JetBrainsMonoNerdFontMono-Bold.ttf
	cd fonts && curl -fLO $(NERD_FONT)/Italic/JetBrainsMonoNerdFontMono-Italic.ttf
	cd fonts && curl -fLO $(NERD_FONT)/BoldItalic/JetBrainsMonoNerdFontMono-BoldItalic.ttf

