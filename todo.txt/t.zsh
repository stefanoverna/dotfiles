function t() {
  if [ $# -eq 0 ]; then
    grc todo.sh pv
  else
    grc todo.sh $*
  fi
}
