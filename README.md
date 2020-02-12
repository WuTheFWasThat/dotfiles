# setup:

incomplete notes
all commands ran from root directory

- `./dotty install`
- install zsh (e.g. `brew install zsh zsh-completions` and `chsh -s /bin/zsh`)
  - install oh-my-zsh
    `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
    If using in a script (see https://github.com/robbyrussell/oh-my-zsh/issues/5873):
    `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"`
  - install zsh theme:
    `ln -s $(pwd)/my.zsh-theme ~/.oh-my-zsh/themes/jeffwu.zsh-theme`
  - add to zshrc:
    `echo "source $(pwd)/zshrc" >> ~/.zshrc`
- install fasd (e.g. `brew install fasd`)
- make sure vim is 7.4+, preferably 8+ (e.g. `brew install vim`)
- install vim plugins: `vim +PlugInstall +qall`
  - this should install fzf (if not, do e.g. `brew install fzf`)
- install `Ag` (https://github.com/ggreer/the_silver_searcher):
  - `brew install the_silver_searcher`

- optional
  - set iterm colors, if appropriate
  - install screen/tmux (e.g. `brew install tmux`)
  - install git 2.3+
  - install hub (git wrapper) `brew install hub`
    - for `git pr`, do:
      - https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/
      - Then add to `~/.config/hub`:
        ```
        ---
        github.com:
        - protocol: https
          user: jeffwu
          oauth_token: YOURTOKEN
        ```
  - install thefuck (https://github.com/nvbn/thefuck) (e.g. `brew install thefuck`)
  - install icdiff, change gitconfig differ
- very optional:
  - install spacemacs:
    `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
  - install neovim, then
    ```
    mkdir -p $HOME/.config
    ln -s ~/.vim $HOME/.config/nvim
    sudo pip2 install neovim
    ```
  - install nvm
    `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash`
  - install latex
    `brew cask install mactex`
