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
  - set up git aliases like described in answer here:
    https://stackoverflow.com/questions/7275508/is-there-a-way-to-squash-a-number-of-commits-non-interactively
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

  - on remote machines, often useful to install:
    https://github.com/skaji/remote-pbcopy-iterm2

## found to be meh
  - install vmail
    - make a vmailrc from the vmailrc.template
    - install macports if needed
      - add `export PATH=$PATH:/opt/local/bin:/opt/local/sbin` to zshrc
    - sudo env "PATH=$PATH" port install lynx
    - gem install vmail
    - `git clone https://github.com/WuTheFWasThat/vmail.git`
      or `git clone git@github.com:WuTheFWasThat/vmail.git`
    - replace stuff with wuthefwasthat vmail
        INSTALLED_VMAIL_PATH=/usr/local/lib/ruby/gems/2.3.0/gems/vmail-2.9.8/
        NEW_VMAIL_PATH=~/Documents/vmail
        ```
        rm $INSTALLED_VMAIL_PATH/vmail.vim
        rm $INSTALLED_VMAIL_PATH/vmail.rb
        ln -s -f $NEW_VMAIL_PATH/vmail.vim $INSTALLED_VMAIL_PATH/vmail.vim
        ln -s -f $NEW_VMAIL_PATH/vmail.rb $INSTALLED_VMAIL_PATH/vmail.rb
        ```
