#!/bin/bash
date >> dotlog

files=(
    "config/.gitconfig"
    "config/.zshrc"
)

function perform {
    echo -ne "\t\t • $1"
    eval $2 >> dotlog
    echo -e " ✔\\r"
}

echo "Running setup..."

echo -e "\t• Installing:"
# perform homebrew "ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)""
# perform nvm "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash"
# perform rbenv "brew update && brew install rbenv ruby-build"

# symlink dot files
echo -e "\t• Linking:"
for f in "${!files[@]}"
    do
        perform "${files["$f"]}" "echo ${files["$f"]}" # link files
    done

# clean
echo "Setup complete."
exit