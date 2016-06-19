#####
# emacs stuff
#####

function eml {
  ps aux | grep 'emacs --daemon' | grep -v grep
}

function ems {
  local name=$1
  if [ -n "$name" ]; then
    emacs --daemon=$name
  else
    emacs --daemon
  fi
}

function emx {
  local name=$1
  shift
  if [ -n "$name" ]; then
    emacsclient -c -s $name $@
  else
    emacsclient -c $@
  fi
}

function emk {
  local name=$1
  if [ -n "$name" ]; then
    line=$(ps aux | grep "emacs --daemon=$name" | grep -v grep | head -n 1)
  else
    line=$(ps aux | grep 'emacs --daemon$' | grep -v grep | head -n 1)
  fi
  pid=$(echo $line | awk '{ print $2 }')
  kill $pid
}

function emr {
  local name=$1
  emk $name
  ems $name
}

function em {
  sessionname=$(sname)

  if [ -n "$sessionname" ]; then
    emx $sessionname $@
  else
    emx '' $@
  fi
}

################################################################################
# session management (via gnu screen or tmux)
################################################################################

use_tmux=true

function sname {             # get session name
    if [ "$use_tmux" = true ] ; then
      tmux display-message -p '#S'
    else
      echo $STY | cut -d '.' -f 2
    fi
}

function sx {                # attach to session
    local sessionname=$1
    if [ "$use_tmux" = true ] ; then
      tmux a -t $sessionname
    else
      screen -x $sessionname
    fi
}

function sl {                # list sessions
    if [ "$use_tmux" = true ] ; then
      tmux ls
    else
      screen -ls
    fi
}

function ss {                # start session
  local sessionname=$1
  if [ -z "$sessionname" ]; then
    echo "Please give your session a name!"
    return 1
  fi
  # start corresponding emacs daemon
  # NOTE: ems doesn't work here, not sure why
  # nohup emacs --daemon=$sessionname &>/dev/null &

  if [ "$use_tmux" = true ] ; then
    tmux new -s $sessionname
  else
    screen -S $sessionname
  fi
}

function sk {                # kill session
  # default to killing current session
  local sessionname=${1:-$(sname)}
  if [ -z "$sessionname" ]; then
    sl
    echo "Must specifiy which session to kill!"
    return 1
  fi
  # kill corresponding emacs session
  # emk $sessionname

  if [ "$use_tmux" = true ] ; then
    tmux kill-session -t $sessionname
  else
    screen -S $sessionname -X quit
  fi
}
