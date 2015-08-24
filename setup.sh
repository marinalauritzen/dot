#!/bin/bash

files=(".gitconfig" ".zshrc")

function complete {
    echo -e " ✔\\r"
}

function install {
    echo -ne "\t\t$1"
    eval $2 > dotlog
    complete
}

echo "Running setup..."

echo -e "\tInstalling:"
install testInstall "npm --version"
# install homebrew "ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)""
# install nvm "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash"
# install rbenv "brew update && brew install rbenv ruby-build"

# symlink dot files
echo -e "\tLinking:"
for f in "${!files[@]}"
do
 echo -ne "\t\t${files["$f"]}"
 # link files
 complete
done

echo "Setup complete."