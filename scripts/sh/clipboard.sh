#!/usr/bin/env bash
sh -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'
