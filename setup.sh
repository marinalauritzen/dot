#!/bin/bash
date >> dotlog
echo "Running setup..."
ln -sf config/.gitconfig ~/.gitconfig
ln -sf config/.zshrc ~/.zshrc
ln -sf ~/code/dot/snippets ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
echo "Setup complete."
exit