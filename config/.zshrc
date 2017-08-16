# Path to your oh-my-zsh installation.
export ZSH=/Users/walter/.oh-my-zsh

# zsh plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# api keys
source ~/.personal-keys

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

# file .nvmrc exists, use the set version
if_nvmrc_nvm_use() {
    if [ -f .nvmrc ]; then
        nvm use
    fi
}

if_nvmrc_nvm_use

# cd-hook
cd() {
    # pre
    builtin cd "$1"
    # post
    if_nvmrc_nvm_use
}

# rbenv setup
# eval "$(rbenv init - zsh)"


# watches directories
taildir () { watch "ls -lrt ${1} | tail -10" }
export taildir

# useful gif conversion
function gif() {
    ffmpeg -i $1 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=10 --delay=6 > $2
}

# useful http server
function serve() {
    python -m SimpleHTTPServer $1
}

# open zshconfig with sublime
alias zshconfig="subl ~/.zshrc"

# sleep
alias bye="pmset sleepnow"

# bundle exec
alias bx="bundle exec"