# dotfiles

## setup

```
curl -fsSL https://raw.github.com/holly/dotfiles/main/setup.sh | bash - 
```

## common

## nvim

[init.vim](https://raw.githubusercontent.com/holly/dotfiles/main/.config/nvim/init.vim)

### plugins

* scrooloose/nerdtree
* othree/eregex.vim
* tmhedberg/matchit
* junegunn/vim-easy-align
* thinca/vim-quickrun
* Shougo/vimproc.vim
* LeafCage/yankround.vim
* junegunn/fzf
* junegunn/fzf.vim
* tpope/vim-surround
* tpope/vim-commentary
* itchyny/lightline.vim
* dhruvasagar/vim-table-mode
* vim-airline/vim-airline
* vim-airline/vim-airline-themes
* tyru/open-browser.vim
* skanehira/preview-markdown.vim
* nickeb96/fish.vim
* hashivim/vim-terraform
* godlygeek/tabular
* plasticboy/vim-markdown
* previm/previm
* neovim/nvim-lspconfig
* williamboman/nvim-lsp-installer
* ray-x/lsp_signature.nvim
* hrsh7th/nvim-cmp
* hrsh7th/cmp-nvim-lsp
* hrsh7th/cmp-buffer
* hrsh7th/cmp-path
* hrsh7th/cmp-cmdline
* onsails/lspkind-nvim
* ray-x/cmp-treesitter

## abbr

defined in [config.fish](https://raw.githubusercontent.com/holly/dotfiles/main/.config/fish/config.fish)

### for terraform

* tf "terraform"
* tfa "terraform apply"
* tfp "terraform plan"
* tfd "terraform destroy"

### for aws cli

* s3  "aws s3"
* ec2 "aws ec2"

### for tmux

* t "tmux -u"
* ta "tmux attach"

### for exa

* ls "exa --icons"
* lt 'exa -T -L 3 -a -I ".git|.cache|.terraform" --icons'
* ltl 'exa -T -L 3 -a -I ".git|.cache|.terraform" -l --icons'

### for git 

* g  "git"
* ga "git add . && git add -u && git status"
* gb "git fetch && git branch -a"
* gs "git status -sb"
* gc "git checkout"
* gcm "git commit --verbose"
* gph "git push origin (git rev-parse --abbrev-ref HEAD)"
* gpl "git pull origin (git rev-parse --abbrev-ref HEAD)"
* gdf 'git diff --word-diff'
* gnb 'git switch -c'

### for curl

* c "curl -sfSL"
* get "curl -sfSL -XGET"
* dl "curl -sfSL -XGET -O"
* post "curl -sfSL -XPOST"
* put "curl -sfSL -XPUT"
* cw "curl -sfSL -o /dev/null -w '%{json}'"


### for common

* x "chmod +x"
* strace "strace -s 1024 -tt -f -T -v"
* od "od -tcx1"
* tcf "tar --exclude-backups --exclude=\"*.old\" --exclude=\"*.swp\" --exclude=\"*.tmp\" --exclude=\"*.org\" --exclude=\"*.pid\" --exclude=\"lock\" --exclude=\"*~\" --ignore-failed-read --one-file-system -pcvzf"
* txf "tar --ignore-failed-read -pxvf"
* tat "tar --ignore-failed-read -ptvf"
* epoch "date +%s"
* dt "date --iso-8601=seconds"
* df "duf"
* myip "curl https://ifconfig.me && echo"
* comma "printf \"%'d\n\""
* delempty "egrep -v '^\$'"
* alignlf "perl -i -nlpe 's/\x0d//g'"

## functions

defined in [util.fish](https://raw.githubusercontent.com/holly/dotfiles/main/.config/fish/conf.d/util.fish)
