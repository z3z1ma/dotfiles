function fish_shuffle
    # Shuffle an array using the Fisher-Yates algorithm
    set -l items $argv
    set -l n (count $items)
    while test $n -gt 1
        set -l k (math (random) % $n + 1)
        # Swap items[$n] and items[$k]
        set -l temp $items[$n]
        set items[$n] $items[$k]
        set items[$k] $temp
        set n (math $n - 1)
    end
    echo $items
end

function shuf
    # Parse options
    argparse -n shuf e h 'i=' 'n=' 'o=' r z -- $argv
    or return 1

    # Initialize variables
    set -l input_lines
    set -l head_count -1

    # Set head_count if specified
    if set -q _option_n
        set head_count $_option_n
    else if set -q _option_head_count
        set head_count $_option_head_count
    end

    if set -q _option_i
        # Input range is specified
        set -l lo_hi $_option_i
        if string match -r -- '^\d+-\d+$' -- $lo_hi
            set -l lo (string split -m 1 -r '-' -- $lo_hi)[1]
            set -l hi (string split -m 1 -r '-' -- $lo_hi)[2]
            set input_lines (seq $lo $hi)
        else
            printf 'shuf: invalid input range\n' >&2
            return 1
        end
    else if set -q _flag_e
        # Treat remaining arguments as input lines
        set input_lines $_arguments
    else if test (count $_arguments) -gt 0
        # Read from file specified in arguments
        set -l filename $_arguments[1]
        if test "$filename" = -
            # Read from stdin
            while read -l line
                set input_lines $input_lines $line
            end
        else
            # Read from file
            if test -e "$filename"
                set input_lines (cat -- "$filename")
            else
                printf 'shuf: cannot open %s for reading: No such file or directory\n' "$filename" >&2
                return 1
            end
        end
    else
        # Read from stdin
        while read -l line
            set input_lines $input_lines $line
        end
    end

    # Ensure input_lines is not empty
    if test (count $input_lines) -eq 0
        printf 'shuf: no input lines\n' >&2
        return 1
    end

    # Set output file if specified
    if set -q _option_o
        set -l output_file $_option_o
    end

    # Determine zero-terminated flag
    set -l newline_char "\n"
    if set -q _flag_z
        set newline_char ""
    end

    if set -q _flag_r
        # Repeat mode
        set -l n $head_count
        while true
            set -l idx (math (random) % (count $input_lines) + 1)
            set -l line $input_lines[$idx]
            if set -q output_file
                printf '%s%s' "$line" "$newline_char" >>$output_file
            else
                printf '%s%s' "$line" "$newline_char"
            end
            if test $n -gt 0
                set n (math $n - 1)
                if test $n -eq 0
                    break
                end
            end
        end
    else
        # Non-repeat mode
        set -l shuffled_lines (fish_shuffle $input_lines)
        if test $head_count -gt 0
            set shuffled_lines $shuffled_lines[1..$head_count]
        end
        if set -q output_file
            printf '%s%s' $shuffled_lines $newline_char >$output_file
        else
            for line in $shuffled_lines
                printf '%s%s' "$line" "$newline_char"
            end
        end
    end
end
