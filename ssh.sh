#!/usr/bin/env bash

set -e

cd $(dirname $0)

DOTSSH=$PWD/.ssh
REAL_DOTSSH=$HOME/.ssh

if [ -d $REAL_DOTSSH ]; then
	mv $REAL_DOTSSH $REAL_DOTSSH.$(date +%y%m%d)
fi

mkdir $REAL_DOTSSH
# make authorized_keys
find $DOTSSH/authorized_keys.d/ -type f ! -name .gitignore | xargs --no-run-if-empty cat >$REAL_DOTSSH/authorized_keys

# make config
find $DOTSSH/config.d/ -type f ! -name .gitignore ! -name base | xargs cat $DOTSSH/config.d/base >$REAL_DOTSSH/config

# copy other files
find $DOTSSH/extra/ -type f ! -name .gitignore | xargs -n1 -I% --no-run-if-empty cp -p % $REAL_DOTSSH/
chmod 700 $REAL_DOTSSH
chmod 600 $REAL_DOTSSH/authorized_keys $REAL_DOTSSH/config
