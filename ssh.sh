#!/usr/bin/env bash

set -e

cd $(dirname $0)

DOTSSH=$PWD/.ssh

find $DOTSSH/authorized_keys.d/ -type f ! -name .gitignore | xargs --no-run-if-empty cat >$DOTSSH/authorized_keys
find $DOTSSH/config.d/ -type f ! -name .gitignore ! -name base | xargs cat $DOTSSH/config.d/base >$DOTSSH/config
chmod 600 $DOTSSH/authorized_keys $DOTSSH/config
