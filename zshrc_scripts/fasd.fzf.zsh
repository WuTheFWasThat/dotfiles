# SEE here for more info: https://github.com/clvv/fasd
eval "$(fasd --init auto)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_R_OPTS='--sort --exact'

# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias dd='fasd -sid'     # interactive directory selection
dd() {
  fasd -Rdl | fzf -m -q "$*"
}
# alias f='fasd -f'        # file
# alias ff='fasd -sif'     # interactive file selection
ff() {
  fasd -Rfl | fzf -m -q "$*"
}

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
        fzf +m -q "$*" |\
        sed "s:~:$HOME:")\
    && pushd "$dir"
}
# complete -d jj

# quick opening files with emacs
alias e='fasd -f -e "emacsclient -c"'

# quick opening files with vim
alias v='fasd -f -e vim'

# alias v='f -t -e vim -b viminfo'

vv() {
  local files=$(fasd -Rfl | fzf -m -q "$*")
  if [[ -z $files ]]; then return 1; fi
  vim $files
}
