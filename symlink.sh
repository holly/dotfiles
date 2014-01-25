#!/bin/bash

cd $(dirname $0)

REDHAT_RELEASE=/etc/redhat-release
OS_RELEASE=/etc/os-release
if [ -e $REDHAT_RELEASE ]; then
	OS=$(awk '{ print $1 }' $REDHAT_RELEASE | tr '[:upper:]' '[:lower:]')
elif [ -e $OS_RELEASE ]; then
	OS=$(grep -e '^ID=' $OS_RELEASE | sed -e 's/ID=//')
else
	OS=unknown
fi
ln -sf ".bashrc.$OS" .bashrc

DOTFILES=$(ls -A | grep -e "^\." | grep -ve "^\.git$" | grep -ve "^\.gitmodules$" | grep -ve "^\.gitignore" | grep -ve '^\.bashrc\.')
DATE=$(date +%y%m%d)


if [ -r ~/.bash_profile -a ! -L ~/.bash_profile ]; then
	mv ~/.bash_profile ~/.bash_profile.$DATE
fi

if [ ! -r ~/.bash_aliases ]; then
	touch ~/.bash_aliases
fi

if [ ! -d ~/.vim_tmp ]; then
	mkdir ~/.vim_tmp
fi

for DOTFILE in $DOTFILES; do
	ln -Fis "$PWD/$DOTFILE" $HOME
done
