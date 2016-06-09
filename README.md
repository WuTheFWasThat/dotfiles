# setup:

incomplete notes

- install zsh
  - put zsh theme in right place
- set iterm colors, if appropriate
- ghar
  - install ghar
  - in the repo, `ghar install`
- install fasd (e.g. `brew install fasd`)
- install fzf (e.g. `brew install fzf`)
- vim setup
  - install plugins: `vim +PlugInstall +qall`
  - install YouCompleteMe: `cd .vim/plugged/YouCompleteMe && ./install.py`
- optional:
  - install spacemacs
  - install screen/tmux
  - install git 2.3
  - install ctags: e.g. `apt-get install exuberant-ctags` or `brew install ctags`

## TODO
  - vim
    - figgure out snips (replace insert mode language specific macros)
    - figure out folding
    - figure out good shell? (dunno if valuable)
  - spacemacs
    - explore using layouts to mitigate global buffers issue?
    - find-file-at-point (gf) should automatically choose when there's only one result
      SEE: https://github.com/syl20bnr/spacemacs/issues/4837
    - get python autocomplete working properly: https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/python
    - figure out shell within emacs (https://github.com/syl20bnr/spacemacs/tree/master/layers/shell)
    - make "tab" not bring up helm completion-at-point when there's nothing to complete
    - alternative to minibufexpl
