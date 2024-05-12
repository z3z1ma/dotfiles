function scheme --wraps='racket -l sicp --repl' --description 'alias scheme=racket -l sicp --repl'
  racket -l sicp --repl $argv
        
end
