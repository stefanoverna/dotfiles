compdef '_files -W $PROJECTS -/' c
compdef '_files -W $PROJECTS -/' v
compdef '_files -W ~ -/' h

# zsh tab completion
_z_zsh_tab_completion() {
  local compl
  read -l compl
  reply=(${(f)"$(_z --complete "$compl")"})
}
compctl -U -K _z_zsh_tab_completion z
