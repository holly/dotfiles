#!/usr/bin/env bash

set -e
set -u
set -o pipefail

cd $(dirname $0)

local_hash=$(git log -1 --pretty=%H HEAD)
remote_hash=$(git ls-remote origin HEAD | cut -f1)

if [[ "$local_hash" == "$remote_hash" ]]; then
    echo "local and remote branch are syncronized."
    exit 0
fi

git pull origin main
