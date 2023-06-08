#!/usr/bin/env bash

has_docker=$(which docker)

if [[ -z "$has_docker" ]]; then
    sudo apt install docker.io 
fi

in_docker_group=$(groups | grep -c docker)

if [[ "$in_docker_group" -eq "0" ]]; then
    sudo usermod -aG docker "$USER"
    >&2 echo "You need to log out and in again before you can use docker."
fi
