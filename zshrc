# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
plugins=(git extract macos)

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# automatically upgrade
export DISABLE_UPDATE_PROMPT=true
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export VISUAL='vim'
export EDITOR='vim'

# ffuuuuu
if which thefuck &>/dev/null; then
  eval "$(thefuck --alias fu)"
fi

if which nvim &>/dev/null; then
  alias vim="nvim"
fi


export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:~/.multirust/toolchains/stable/cargo/bin
export PATH=$PATH:~/.multirust/toolchains/1.5.0/cargo/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/Library/Haskell/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
export PATH=$PATH:$HOME/.yarn/bin
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew >/dev/null 2>&1; then
  export PATH="$(brew --prefix)/bin:$PATH"
  export PATH="/usr/local/opt/ruby@3.2/bin:$PATH"
  # export PATH="/usr/local/opt/ruby/bin:$PATH"
fi
export RUST_BACKTRACE=1

for file in ~/.zshrc_scripts/*; do
   source "$file"
done
alias w='watchcmd'

# SEE: https://babushk.in/posts/renew-environment-tmux.html
# NOTE: causes issues with prompt display in mosh
# function preexec {
#   if [ -n "$TMUX" ]; then
#     export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
#     export $(tmux show-environment | grep "^DISPLAY")
#   fi
# }

if which fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

