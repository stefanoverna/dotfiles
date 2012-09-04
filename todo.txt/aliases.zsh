alias n="t ls +next"

redpomo_add_urls() {
  cat - | sed -E "s/^(.*#([0-9]+).*@cantiere.*$)/\1 $(tput setaf 0) — https:\/\/project.cantierecreativo.net\/issues\/\2/ ; s/^(.*#([0-9]+).*@welaika.*$)/\1 $(tput setaf 0) — http:\/\/code.welaika.com\/issues\/\2/ ; s/^(.*#([0-9]+).*@agavee.*$)/\1 $(tput setaf 0) — http:\/\/projects.agavee.com\/issues\/\2/"
}
