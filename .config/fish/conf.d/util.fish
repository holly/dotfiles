###################################
# utility functions
###################################
function abs2real

    set -l f $argv[1]
    fish -c "echo (cd (dirname $f) && pwd)/(basename $f)"
end

function encode

    if is_stdin
        iconv -c -f $argv[1] -t $argv[2]
    else
        set -l f $argv[3]
        if test -f $f
            set -l tmp (string join "." $f (date +%s))
            cp -p $f $tmp
            cat $tmp | iconv -c  -f $argv[1] -t $argv[2] -o $f
            rm $tmp
        else
            error "argv $f is not file"
        end
    end
end

function error

    set_color --bold red; echo "[ERROR]: " $argv
    return 1
end

function cando

    timeout --signal=2 1 sudo -l >/dev/null 2>&1
    return $status
end

function isroot
    if test (id -u) -eq 0
        return 0
    end
    return 1
end

function isstdin

    if test -t 0
        return 1
    end
    return 0
end

function hasbom

    if test (count $argv) -eq 0
        error "argv is required"
        return 1
    end
    set -l f $argv[1]
    if not test -f $f
        error "argv $f is not file"
        return $status
    end
    string match -ar '\(with BOM\)' (file $f) >/dev/null
    return $status
end

function delbom

    if is_stdin
        # -0777 is slurp mode
        # -CSDL is https://pointoht.ti-da.net/e8367529.html
        perl -0777 -CSDL -nlpe "s/^\x{feff}//"
    else
        if test -f $argv[1]
            perl -i -CSDL -nlpe 's/^\x{feff}//' $argv[1]
        else
            error "argv $argv[1] is not file"
        end
    end
end

function guess

    if test (count $argv) -eq 0
        error "argv is required"
        return 1
    end
    set -l f $argv[1]
    if not test -f $f
        error "argv $f is not file"
        return $status
    end
    string replace -ar  '.*; charset=(.*)$' '$1' (file -i $f) | string upper
    return $status
end

function fup

    fisher list
    read -p "set_color green; echo '[Y/n]: '" -l ans
    if test $ans != "Y"
       and test $ans != "y"
        echo "quit."
        return
    end
    fisher update
    ln -sfv $HOME/.dotfiles/.config/fish/functions/fish_greeting.fish $HOME/.config/fish/functions/fish_greeting.fish
end

function lf

    if test (count $argv) -eq 0
        error "argv is required"
        return 1
    end
    set -l f $argv[1]
    if not test -f $f
        error "argv $f is not file"
        return $status
    end
    set -l res (file $f)
    if string match -ar 'with CRLF line terminators' $res >/dev/null
        echo "CRLF"
    else if string match -ar 'with CR line terminators' $res >/dev/null
        echo "CR"
    else if string match -ar 'text' $res >/dev/null
        echo "LF"
    else
        echo "BINARY"
    end
end


function human_readable_size

    set -l number $argv[1]

    set -l kb 1024
    set -l mb (math "$kb * 1024")
    set -l gb (math "$mb * 1024")
    set -l tb (math "$gb * 1024")
    set -l pb (math "$tb * 1024")
    set -l scale 2

    test $number -lt $kb && echo $number"B" && return 0
    test $number -lt $mb && echo (math -s$scale $number/$kb)"KB" && return 0
    test $number -lt $gb && echo (math -s$scale $number/$mb)"MB" && return 0
    test $number -lt $tb && echo (math -s$scale $number/$gb)"GB" && return 0
    test $number -lt $pb && echo (math -s$scale $number/$tb)"TB" && return 0
    echo (math -s$scale $number/$pb)"PB"
end

####################
# shortcut
####################
function w2s

    if is_stdin
        encode UTF-8 SJIS
    else
        encode UTF-8 SJIS $argv[1]
    end
end

function s2w

    if is_stdin
        encode SJIS UTF-8
    else
        encode SJIS UTF-8 $argv[1]
    end
end


