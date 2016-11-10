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
plugins=(git extract osx)

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

# for emacs mode:
bindkey \^U backward-kill-line

# use vim mode
# bindkey -v
# export KEYTIMEOUT=1

#####
# python
#####

export PYTHONPATH=.:/usr/local/lib/python
alias py='python'
alias py3='python3'
alias ipy='ipython'

function list_space {
  du -sh -- $1*  | sort -rg
}

alias h='history | less'
alias b='popd'

alias docs='pushd ~/Documents'
alias dls='pushd ~/Downloads'
alias p='pushd ~/Projects'

# stupid: nvim C-H doesn't work
# alias vim='nvim'
alias plug='vim +PlugInstall +qall'

# ffuuuuu
eval "$(thefuck --alias fu)"

# stuff for work
source ~/.workrc.sh

export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:~/.multirust/toolchains/stable/cargo/bin
export PATH=$PATH:~/.multirust/toolchains/1.5.0/cargo/bin
export PATH=$PATH:~/Library/Haskell/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
export RUST_BACKTRACE=1

# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

for file in ~/.zshrc_scripts/*; do
   source "$file"
done

# The next line updates PATH for the Google Cloud SDK.
source ~/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
source ~/google-cloud-sdk/completion.zsh.inc

# [[ -s ~/.openai/bashrc ]] && source ~/.openai/bashrc

export PATH="$HOME/.yarn/bin:$PATH"

# set vi mode
bindkey -v
# decrease delay afer <ESC> key
export KEYTIMEOUT=1

# neither seems totally correct, but:
# http://www.tcsh.org/tcsh.html/Editor_commands.html
# `man bash`
bindkey '^h' backward-char
bindkey '^l' backward-char
bindkey '^k' up-history
bindkey '^j' down-history
# ^k and ^j might not work in tmux (used for switching panges)
bindkey '^p' up-history
bindkey '^n' down-history

bindkey '^b' backward-word
bindkey '^f' forward-word

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# bindkey '^w' backward-delete-word
# bindkey '^w' unix-word-rubout
# bindkey '^y' yank
bindkey '^r' fzf-history-widget
bindkey '^u' vi-kill-line
# bindkey '^u' unix-line-discard
bindkey '^g' clear-screen
# bindkey '^r' history-incremental-search-backward
# bindkey '^r' history-incremental-pattern-search-backward
