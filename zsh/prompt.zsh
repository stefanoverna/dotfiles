setopt promptsubst

autoload colors && colors
autoload -U promptinit && promptinit
prompt grb

precmd() { _z --add "$(pwd -P)" }

