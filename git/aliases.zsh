alias g='git'

alias gf='git fetch --prune'
alias gff='git fetch --prune --all'

alias gl='git pull'
alias gup='git pull-rebase'
alias gm='git merge'

alias ga='git add'
alias gaa='git add-remove-all'
alias gap='git add-interactive'

alias gp='git push'

alias gc='git commit -v'
alias gc!='git commit --amend -v --date="$(date)"'

alias grc='git reset HEAD^'
alias grh='git reset HEAD --hard'
alias grmu='git remove-untracked'

alias gco='git checkout'
alias gcm='git checkout master'

alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'

alias grb='git rebase'
alias grbi='git rebase-interactive'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

alias gb='git branch'
alias gbb='git branch -a'
alias gbrrm='git push --delete'
alias gblrm='git branch -D'

alias gcp='git cherry-pick'

alias glg='git nice-oneline-log'
alias glgg='git nice-detail-log'

alias gs='git status-diff'
alias gst='git status'
alias gd='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'

function gbd() {
  git diff --ignore-space-at-eol -b -w --ignore-blank-lines $(git merge-base $1 HEAD) $1
}

