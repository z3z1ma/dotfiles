show_online() {
  tmux set-option -g @route_to_ping "harness.io"
  tmux set-option -g @online_icon "#[fg=$thm_green]󰖟"
  tmux set-option -g @offline_icon "#[fg=$thm_red]󰪎"

  local index=$1
  local icon="$(get_tmux_option "@catppuccin_online_icon" "󰙨")"
  local color="$(get_tmux_option "@catppuccin_online_color" "$thm_blue")"
  local text="$(get_tmux_option "@catppuccin_online_text" "#{online_status")"}

  local module=$(build_status_module "$index" "$icon" "$color" "$text")
  echo "$module"
}
