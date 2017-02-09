alias py='python'
alias py3='python3'
alias ipy='ipython'

function list_space {
  du -sh -- $1*  | sort -rg
}

alias g='git'
alias gnp='git --no-pager'

function gj {
  query=${1:-*}
  dir=$(fasd -d $query -Rld | grep "^$(g root)" | head -n 1)
  if [ -n "$dir" ]; then cd $dir; fi
}
alias h='history | less'
alias b='popd'

alias docs='pushd ~/Documents'
alias dls='pushd ~/Downloads'
alias p='pushd ~/Projects'

# stupid: nvim C-H doesn't work
# alias vim='nvim'
alias plug='vim +PlugInstall +qall'
