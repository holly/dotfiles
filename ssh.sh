#!/usr/bin/env bash

set -e

cd $(dirname $0)

DOTSSH=$PWD/.ssh
REAL_DOTSSH=$HOME/.ssh

if [ -d $REAL_DOTSSH ]; then
	mv $REAL_DOTSSH $REAL_DOTSSH.$(date +%y%m%d)
fi

mkdir $REAL_DOTSSH
find $DOTSSH/authorized_keys.d/ -type f ! -name .gitignore | xargs --no-run-if-empty cat >$REAL_DOTSSH/authorized_keys
find $DOTSSH/config.d/ -type f ! -name .gitignore ! -name base | xargs cat $DOTSSH/config.d/base >$REAL_DOTSSH/config
chmod 700 $REAL_DOTSSH
chmod 600 $REAL_DOTSSH/authorized_keys $REAL_DOTSSH/config
