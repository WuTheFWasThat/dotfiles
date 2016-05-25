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

function sname {             # get session name
    # test if we're in a screen window
    echo $STY | cut -d '.' -f 2
    # tmux display-message -p '#S'
}

function sx {                # attach to session
    local sessionname=$1
    screen -x $sessionname
    # tmux a -t $sessionname
}

function sl {                # list sessions
    screen -ls
    # tmux ls
}

function ss {                # start session
  local sessionname=$1
  if [ -z "$sessionname" ]; then
    echo "Please give your session a name!"
    return 1
  fi
  # NOTE: ems doesn't work here, not sure why
  nohup emacs --daemon=$sessionname &>/dev/null &

  screen -S $sessionname
  # tmux new -s $sessionname
}

function sk {                # kill session
  # default to killing current session
  local sessionname=${1:-$(sname)}
  if [ -z "$sessionname" ]; then
    sl
    echo "Must specifiy which session to kill!"
    return 1
  fi
  emk $sessionname
  screen -S $sessionname -X quit
  # tmux kill-session -t $sessionname
}
