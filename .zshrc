#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Users/jeffwu/.multirust/toolchains/stable/cargo/bin:/Users/jeffwu/.multirust/toolchains/1.5.0/cargo/bin"

bindkey \^U backward-kill-line

alias g='git'

# fasd setup
# SEE here for more info: https://github.com/clvv/fasd
eval "$(fasd --init auto)"

alias sx='screen -x'         # attach screen session
alias sl='screen -ls'        # list screen sessions
alias ss='screen -S'         # start screen session
function sd { # delete screen session
  echo screen -S $1 -X quit
}


alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias dd='fasd -sid'     # interactive directory selection
alias ff='fasd -sif'     # interactive file selection

alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias em='emacsclient'
alias e='fasd -f -e emacsclient' # quick opening files with emacs
alias v='fasd -f -e vim' # quick opening files with vim
# alias v='f -t -e vim -b viminfo'

function restart_emacs {
  killall emacs; emacs --daemon
}

eval "$(thefuck --alias f)"

alias docs='pushd ~/Documents'
alias dls='pushd ~/Downloads'
alias p='pushd ~/Projects'
alias t='pushd ~/Dropbox/Terminal'
alias tcore='pushd ~/Dropbox/Terminal/terminal-core/'
alias sc='pushd ~/Dropbox/Terminal/seismic-core/'
alias sp='pushd ~/Dropbox/Terminal/seismic-provisioner/'
alias sb='pushd ~/Dropbox/Terminal/switchboard/'
alias sw='pushd ~/Dropbox/Terminal/seismicweb/'

export PATH=$PATH:~/.multirust/toolchains/stable/cargo/bin
export PATH=$PATH:~/.multirust/toolchains/1.5.0/cargo/bin
export PATH=$PATH:~/Library/Haskell/bin
export RUST_BACKTRACE=1
