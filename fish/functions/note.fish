function note
    mkdir -p $HOME/scratch
    mkdir -p $HOME/scratch/notes
    set d (date +%Y-%m-%d)
    if not test -f $HOME/scratch/notes/$d.txt
        touch $HOME/scratch/notes/$d.txt
    end
    cd $HOME/scratch
    nvim notes/$d.txt
end
