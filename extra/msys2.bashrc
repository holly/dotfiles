uname -s | grep -q MINGW64
if [ $? = 0 ]; then
        alias desktop="cd /c/Users/$USER/Desktop"
        alias tmux="tmux -S /tmp/tmux-$(id -u)/default"
fi
