# todo.sh: https://github.com/ginatrapani/todo.txt-cli
function t() {
  if [ $# -eq 0 ]; then
    grc todo.sh pv
  else
    grc todo.sh $*
  fi
}

alias n="t ls +next"
