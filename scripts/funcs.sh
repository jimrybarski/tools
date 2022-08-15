#!/usr/bin/env bash

function mvf () {
    directory=${@: -1}
    echo "all: $@"
    echo "last: $directory"
}
