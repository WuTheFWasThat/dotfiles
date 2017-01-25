# https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# bindkey "^[[A" up-line-or-beginning-search # Up
# bindkey "^[[B" down-line-or-beginning-search # Down

# for emacs mode:
bindkey '^u' backward-kill-line

# set vi mode
# bindkey -v
# decrease delay afer <ESC> key
export KEYTIMEOUT=1

# neither seems totally correct, but:
# http://www.tcsh.org/tcsh.html/Editor_commands.html
# `man bash`
bindkey '^h' backward-char
bindkey '^l' forward-char
bindkey '^k' up-history
bindkey '^j' down-history
# ^k and ^j might not work in tmux (used for switching panes)
# bindkey '^p' up-history
# bindkey '^n' down-history
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

bindkey '^v' edit-command-line
# bindkey -M vicmd v edit-command-line

bindkey '^b' backward-word
bindkey '^f' forward-word

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' fzf-history-widget
# bindkey '^r' history-incremental-search-backward
# bindkey '^r' history-incremental-pattern-search-backward
bindkey '^g' clear-screen
