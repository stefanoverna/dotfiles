function t() {
  if [ $# -eq 0 ]; then
    grc todo.sh -p pv
  else
    grc todo.sh -p $*
  fi
}
