#!/usr/bin/env bash

cd dist/ && eval "while true; do sleep 600; echo "Refreshing dyno"; curl $HEROKU_URL; done" & $CACHE_DIR/godot_headless.64 --main-pack linux.pck