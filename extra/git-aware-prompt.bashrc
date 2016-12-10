GITAWAREPROMPT_ROOT=$HOME/git-aware-prompt
if [ -d $GITAWAREPROMPT_ROOT ]; then
    export GITAWAREPROMPT_ROOT
    . $GITAWAREPROMPT_ROOT/main.sh
    export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
fi
