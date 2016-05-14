autoload -Uz vcs_info

red="$FG[001]"
green="$FG[002]"
yellow="$FG[003]"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true

zstyle ':vcs_info:git:*' stagedstr "${yellow}✘"
zstyle ':vcs_info:git:*' unstagedstr "${red}✘"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "(%s) %b%m %7.7i %c%u"
zstyle ':vcs_info:git*' actionformats "(%s|%a) %b%m %7.7i %c%u"
zstyle ':vcs_info:git*+set-message:*' hooks git-st
main_color='%B%F{blue}'

# Show remote ref name and number of commits ahead-of or behind
function +vi-git-st() {
    local ahead behind remote
    local -a gitstatus

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        # for git prior to 1.7
        # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | xargs)
        (( $ahead )) && gitstatus+=( "${yellow}+${ahead}${main_color}" )

        # for git prior to 1.7
        # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | xargs)
        (( $behind )) && gitstatus+=( "${red}-${behind}${main_color}" )

        if [ -z "$gitstatus" ]; then gitstatus+=( "${green}up-to-date${main_color}" ); fi

        hook_com[branch]="${hook_com[branch]} [${remote} ${(j:/:)gitstatus}]"
    fi
}

# http://eseth.org/2010/git-in-zsh.html
theme_precmd () {
    vcs_info
}

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=" $(($SECONDS - $timer))s
"
    unset timer
  else
    timer_show=""
  fi
}

# useful chars: » ● ✔ ✘
local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
setopt prompt_subst
PROMPT=$'${ret_status}%(?,, %{${fg_bold[red]}%}[%?])${timer_show}%{$reset_color%} %B%F{blue}%c %B%F{blue}# %{$reset_color%}'
RPROMPT='%B%F{blue}${vcs_info_msg_0_} %{$reset_color%}[%D{%L:%M:%S %p}]'

TMOUT=1
TRAPALRM() {
  # don't reset prompt if a command is being typed, since copy/paste becomes impossible
  if [ -z "$BUFFER" ]; then
    zle reset-prompt
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
