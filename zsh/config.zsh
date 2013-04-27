if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

# http://geoff.greer.fm/lscolors/
export LSCOLORS="gxcxhxfxbxegedabagacad"
export CLICOLOR=true

fpath=($ZSH/zsh/functions $fpath)

autoload -U zmv
autoload -U $ZSH/zsh/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt AUTOCD

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

# ZLE is the ZSH's component which interact with the user. It receives all keyboard inputs.
# All actions in the editor are performed by ‘widgets’. A widget’s job is simply to perform
# some small action. The ZLE commands that key sequences in keymaps are bound to are in fact
# widgets. Widgets can be user-defined or built in.

# Protip: on a terminal use Ctrl+V and then a keystroke to know the bindkey to write here.

# Use emacs-style zsh bindings
bindkey -e

# Avoid jumping over an entire /path/location, rather than to each word separated by a '/'
export WORDCHARS='*?_[]~=&;!#$%^(){}'
# Ctrl + Left
bindkey '^[^[[D' backward-word
# Ctrl + Right
bindkey '^[^[[C' forward-word
# Alt + Left
bindkey '^[[1;9D' beginning-of-line
# Alt + Right
bindkey '^[[1;9C' end-of-line

# allows to glob-search like ssh*.com
bindkey "\C-r" history-incremental-pattern-search-backward
# up and down finds commands starting with the typed thingie
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Canc deletes a char
bindkey '^[[3~' delete-char
# Backspace deletes the char backward
bindkey '^?' backward-delete-char

# Ctrl + B deletes backward word
bindkey  '^B' backward-delete-word
# Ctrl + W deletes word
bindkey  '^W' delete-word

