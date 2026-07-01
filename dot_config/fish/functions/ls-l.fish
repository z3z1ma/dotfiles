function ls-l --wraps='eza --color=always --icons=always --long --no-permissions --no-filesize --no-user --no-time --tree --level=1 .' --description 'alias ls-l eza --color=always --icons=always --long --no-permissions --no-filesize --no-user --no-time --tree --level=1 .'
  eza --color=always --icons=always --long --no-permissions --no-filesize --no-user --no-time --tree --level=1 . $argv
        
end
