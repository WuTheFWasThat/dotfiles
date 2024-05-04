# setup:

incomplete notes
all commands ran from root directory

- `./dotty install`
- install zsh (e.g. `brew install zsh zsh-completions` and `chsh -s /bin/zsh`)
  - install oh-my-zsh
    ```
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh
    sh /tmp/omz-install.sh --skip-chsh
    ```

  - install zsh theme:
    `ln -s $(pwd)/my.zsh-theme ~/.oh-my-zsh/themes/jeffwu.zsh-theme`
  - overwrite zshrc:
    `echo "source $(pwd)/zshrc" > ~/.zshrc`

- install fasd
    `cd ~; git clone https://github.com/whjvenyl/fasd.git; cd fasd; make install`
    used to work, but no longer works `brew install fasd` (as of may 2024)
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
      - also put that token in a file at `~/.github_token` for some of my git aliases to work
  - install thefuck (https://github.com/nvbn/thefuck) (e.g. `brew install thefuck`)
  - install icdiff, change gitconfig differ
- very optional:
  - install spacemacs:
    `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
  - install neovim, then
    ```
    mkdir -p $HOME/.config
    ln -s ~/.vim $HOME/.config/nvim
    # sudo pip3 install neovim
    sudo pip3 install pynvim
    ```
  - install [fnm](https://github.com/Schniz/fnm#shell-setup)
    `brew install fnm`
  - install latex
    `brew cask install mactex`

# TODO
- try pv (pipeviewer)?   like command line tqdm
- try https://github.com/eradman/entr instead of watch
