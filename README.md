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
- install vim plugins: `vim +PlugInstall +qall`
- optional:
  - install spacemacs
  - install screen/tmux
  - install git 2.3
  - install thefuck
  - install neovim
    ```
    mkdir -p $HOME/.config
    ln -s ~/.vim $HOME/.config/nvim
    sudo pip2 install neovim
    ```

## TODO
  - vim, see vimrc
  - spacemacs
    - explore using layouts to mitigate global buffers issue?
    - find-file-at-point (gf) should automatically choose when there's only one result
      SEE: https://github.com/syl20bnr/spacemacs/issues/4837
    - get python autocomplete working properly: https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/python
    - figure out shell within emacs (https://github.com/syl20bnr/spacemacs/tree/master/layers/shell)
    - make "tab" not bring up helm completion-at-point when there's nothing to complete
    - alternative to minibufexpl
