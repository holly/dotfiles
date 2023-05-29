###################################
# utility functions
###################################

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

