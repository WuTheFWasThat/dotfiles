# Path to your oh-my-zsh installation.
export ZSH=/Users/jeffwu/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jeffwu"

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
plugins=(git extract)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
bindkey \^U backward-kill-line

#####
# emacs stuff
#####

function eml {
  ps aux | grep 'emacs --daemon' | grep -v grep
}

function ems {
  local name=$1
  if [ -n "$name" ]; then
    emacs --daemon=$name
  else
    emacs --daemon
  fi
}

function emx {
  local name=$1
  shift
  if [ -n "$name" ]; then
    emacsclient -c -s $name $@
  else
    emacsclient -c $@
  fi
}

function emk {
  local name=$1
  if [ -n "$name" ]; then
    line=$(ps aux | grep "emacs --daemon=$name" | grep -v grep | head -n 1)
  else
    line=$(ps aux | grep 'emacs --daemon$' | grep -v grep | head -n 1)
  fi
  pid=$(echo $line | awk '{ print $2 }')
  kill $pid
}

function emr {
  local name=$1
  emacsd_kill $name
  emacsd_start $name
}

function em {
  # test if we're in a screen window
  if [ -n "$STY" ]; then
    name=$(echo $STY | cut -d '.' -f 2)
    emx $name $@
  else
    emx '' $@
  fi
}

############
# gnu screen
############

alias sx='screen -x'         # attach screen session
alias sl='screen -ls'        # list screen sessions
function ss {                # start screen session
  local name=$1
  # echo nohup ems $name
  # nohup ems $name &>/dev/null &
  # TODO: figure out how to nohup
  ems $name
  screen -S $name
}
function sk {                # kill screen session
  # default to killing current session
  local name=${1:-$STY}
  if [ -z "$name" ]; then
    sl
    echo "Must specifiy which screen session to kill!"
    return 1
  fi
  # TODO: this doesn't work from within the screen session for some reason
  echo emk $name
  emk $name
  screen -S $name -X quit
}

# fasd setup
# SEE here for more info: https://github.com/clvv/fasd
eval "$(fasd --init auto)"

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias dd='fasd -sid'     # interactive directory selection
alias f='fasd -f'        # file
alias ff='fasd -sif'     # interactive file selection

alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias e='fasd -f -e em' # quick opening files with emacs
alias v='fasd -f -e vim' # quick opening files with vim
# alias v='f -t -e vim -b viminfo'

eval "$(thefuck --alias f)"

alias docs='pushd ~/Documents'
alias dls='pushd ~/Downloads'
alias p='pushd ~/Projects'

export TERMINAL_HOME=/Users/jeffwu/Dropbox/Terminal/
alias t='pushd ~/Dropbox/Terminal'
alias tcore='pushd ~/Dropbox/Terminal/terminal-core/'
alias sc='pushd ~/Dropbox/Terminal/seismic-core/'
alias sp='pushd ~/Dropbox/Terminal/seismic-provisioner/'
alias sb='pushd ~/Dropbox/Terminal/switchboard/'
alias sw='pushd ~/Dropbox/Terminal/seismicweb/'

export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:~/.multirust/toolchains/stable/cargo/bin
export PATH=$PATH:~/.multirust/toolchains/1.5.0/cargo/bin
export PATH=$PATH:~/Library/Haskell/bin
export RUST_BACKTRACE=1
