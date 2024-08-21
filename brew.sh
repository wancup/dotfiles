#!/bin/sh
set -o errexit

brew install aquaproj/aqua/aqua
brew install fish

brew install wezterm
brew install font-noto-emoji
brew install font-udev-gothic

brew install markdownlint-cli
brew install imagemagick

if [ "$(uname)" = 'Darwin' ]; then
  brew install --cask nikitabobko/tap/aerospace
fi
