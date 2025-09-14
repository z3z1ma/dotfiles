
abbr lsd "ls -l --color | grep --color=never '^d'"
abbr la "ls -la --color"
abbr l "ls -l --color"
abbr c clear
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr ..... "cd ../../../.."
abbr g git

abbr vim nvim

abbr pipup "pip install --upgrade pip"
abbr cvenv "python -m venv .venv"
abbr avenv "source .venv/bin/activate.fish"
abbr venv "python -m venv .venv; and source .venv/bin/activate.fish"

abbr updwez "brew tap homebrew/cask-versions; and brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest"
abbr updvim "bob use nightly"
abbr updfish "fisher update"
abbr updnix "nix-channel --update"
abbr updnixdarwin "darwin-rebuild switch --flake ~/.config/nix_system#$(scutil --get LocalHostName)"

abbr cd z

abbr harnessb SDKROOT=(xcrun --sdk macosx --show-sdk-path) DEVELOPER_DIR=(xcode-select -p) bazel build --repo_env=CC=/usr/bin/clang --repo_env=CXX=/usr/bin/clang++ --action_env=DEVELOPER_DIR --action_env=SDKROOT --action_env=PATH=/usr/bin:/bin:/usr/sbin:/sbin
