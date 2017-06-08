# Path to your oh-my-zsh installation.
export ZSH=/Users/walter/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
source /opt/boxen/env.sh
export FZF_DEFAULT_COMMAND='ag -g ""'

source $ZSH/oh-my-zsh.sh

# api keys
source ~/.config/keys

#init rbenv
eval "$(rbenv init - zsh)"
# export PATH=".bundle/binstubs:$PATH" # make sure local gems are used, rather than global

# init nvm
export NVM_DIR="$HOME/.nvm"
nvm() {
  . "$(brew --prefix nvm)/nvm.sh"
  nvm "$@"
}
export PATH="node_modules/.bin:$PATH" # make sure local node_modules are used, rather than global

# watches directories
taildir () { watch "ls -lrt ${1} | tail -10" }
export taildir

function vpn {
/usr/bin/env osascript <<-EOF
tell application "System Events"
    tell current location of network preferences
        set VPN to service "${1}" -- your VPN name here
        if exists VPN then connect VPN
        repeat while (current configuration of VPN is not connected)
            delay 1
        end repeat
    end tell
end tell
EOF
}

function serve() {
    python -m SimpleHTTPServer $1
}

function gif() {
    ffmpeg -i $1 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=10 --delay=6 > $2
}

function gifhd() {
    palette="/tmp/palette.png"
    filters="fps=15,scale=600:-1:flags=lanczos"
    ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
    ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
}

# Usage: vpn <name>. Defaults to "GoCardless"
#
# I've found that if the VPN doesn't connect in the first few seconds,
# it's basically not going to work. Rather than letting it time out
# naturally (which takes a long time and results in a dialog box), we
# pre-emptively kill it.
function vpn () {
    local vpn="${1:-GoCardless}"
    local vpn_status=$(scutil --nc status $vpn | head -n1)

    if [[ "$vpn_status" = "Connected" ]];
    then
      echo "Already connected"
      return
    fi

    printf "Attempting to connect to VPN.."
    max_seconds_to_restart=5
    seconds_to_restart=$max_seconds_to_restart
    while [[ ! "$vpn_status" = "Connected" ]]
    do
        printf $seconds_to_restart
        if [[ $seconds_to_restart = 0 ]];
        then
          seconds_to_restart=$max_seconds_to_restart
          printf "*"
          pkill -9 pppd
        fi

        printf "."
        /usr/bin/env osascript >> /dev/null 2>&1 <<EOF
tell application "System Events"
  tell current location of network preferences
    set VPN to service "$vpn"
    if exists VPN then connect VPN
  end tell
end tell
EOF
        sleep 1
        seconds_to_restart=$(($seconds_to_restart-1))
        vpn_status=$(scutil --nc status $vpn | head -n1)
    done
    printf "\n"
    echo "$vpn_status"
}

function optimus() {
    export PGHOST="optimus.gocardless.com"
    export PGPORT="$1"
    export PGUSER="gc"
    export PGPASSWORD="password"
    export PGDATABASE="$2"
}

# aliases
# alias ytb_yesterday='cat $YTB_PATH/$(echo `date -v-1d +%F`)' # what did I do yesterday?
# alias ytb_today='cat $YTB_PATH/$(echo `date +%F`)' # what have I done today?
# alias ytb_watch='tail -f $YTB_PATH/$(echo `date +%F`)' # watch what I have done today
alias empty='rm -rf ~/.Trash/*'
alias gc='cd ~/gc/'
alias bye='pmset sleepnow'
alias iossim='sudo open /Applications/Xcode.app/Contents/Developer/Applications/iOS\ Simulator.app'
alias npmsw='npm shrinkwrap'
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias bx='bundle exec'
alias sl='serverless'
alias pgconfig='echo "\e[34mpostgres configuration\n=====\e[0m\n\e[31m\$PGPASSWORD:\e[0m $PGPASSWORD\n\e[31m\$PGUSER:\e[0m $PGUSER\n\e[31m\$PGHOST:\e[0m $PGHOST\n\e[31m\$PGPORT:\e[0m $PGPORT\n\e[31m\$PGDATABASE:\e[0m $PGDATABASE"'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh