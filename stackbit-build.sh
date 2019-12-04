#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5de8192c0ee3d9001bbc2934/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5de8192c0ee3d9001bbc2934 
fi
curl -s -X POST https://api.stackbit.com/project/5de8192c0ee3d9001bbc2934/webhook/build/ssgbuild > /dev/null
hugo

curl -s -X POST https://api.stackbit.com/project/5de8192c0ee3d9001bbc2934/webhook/build/publish > /dev/null
