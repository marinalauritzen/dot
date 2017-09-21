#!/bin/bash
set -e
date >> dotlog
echo "Running setup..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/bundle
brew bundle
ln -sf config/.gitconfig ~/.gitconfig
ln -sf config/.gitignore_global ~/.gitignore_global
ln -sf config/.zshrc ~/.zshrc
ln -sf config/.tmux.conf ~/.tmux.conf
ln -sf ~/code/dot/snippets ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
echo "Setup complete."
exit