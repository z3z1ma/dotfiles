function todo
    mkdir -p $HOME/scratch
    mkdir -p $HOME/scratch/todo
    set d (date +%Y-%m-%d)
    if not test -f $HOME/scratch/todo/$d.txt
        touch $HOME/scratch/todo/$d.txt
    end
    cd $HOME/scratch
    nvim todo/$d.txt || :
    cd -
end
