_z_zsh_tab_completion() {
  local compl
  read -l compl
  reply=(${(f)"$(_z --complete "$compl")"})
}

compctl -U -K _z_zsh_tab_completion z

