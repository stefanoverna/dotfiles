function r() {
  if [ $# -eq 0 ]; then
    redpomo pull
  else
    redpomo $*
  fi
}
