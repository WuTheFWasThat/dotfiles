# SEE here for more info: https://github.com/clvv/fasd
eval "$(fasd --init auto)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias dd='fasd -sid'     # interactive directory selection
alias f='fasd -f'        # file
alias ff='fasd -sif'     # interactive file selection

# SEE: http://seanbowman.me/blog/fzf-fasd-and-bash-aliases/

# alias j='fasd_cd -d'
j() {
    local dir="$(fasd -ld "$@" | tail -n 1)"
    [[ -d "$dir" ]] && pushd "$dir"
}
# complete -d j

# alias jj='fasd_cd -d -i'
jj() {
    local dir
    dir=$(fasd -Rdl |\
        sed "s:$HOME:~:" |\
        fzf --no-sort +m -q "$*" |\
        sed "s:~:$HOME:")\
    && pushd "$dir"
}
# complete -d jj

# quick opening files with emacs
alias e='fasd -f -e "emacsclient -c"'

# quick opening files with vim
alias v='fasd -f -e vim'

vv() {
  local file
  file=$(fasd -Rfl | fzf --no-sort +m -q "$*" -1 )
  vim $file
}

# alias v='f -t -e vim -b viminfo'
