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
alias e='fasd -f -e "emacsclient -c"' # quick opening files with emacs
alias v='fasd -f -e vim' # quick opening files with vim
# alias v='f -t -e vim -b viminfo'
