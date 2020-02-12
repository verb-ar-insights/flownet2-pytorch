#!/bin/bash
INPUT_FOLDER="${1}"
wd="$(pwd)"
dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
if [[ "$wd" = "$dir" ]]; then
  sudo nvidia-docker build -t flownet2-pytorch:genflow .
fi

sudo nvidia-docker run --rm -ti \
    --user=${UID}${GID+:}${GID} \
    --volume="${INPUT_FOLDER}":/datasets:rw \
    --workdir=/flownet2-pytorch \
    --ipc=host \
    flownet2-pytorch:genflow \
    /datasets "${@:2}"

