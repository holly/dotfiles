###################################
# utility functions
###################################

function error

    set_color --bold red; echo "[ERROR]: " $argv
    return 1
end

function is_executable_sudo

    timeout --signal=2 1 sudo -l >/dev/null 2>&1
    return $status
end

function is_root
    if test (id -u) -eq 0
        return 0
    end
    return 1
end

function is_stdin

    if test -t 0
        return 1
    end
    return 0
end

function has_bom

    if test (count $argv) -eq 0
        error "argv is required"
        return 1
    end
    set -l f $argv[1]
    if not test -f $f
        error "argv[1]($f) is not file"
        return $status
    end
    string match -ar '\(with BOM\)' (file $f) >/dev/null
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

