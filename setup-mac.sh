# A POSIX compliant script to bootstrap a Mac OS X system for development.
# Author: Alex Butler

CONF_DIR=$HOME/.config
NERD_FONT="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures"

R="\033[0;31m"
G="\033[0;32m"
Y="\033[0;33m"
B="\033[0;34m"
NC="\033[0m"

CUR_DIR=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")

echo "${B}Ensuring config directory exists${NC}"
mkdir -p $CONF_DIR
echo "└ ${G}Exists${NC}"

echo "${Y}Checking for Xcode CLI tools${NC}"
if [ ! -f "$(xcode-select -p)/usr/bin/git" ]; then
  echo "└ ${R}Setting up Xcode CLI tools${NC}"
  xcode-select --install
else
  echo "└ ${G}Xcode detected${NC}"
fi

echo "${Y}Checking for Nix${NC}"
if [ ! -d "/etc/nix" ]; then
  echo "└ ${R}Setting up Nix${NC}"
  curl -SsL https://nixos.org/nix/install | sh
else
  echo "└ ${G}Nix detected${NC}"
fi

echo "${B}Linking Nix config${NC}"
# This includes the nix-darwin flake
ln -sfn $CUR_DIR/nix $CONF_DIR/nix
echo "└ ${G}Linked${NC}"

echo "${Y}Updating Nix channels${NC}"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --update
echo "└ ${G}Done${NC}"

LOCAL_HOST_NAME=$(scutil --get LocalHostName)
echo "${Y}Setting up Nix Darwin${NC} for ${LOCAL_HOST_NAME}"
if [ -z "$__NIX_DARWIN_SET_ENVIRONMENT_DONE" ]; then
  nix run nix-darwin -- switch --flake $CONF_DIR/nix/nix-darwin#$LOCAL_HOST_NAME
fi
darwin-rebuild switch --flake $CONF_DIR/nix/nix-darwin#$LOCAL_HOST_NAME
echo "└ ${G}Done${NC}"

echo "${Y}Checking for Devbox${NC}"
if ! command -v devbox &> /dev/null
then
  echo "└ ${R}Setting up Devbox${NC}"
  curl -fsSL https://get.jetpack.io/devbox | bash
  devbox version &> /dev/null
else
  echo "└ ${G}Devbox detected${NC}"
fi

echo "${Y}Running Rustup${NC}"
rustup update
echo "└ ${G}Done${NC}"

echo "${Y}Checking for Nvim version manager${NC}"
if [ ! -f "$HOME/.cargo/bin/bob" ]; then
  echo "└ ${R}Setting up Nvim version manager${NC}"
  # Latest is easiest to install with Cargo
  nix-shell -p darwin.libiconv darwin.apple_sdk.frameworks.SystemConfiguration --run "cargo install bob-nvim"
else
  echo "└ ${G}Nvim version manager detected${NC}"
fi

PATH=$HOME/.cargo/bin:$PATH
echo "${Y}Setting up Nvim (nightly)${NC}"
# Bob is a nightly version manager for Nvim, works great
bob use nightly
echo "└ ${G}Done${NC}"

echo "${B}Linking Nvim config${NC}"
ln -sfn $CUR_DIR/nvim $CONF_DIR/nvim
echo "└ ${G}Linked${NC}"

echo "${Y}Checking for Homebrew${NC}"
# Brew is for any packages that are not available in nix-darwin, or are easier to
# install with Brew. By nature, brew is more imperative than nix, so we try to
# keep it to a minimum.
PATH=/opt/homebrew/bin:$PATH
if [ ! -f "$(command -v brew)" ]; then
  echo "└ ${R}Setting up Homebrew${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "└ ${G}Homebrew detected${NC}"
fi
brew analytics off

echo "${Y}Getting latest Wezterm${NC}"
# Nightly is not available in nix-darwin plus casks work better with Launchpad
brew tap homebrew/cask-versions
brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest \
  || brew install --cask wezterm-nightly
echo "└ ${G}Done${NC}"

echo "${B}Linking Wezterm config${NC}"
ln -sfn $CUR_DIR/wezterm $CONF_DIR/wezterm
echo "└ ${G}Linked${NC}"

echo "${Y}Checking for Tmux plugin manager${NC}"
if [ ! -d "$CONF_DIR/tmux/plugins/tpm" ]; then
  echo "└ ${R}Setting up Tmux plugin manager${NC}"
  git clone https://github.com/tmux-plugins/tpm $CONF_DIR/tmux/plugins/tpm
else
  echo "└ ${G}Tmux plugin manager detected${NC}"
fi

echo "${B}Linking Tmux config${NC}"
ln -sfn $CUR_DIR/tmux $CONF_DIR/tmux
echo "└ ${G}Linked${NC}"

echo "${Y}Updating Tmux plugins${NC}"
$CONF_DIR/tmux/plugins/tpm/bin/install_plugins
echo "└ ${G}Done${NC}"

if [ "${UPDATE_FONTS:-0}" -eq 1 ]; then
  echo "${R}Updating Nerd Fonts${NC}"
  (cd $CUR_DIR/fonts && curl -sfLO $NERD_FONT/Regular/JetBrainsMonoNerdFontMono-Regular.ttf) &
  (cd $CUR_DIR/fonts && curl -sfLO $NERD_FONT/Bold/JetBrainsMonoNerdFontMono-Bold.ttf) &
  (cd $CUR_DIR/fonts && curl -sfLO $NERD_FONT/Italic/JetBrainsMonoNerdFontMono-Italic.ttf) &
  (cd $CUR_DIR/fonts && curl -sfLO $NERD_FONT/BoldItalic/JetBrainsMonoNerdFontMono-BoldItalic.ttf) &
  wait
  echo "└ ${G}Done${NC}"
fi

cp $CUR_DIR/fonts/* $HOME/Library/Fonts/

echo "${R}Install keycastr if needed${NC} -> https://github.com/keycastr/keycastr/releases/download/v0.9.15/KeyCastr.app.zip"

echo "${B}Linking Git config${NC}"
ln -sfn $CUR_DIR/gitconfig $HOME/.gitconfig
ln -sfn $CUR_DIR/gitignore $HOME/.gitignore
ln -sfn $CUR_DIR/gitmessage $HOME/.gitmessage
echo "└ ${G}Linked${NC}"

echo "${B}Linking XPLR config${NC}"
ln -sfn $CUR_DIR/xplr $CONF_DIR/xplr
echo "└ ${G}Linked${NC}"

echo "${B}Linking Cron config${NC}"
ln -sfn $CUR_DIR/cron $CONF_DIR/cron
echo "└ ${G}Linked${NC}"

echo "${Y}Syncing crontab${NC}"
(cat $CONF_DIR/cron/crontab.sh | tee /dev/stderr) | crontab -
echo "└ ${G}Done${NC}"

echo "${B}Linking Direnv config${NC}"
ln -sfn $CUR_DIR/direnv $CONF_DIR/direnv
echo "└ ${G}Linked${NC}"

echo "${B}Linking Fish config${NC}"
ln -sfn $CUR_DIR/fish $CONF_DIR/fish
echo "└ ${G}Linked${NC}"

echo "${Y}Checking for Starship${NC}"
PATH="${PATH}:/usr/local/bin/"
if ! command -v starship &> /dev/null
then
  echo "└ ${R}Setting up Starship${NC}"
  curl -sS https://starship.rs/install.sh | sh
else
  echo "└ ${G}Starship detected${NC}"
fi

echo "${B}Linking Starship config${NC}"
ln -sfn $CUR_DIR/starship/starship.toml $CONF_DIR/starship.toml
echo "└ ${G}Linked${NC}"

echo "${B}Linking Btop config${NC}"
ln -sfn $CUR_DIR/btop $CONF_DIR/btop
echo "└ ${G}Linked${NC}"

echo "${B}Setting up macOS defaults${NC}"
# These are defaults which are not set by nix-darwin
# We set them here as a more flexible complement to nix-darwin
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
defaults write NSGlobalDomain AppleAccentColor -int 1
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
echo " └ ${G}Done${NC}"


echo "${G}Done${NC} 🎉"
