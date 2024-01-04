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
ln -sfn $$CUR_DIR/nix $CONF_DIR/nix
echo "└ ${G}Linked${NC}"

echo "${Y}Updating Nix channels${NC}"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --update
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

eval "$(devbox global shellenv)"

echo "${B}Syncing Devbox config${NC}"
devbox -q global pull $CUR_DIR/devbox/devbox.json $DEVBOX_FLAGS
devbox global install
echo "└ ${G}Done${NC}"

echo "${Y}Running Rustup${NC}"
rustup update
echo "└ ${G}Done${NC}"

echo "${Y}Checking for Nvim version manager${NC}"
if [ ! -f "$HOME/.cargo/bin/bob" ]; then
  echo "└ ${R}Setting up Nvim version manager${NC}"
  nix-shell -p darwin.libiconv darwin.apple_sdk.frameworks.SystemConfiguration --run "cargo install bob-nvim"
else
  echo "└ ${G}Nvim version manager detected${NC}"
fi

PATH=$HOME/.cargo/bin:$PATH
echo "${Y}Setting up Nvim (nightly)${NC}"
bob use nightly
echo "└ ${G}Done${NC}"

echo "${B}Linking Nvim config${NC}"
ln -sfn $CUR_DIR/nvim $CONF_DIR/nvim
echo "└ ${G}Linked${NC}"

echo "${Y}Checking for Homebrew${NC}"
PATH=/opt/homebrew/bin:$PATH
if [ ! -f "$(command -v brew)" ]; then
  echo "└ ${R}Setting up Homebrew${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "└ ${G}Homebrew detected${NC}"
fi

echo "${Y}Getting latest Wezterm${NC}"
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

echo "${G}Done${NC} 🎉"
