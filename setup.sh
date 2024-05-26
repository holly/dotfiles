#!/usr/bin/env bash

set -o pipefail
set -C

export TMPDIR=/tmp

REPOSITORY_URL=https://github.com/holly/dotfiles.git
DEPENDENCY_COMMANDS=(fish nvim aws)
LOCAL_DOTFILES="$HOME/.dotfiles"
LOCAL_INSTALL_DIR="$HOME/.local/bin"

PYENV_REPO=https://github.com/pyenv/pyenv.git
PYENV_VIRTUALENV_REPO=https://github.com/yyuu/pyenv-virtualenv.git
TFENV_REPO=https://github.com/tfutils/tfenv.git
GOENV_REPO=https://github.com/syndbg/goenv.git

VOLTA_INSTALL_SHELL=https://get.volta.sh

if [[ -z "$PYTHON_VERSION" ]]; then
    PYTHON_VERSION=3.12.3
fi
if [[ -z "$GLOW_VERSION" ]]; then
    GLOW_VERSION=1.5.1
fi
GLOW_DOWNLOAD_URL="https://github.com/charmbracelet/glow/releases/download/v${GLOW_VERSION}/glow_Linux_x86_64.tar.gz

if [[ -z "$EZA_VERSION" ]]; then
    EZA_VERSION=0.18.16
fi
EZA_DOWNLOAD_URL="https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"

if [[ -z "$BAT_VERSION" ]]; then
    BAT_VERSION=0.24.0
fi
BAT_DOWNLOAD_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz"

if [[ -z "$TF_VERSION" ]]; then
    TF_VERSION=1.8.4
fi
if [[ -z "$GO_VERSION" ]]; then
    GO_VERSION=1.22.3
fi
GO_DOWNLOAD_URL=https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

warn() {
    echo -ne "\e[33;1m"
    echo "[WARN] $@"
    echo -ne "\e[m"
}

error() {
    echo -ne "\e[31;1m"
    echo "[ERROR] $@"
    echo -ne "\e[m"
}


symlink_targets() {
    pushd $LOCAL_DOTFILES >/dev/null
    find . \( -type d -name ".git"  -o -name README.md -o -name .gitignore -o -name setup.sh -o -name update.sh -o -name fish_greeting.fish  -o -name fish_plugins \) -prune -o -type f -print | perl -nlpe 's/^\.\///'
    popd >/dev/null
}

echo ">> start dotfiles installation...."
echo ""

for c in ${DEPENDENCY_COMMANDS[@]}; do

    which $c >/dev/null
    if [[ $? -eq 0 ]]; then
        echo "$c is installed."
    else
        warn "$c is not installed."
    fi
done

if [[ -d $LOCAL_DOTFILES ]]; then
    warn "dotfiles repository is installed. remove repository and force install."
    rm -frv $LOCAL_DOTFILES
fi

git clone $REPOSITORY_URL $LOCAL_DOTFILES
for f in $(symlink_targets); do
    d=$(dirname $HOME/$f)
    if [[ ! -d $d ]]; then
        mkdir -p $d
    fi
    ln -sfv "$LOCAL_DOTFILES/$f" "$HOME/$f"
done

# daemon-reload
systemctl --user daemon-reload
for unit in $(echo service timer); do
    systemctl --user enable "dotfiles.$unit"
    systemctl --user start "dotfiles.$unit"
done


# for local script and executable binary
mkdir -p $LOCAL_INSTALL_DIR
export PATH="$PATH:$LOCAL_INSTALL_DIR"

# pyenv install
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
if [[ -d $PYENV_ROOT ]]; then
    (cd $PYENV_ROOT; git pull origin $(git rev-parse --abbrev-ref HEAD))
else
    git clone $PYENV_REPO $PYENV_ROOT
fi

# pyenv virtualenv install
if [[ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]]; then
    (cd "$PYENV_ROOT/plugins/pyenv-virtualenv"; git pull origin $(git rev-parse --abbrev-ref HEAD))
else
    git clone $PYENV_VIRTUALENV_REPO "$PYENV_ROOT/plugins/pyenv-virtualenv"
fi

# tfenv install
export TFENV_ROOT="$HOME/.tfenv"
export PATH="$PATH:$TFENV_ROOT/bin"
if [[ -d $TFENV_ROOT ]]; then
    (cd $TFENV_ROOT; git pull origin $(git rev-parse --abbrev-ref HEAD))
else
    git clone $TFENV_REPO $TFENV_ROOT
fi

# goenv install
#export GOENV_ROOT="$HOME/.goenv"
#export PATH="$PATH:$GOENV_ROOT/bin"
#if [[ -d $GOENV_ROOT ]]; then
#    (cd $GOENV_ROOT; git pull origin $(git rev-parse --abbrev-ref HEAD))
#else
#    git clone $GOENV_REPO $GOENV_ROOT
#fi

# volta install
curl -sfL $VOLTA_INSTALL_SHELL | bash 
export PATH="$PATH:$HOME/.volta/bin"


# install python
eval "$(pyenv init -)"
if [[ ! -d "$PYENV_ROOT/versions/$PYTHON_VERSION" ]]; then
    pyenv install --verbose $PYTHON_VERSION
    #if [[ $? -ne 0 ]]; then
    #    echo "python $PYTHON_VERSION install is failed."
    #    exit 1
    #fi
fi
pyenv local $PYTHON_VERSION

# update pip
pip install --upgrade pip

# install ansible
pip install ansible

# batcat -> bat
BATCAT=$(which batcat)
if [[ -n "$BATCAT" ]]; then
    (cd $LOCAL_INSTALL_DIR; ln -sfv $BATCAT bat)
fi

# install glow
curl -sfL $GLOW_DOWNLOAD_URL | tar -C $LOCAL_INSTALL_DIR -xvzf - glow

# install eza
curl -sfL $EZA_DOWNLOAD_URL | tar -C $LOCAL_INSTALL_DIR -xvzf - ./eza

# install bat
curl -sfL $BAT_DOWNLOAD_URL | tar -C $TMPDIR -xvzf - bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu/bat
mv $TMPDIR/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu/bat $LOCAL_INSTALL_DIR/bat

# install fzf
if [[ -d "$HOME/.fzf" ]]; then
    rm -frv "$HOME/.fzf"
fi
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
$HOME/.fzf/install --all

# install terraform
tfenv install latest
tfenv use latest

# install go
#eval "$(goenv init -)"
#goenv install $GO_VERSION
#goenv local $GO_VERSION
curl -sfL $GO_DOWNLOAD_URL | tar -C $HOME -xzf - go
ln -sf $HOME/go/bin/go $LOCAL_INSTALL_DIR/go

# install node
volta install node

# install vim-plug
curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install nvim plugins by vim-plug
#nvim -c PlugInstall -c ':q!' -c ':q!'

# install fisher and more plugins
fish -c "curl -sfL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; sleep 3 && fisher install jorgebucaran/fisher"
sleep 3
cat "$LOCAL_DOTFILES/fish_plugins" | while read line; do
    fish -c "fisher install $line"
    sleep 1
done
#cat <<EOL | xargs -I% fish -c "fisher install %"
#oh-my-fish/theme-bobthefish
#laughedelic/fish_logo
#jethrokuan/z
#0rax/fish-bd
#jethrokuan/fzf
#holly/source-fish
#holly/fish-pwgen
#EOL

# install docker compose
DOCKER_CONFIG=$HOME/.docker
#mkdir -p "$DOCKER_CONFIG/cli-plugins"
#curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
#chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# symlink start fish_logo display
ln -sfv "$LOCAL_DOTFILES/.config/fish/functions/fish_greeting.fish" "$HOME/.config/fish/functions/fish_greeting.fish"
