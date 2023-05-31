if status is-interactive
    # Commands to run in interactive sessions can go here
end

###################################
# environ variables
###################################
fish_add_path "$HOME/.local/bin"

set -gx LANG ja_JP.UTF-8
set -gx TZ Asia/Tokyo
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

set -gx FZF_DEFAULT_OPTS "--height 50% --reverse --border"
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --follow --glob \"!.git/*\"'
set -gx FZF_CTRL_T_OPTS "--preview \"batcat --color=always --style=header,grid --line-range :100 {}\""


###################################
# abbr
###################################
abbr -a vi nvim
abbr -a view "nvim -R"
abbr -a vimrc "nvim $HOME/.config/nvim/init.vim"

if command -sq terraform
    abbr -a tf terraform
    abbr -a tfa "terraform apply"
    abbr -a tfp "terraform plan"
    abbr -a tfd "terraform destroy"
end
if command -sq aws
    abbr -a s3  "aws s3"
    abbr -a ec2 "aws ec2"
end

# for pyenv
if test -d "$HOME/.pyenv"
    set -x PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    $PYENV_ROOT/bin/pyenv init - | source
end

# for tmux
if command -sq tmux
    abbr -a t "tmux -u"
    abbr -a ta "tmux attach"
end

###################################
# environ variables
###################################
# for common
abbr -a x "chmod +x"
abbr -a strace "strace -s 1024 -tt -f -T -v"
abbr -a od "od -tcx1"
abbr -a tcf "tar --exclude-backups --exclude=\"*.old\" --exclude=\"*.swp\" --exclude=\"*.tmp\" --exclude=\"*.org\" --exclude=\"*.pid\" --exclude=\"lock\" --exclude=\"*~\" --ignore-failed-read --one-file-system -pcvzf"
abbr -a txf "tar --ignore-failed-read -pxvzf"
abbr -a tat "tar --ignore-failed-read -ptvzf"
abbr -a epoch "date +%s"
abbr -a dt "date --iso-8601=seconds"
abbr -a du "duf"
abbr -a myip "curl https://ifconfig.me && echo"

# for git 
abbr -a g  "git"
abbr -a ga "git add . && git add -u && git status"
abbr -a gb "git fetch && git branch -a"
abbr -a gs "git status -sb"
abbr -a gc "git checkout"
abbr -a gcm "git commit --verbose"
abbr -a gph "git push origin (git rev-parse --abbrev-ref HEAD)"
abbr -a gpl "git pull origin (git rev-parse --abbrev-ref HEAD)"
abbr -a gdf 'git diff --word-diff'
abbr -a gnb 'git switch -c'

# for curl
abbr -a c "curl -sfSL"
abbr -a get "curl -sfSL -XGET"
abbr -a dl "curl -sfSL -XGET -O"
abbr -a post "curl -sfSL -XPOST"
abbr -a put "curl -sfSL -XPUT"
abbr -a cw "curl -sfSL -o /dev/null -w '%{json}'"


