alias date='gdate'

# Path to your oh-my-zsh installation.
export ZSH=/Users/walter/.oh-my-zsh

# zsh plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# api keys
source ~/.personal-keys

# gcloud
source ~/google-cloud-sdk/path.zsh.inc
source ~/google-cloud-sdk/completion.zsh.inc

# theme setup
ZSH_THEME=""
autoload -U promptinit; promptinit
prompt pure

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# gpg setup
export GPG_TTY=$(tty)

# nvm setup
export NVM_DIR="$HOME/.nvm"
nvm() {
  . "$(brew --prefix nvm)/nvm.sh"
  nvm "$@"
}

export PATH="node_modules/.bin:$PATH" # make sure local node_modules are used over global ones
export PATH="$(brew --prefix qt@5.5)/bin:$PATH" # make sure we have qt

# file .nvmrc exists, use the set version
if_nvmrc_nvm_use() {
    if [ -f .nvmrc ]; then
        NVMRC=$(cat .nvmrc | sed s/v//)
        NODE_VERSION=$(node -v | sed s/v//)

        if [[ "$NODE_VERSION" == "$NVMRC" ]]; then
        else
            printf "node version mismatch!"
            printf "nvm use $NVMRC...\n"
            nvm use $NVMRC
            printf "done."
        fi
    fi
}

if_nvmrc_nvm_use

# cd-hook
cd() {
    # pre
    if [ -z "$1" ]; then
        builtin cd
    else
        builtin cd "$1"
    fi
    # post
    if_nvmrc_nvm_use
}

# rbenv setup
eval "$(rbenv init - zsh)"
export PATH=".bundle/binstubs:$PATH"

# pyenv setup
eval "$(pyenv init - zsh)"

# watches directories
watchdir () { watch "ls -lrt ${1} | tail -10" $1 }
export watchdir

# useful gif conversion
function gif() {
    ffmpeg -i $1 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=10 --delay=6 > $2
}

# useful http server
function http() {
    python -m SimpleHTTPServer $1
}

# open zshconfig with sublime
alias zshconfig="subl ~/.zshrc"

# sleep
alias bye="pmset sleepnow"

# bundle exec
alias bx="bundle exec"

# postgresql@9.4 setup
export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"

# jenv setup
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

unsetopt AUTO_CD