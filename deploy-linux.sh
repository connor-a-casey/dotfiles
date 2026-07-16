#!/bin/bash
# Deploy dotfiles on Linux (wrapper around deploy.sh)
exec "$(dirname "$0")/deploy.sh" "$@"
