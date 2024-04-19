#!/bin/bash

TAMARIN_VER="1.8.0"

WORK_DIR_NAME=$(basename $PWD)

if [[ "$1" == "" ]]; then
  port="3001"
else
  port="$1"
fi

podman run -it \
  -v "$PWD":/home/user/"$WORK_DIR_NAME" \
  --userns keep-id \
  --workdir /home/user/"$WORK_DIR_NAME" \
  --rm \
  -p "127.0.0.1:$port:3001" \
  localhost/tamarin-prover:"$TAMARIN_VER"
