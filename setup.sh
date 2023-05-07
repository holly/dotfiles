#!/usr/bin/env bash

set -e
set -u
set -o pipefail

REPOSITORY_URL=https://github.com/holly/dotfiles.git
DEPENDENCY_COMMANDS=(fish batcat nvim aws terraform ansible glow fzf rg)
LOCAL_DOTFILES="$HOME/.dotfiles"

error() {
    echo "[ERROR] $@"
    exit 1
}

symlink_targets() {
    pushd $LOCAL_DOTFILES >/dev/null
    find . \( -type d -name ".git"  -o -name README.md -o -name .gitignore -o -name setup.sh \) -prune -o -type f -print | perl -nlpe 's/^\.\///'
    popd >/dev/null
}

echo ">> start dotfiles installation...."
echo ""

for c in ${DEPENDENCY_COMMANDS[@]}; do

    which $c >/dev/null
    if [[ $? -eq 0 ]]; then
        echo "$c is installed."
    else
        error "$c is not installed."
    fi
done

# fisher all plugin update
fish -c "fisher update"

if [[ -d $LOCAL_DOTFILES ]]; then
    echo "dotfiles repository is installed. remove repository and force install."
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


# install vim-plug
curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall -c q -c q

echo ""
echo ">> done."
