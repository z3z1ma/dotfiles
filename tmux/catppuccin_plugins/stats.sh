show_stats() {
  local module=$(build_status_module \
    "$1"\
    "#{battery_icon_charge}"\
    "$thm_yellow"\
    "#[fg=$thm_yellow]BAT: #{battery_percentage} #{battery_remain} | #[fg=$thm_magenta]CPU: #{cpu_icon} #{cpu_percentage} |#[fg=$thm_cyan]#(head -2 /tmp/gcalcli.txt | cut -d ' ' -f 4- | tail -1 | tr -s '[:space:]')"\
  )
  echo "$module"
}
