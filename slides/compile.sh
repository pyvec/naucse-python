#!/usr/bin/env bash

if [[ -f "$1" ]]; then
    jupyter nbconvert $1 --to slides --post serve --SlidesExporter.reveal_scroll=True
else
    echo "File \"$1\" not found"
    exit 1
fi
