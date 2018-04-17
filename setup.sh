#!/usr/bin/env bash

set -eu

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle

if [ ! -e "$HOME/.zshrc" ]
then
  ln -s $PWD/config/.zshrc $HOME/.zshrc
else
  echo "⚠️  $HOME/.zshrc already exists" >&2
fi

if [ ! -e "$HOME/.tmux.conf" ]
then
  ln -s $PWD/config/.tmux.conf $HOME/.tmux.conf
else
  echo "⚠️  $HOME/.tmux.conf already exists" >&2
fi

if [ ! -e "$HOME/.gitconfig" ]
then
  ln -s $PWD/config/.gitconfig $HOME/.gitconfig
else
  echo "⚠️  $HOME/.gitconfig already exists" >&2
fi

if [ ! -e "$HOME/.gitignore" ]
then
  ln -s $PWD/config/.gitignore_global $HOME/.gitignore
else
  echo "⚠️  $HOME/.gitignore already exists" >&2
fi

if [ ! -e "$HOME/.ssh/config" ]
then
  ln -s $PWD/config/.ssh.config $HOME/.ssh/config
else
  echo "⚠️  $HOME/.ssh/config already exists" >&2
fi

if [ ! -e "$HOME/.gnupg/gpg-agent.conf" ]
then
  ln -s $PWD/config/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
else
  echo "⚠️  $HOME/.gnupg/gpg-agent.conf already exists" >&2
fi

if [ ! -e "$HOME/.config/karabiner/karabiner.json" ]
then
  ln -s $PWD/config/karabiner.json $HOME/.config/karabiner/karabiner.json
else
  echo "⚠️  $HOME/.config/karabiner/karabiner.json already exists" >&2
fi

if [ ! -e "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings" ]
then
  ln -fs $PWD/config/Preferences.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
else
  echo "⚠️  $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings already exists" >&2
fi

if [ ! -e "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package\ Control.sublime-settings" ]
then
  ln -fs $PWD/config/Package\ Control.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
else
  echo "⚠️  $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings already exists" >&2
fi

if [ ! -e "$HOME/Library/Application Support/Sublime Text 3/Packages/User/snippets" ]
then
  ln -fs $PWD/snippets $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
else
  echo "⚠️  $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets already exists" >&2
fi