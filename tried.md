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
