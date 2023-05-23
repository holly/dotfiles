#!/usr/bin/env bash

set -o pipefail
set -C

REPOSITORY_URL=https://github.com/holly/dotfiles.git
DEPENDENCY_COMMANDS=(fish batcat nvim aws terraform ansible glow fzf rg duf)
LOCAL_DOTFILES="$HOME/.dotfiles"
LOCAL_INSTALL_DIR="$HOME/.local/bin"

PYENV_REPO=https://github.com/pyenv/pyenv.git
PYENV_VIRTUALENV_REPO=https://github.com/yyuu/pyenv-virtualenv.git

if [[ -z "$PYTHON_VERSION" ]]; then
    PYTHON_VERSION=3.12.0a7
fi
if [[ -z "$GLOW_VERSION" ]]; then
    GLOW_VERSION=1.5.0
fi
GLOW_DOWNLOAD_URL="https://github.com/charmbracelet/glow/releases/download/v${GLOW_VERSION}/glow_${GLOW_VERSION}_Linux_x86_64.tar.gz"

if [[ -z "$TF_VERSION" ]]; then
    TF_VERSION=1.4.6
fi
TF_DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"


warn() {
    echo -ne "\e[33;1m"
    echo "[WARN] $@"
    echo -ne "\e[m"
}


symlink_targets() {
    pushd $LOCAL_DOTFILES >/dev/null
    find . \( -type d -name ".git"  -o -name README.md -o -name .gitignore -o -name setup.sh -o -name update.sh -o -name fish_greeting.fish \) -prune -o -type f -print | perl -nlpe 's/^\.\///'
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

# install python
eval "$(pyenv init -)"
if [[ ! -d "$PYENV_ROOT/versions/$PYTHON_VERSION" ]]; then
    pyenv install --verbose $PYTHON_VERSION
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
curl -sfL $GLOW_DOWNLOAD_URL | tar -C $LOCAL_INSTALL_DIR -xzf - glow

# install fzf
if [[ -d "$HOME/.fzf" ]]; then
    rm -frv "$HOME/.fzf"
fi
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
$HOME/.fzf/install --all

# install terraform
curl -sfLO $TF_DOWNLOAD_URL
unzip "terraform_${TF_VERSION}_linux_amd64.zip"
mv terraform $LOCAL_INSTALL_DIR
rm "terraform_${TF_VERSION}_linux_amd64.zip"

# install vim-plug
curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install nvim plugins by vim-plug
nvim -c PlugInstall -c ':q!' -c ':q!'

# install fisher and more plugins
fish -c "curl -sfL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
cat <<EOL | xargs -I% fish -c "fisher install %"
oh-my-fish/theme-bobthefish
laughedelic/fish_logo
jethrokuan/z
0rax/fish-bd
jethrokuan/fzf
EOL

# symlink
ln -sfv "$LOCAL_DOTFILES/.config/fish/functions/fish_greeting.fish" "$HOME/.config/fish/functions/fish_greeting.fish"

echo ""
echo ">> done."
