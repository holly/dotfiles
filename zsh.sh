#!/bin/sh

set -e

cd $(dirname $0)

DOTZSH=$PWD/.zsh
ZSHENV=$DOTZSH/.zshenv
SYMLINK_DOTZSH=$HOME/.zsh
SYMLINK_ZSHENV=$HOME/.zshenv

ln -sf $DOTZSH $SYMLINK_DOTZSH
ln -sf $ZSHENV $SYMLINK_ZSHENV
