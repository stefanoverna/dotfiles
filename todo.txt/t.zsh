function t() {
  if [ $# -eq 0 ]; then
    grc todo.sh -p pv | redpomo_add_urls
  else
    grc todo.sh -p $* | redpomo_add_urls
  fi
}
