if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x LANG ja_JP.UTF-8
set -x TZ Asia/Tokyo
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x EDITOR nvim
set -x RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

set -x FZF_DEFAULT_OPTS "--height 50% --reverse --border"
set -x FZF_CTRL_T_COMMAND 'rg --files --hidden --follow --glob \"!.git/*\"'
set -x FZF_CTRL_T_OPTS "--preview \"batcat --color=always --style=header,grid --line-range :100 {}\""


fish_add_path "$HOME/.local/bin"

abbr -a vi nvim
abbr -a vimrc "nvim $HOME/.config/nvim/init.vm"

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
end

# for common abbr
abbr -a x "chmod +x"
abbr -a strace "strace -s 1024 -tt -f -T -v"
abbr -a od "od -tcx1"
abbr -a tcf "tar --exclude-backups --exclude=\"*.old\" --exclude=\"*.swp\" --exclude=\"*.tmp\" --exclude=\"*.org\" --exclude=\"*.pid\" --exclude=\"lock\" --exclude=\"*~\" --ignore-failed-read --one-file-system -pcvzf"
abbr -a txf "tar --ignore-failed-read -pxvzf"
abbr -a tat "tar --ignore-failed-read -ptvzf"
abbr -a epoch "date +%s"
abbr -a dt "date --iso-8601=seconds"

# for git abbr
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
abbr -a download "curl -sfSL -XGET -O"
abbr -a post "curl -sfSL -XPOST"
abbr -a put "curl -sfSL -XPUT"
abbr -a cw "curl -sfSL -o /dev/null -w '%{json}'"


# for pyenv init
pyenv init - | source
