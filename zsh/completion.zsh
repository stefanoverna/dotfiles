# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# sequences of slashes in filename paths (for example in ‘foo//bar’) will be treated as a single slash
zstyle ':completion:*' squeeze-slashes true

