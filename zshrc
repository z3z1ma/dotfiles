export XDG_CONFIG_HOME="${HOME}/.config"
export PATH="/usr/local/bin/:${PATH}"

if command -v devbox &> /dev/null
then
  eval "$(devbox global shellenv)"
fi

fish
