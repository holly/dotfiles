#!/usr/bin/env bash

set -e
set -u
set -o pipefail
set -C

cd $(dirname $0)

local_hash=$(git log -1 --pretty=%H HEAD)
remote_hash=$(git ls-remote origin HEAD | cut -f1)

if [[ "$local_hash" == "$remote_hash" ]]; then
    echo "local and remote branches are syncronized."
    exit 0
fi

git pull --tags
git pull origin $(git rev-parse --abbrev-ref HEAD)
git fetch -p

systemctl --user daemon-reload
