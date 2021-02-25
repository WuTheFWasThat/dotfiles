# python stuff
export PYTHONPATH=.:/usr/local/lib/python
alias py='python'
alias py3='python3'
alias ipy='ipython'

function list_space {
  du -sh -- $1*  | sort -rg
}

function tmux_reload {
  tmux source-file ~/.tmux.conf
}

alias o='open'
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

alias pypibump='rm -rf dist build *.egg-info && python3 setup.py sdist bdist_wheel && python3 -m twine upload dist/*'
