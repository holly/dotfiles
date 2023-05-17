#!/usr/bin/env bash

set -u
set -o pipefail

REPOSITORY_URL=https://github.com/holly/dotfiles.git
DEPENDENCY_COMMANDS=(fish batcat nvim aws terraform ansible glow fzf rg)
LOCAL_DOTFILES="$HOME/.dotfiles"

warn() {
    echo -ne "\e[33;1m"
    echo "[WARN] $@"
    echo -ne "\e[m"
}


symlink_targets() {
    pushd $LOCAL_DOTFILES >/dev/null
    find . \( -type d -name ".git"  -o -name README.md -o -name .gitignore -o -name setup.sh -o -name update.sh \) -prune -o -type f -print | perl -nlpe 's/^\.\///'
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

# install nvim plugins by vim-plug
nvim -c PlugInstall -c ':q!' -c ':q!'

# update all fisher plugins
fish -c "fisher update"
ln -sfv "$LOCAL_DOTFILES/.config/fish/functions/fish_greeting.fish" "$HOME/.config/fish/functions/fish_greeting.fish"

# daemon-reload
systemctl --user daemon-reload
for unit in $(echo service timer); do
    systemctl --user enable "dotfiles.$unit"
done

echo ""
echo ">> done."
