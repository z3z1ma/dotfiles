function targz
    set tmpFile (string trim -r -c '/' -- $argv)".tar"
    tar -cvf $tmpFile --exclude=".DS_Store" $argv; or return 1

    set size (math (stat -f"%z" $tmpFile 2>/dev/null; or stat -c"%s" $tmpFile 2>/dev/null))

    set cmd ""
    if test $size -lt 52428800; and type -q zopfli
        set cmd "zopfli"
    else if type -q pigz
        set cmd "pigz"
    else
        set cmd "gzip"
    end

    echo "Compressing .tar ($size kB) using \`$cmd\`…"
    $cmd -v $tmpFile; or return 1
    if test -f $tmpFile
        rm $tmpFile
    end

    set zippedSize (math (stat -f"%z" $tmpFile.gz 2>/dev/null; or stat -c"%s" $tmpFile.gz 2>/dev/null))

    echo "$tmpFile.gz ($zippedSize kB) created successfully."
end
