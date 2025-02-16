#!/bin/sh
set -o errexit

brew install aquaproj/aqua/aqua
brew install fish

brew install markdownlint-cli
brew install imagemagick
brew install gitmoji

if [ "$(uname)" = 'Darwin' ]; then
  brew install wezterm
  brew install --cask nikitabobko/tap/aerospace

  brew install font-noto-emoji
  brew install font-udev-gothic
fi
if [ "$(uname)" = 'Linux' ]; then
  brew install wez/wezterm-linuxbrew/wezterm

  brew tap homebrew/linux-fonts
  brew install font-noto-emoji --HEAD
  brew install font-udev-gothic
fi
