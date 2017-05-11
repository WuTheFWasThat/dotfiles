# setup:

incomplete notes
all commands ran from root directory

- `./dotty install`
- install zsh (e.g. `brew install zsh zsh-completions` and `chsh -s /bin/zsh`)
  - install oh-my-zsh
    `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
  - install zsh theme:
    `ln -s $(pwd)/my.zsh-theme ~/.oh-my-zsh/themes/jeffwu.zsh-theme`
  - add to zshrc:
    `echo "source $(pwd)/zshrc" >> ~/.zshrc`
- install fasd (e.g. `brew install fasd`)
- install fzf (e.g. `brew install fzf`)
- make sure vim is 7.4+, preferably 8+ (e.g. `brew install vim`)
- install vim plugins: `vim +PlugInstall +qall`
- optional:
  - set iterm colors, if appropriate
  - install spacemacs:
    `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
  - install screen/tmux
  - install git 2.3+
  - install hub (git wrapper) `brew install hub`
  - install thefuck (https://github.com/nvbn/thefuck) (e.g. `brew install thefuck`)
  - install neovim, then
    ```
    mkdir -p $HOME/.config
    ln -s ~/.vim $HOME/.config/nvim
    sudo pip2 install neovim
    ```
  - install icdiff, change gitconfig differ
  - install nvm
    `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash`

## TODO
  - make dotty link zsh-theme, takes A -> B in rcfile
  - vim, see .vimrc
  - spacemacs, see .spacemacs
  - vimperator, see .vimperatorrc
  - for neovim
    - https://github.com/neomake/neomake

      let g:neomake_tsc_maker = { 'exe': 'tsc', 'args': [] }
      autocmd BufEnter,BufWritePost *.ts Neomake! tsc

      let g:neomake_cargo_maker = { 'exe': 'cargo', 'args': [] }
      autocmd BufEnter,BufWritePost *.rs Neomake! cargo

  - alias pip to pipenv
    https://github.com/kennethreitz/pipenv
