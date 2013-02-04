autoload colors && colors

git_wip() {
  st=$(git log --format="%s" -1 | tr '[:upper:]' '[:lower:]')
  if [[ $st == "wip" ]]; then
    echo "— %{$fg_bold[magenta]%}WIP!%{$reset_color%}"
  else
    echo ""
  fi
}

git_branch() {
  ref=$(git symbolic-ref HEAD)
  branch="${ref#refs/heads/}"
  st=$(git diff --quiet && git diff --cached --quiet && test -z "$(git ls-files --others --exclude-standard)")
  if test "$?" = 0; then
    echo "%{$fg_bold[green]%}$branch%{$reset_color%}"
  else
    echo "%{$fg_bold[red]%}$branch!%{$reset_color%}"
  fi
}

git_need_push () {
  has_upstream=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
  if [ -n "$has_upstream" ]; then
    st=$(git cherry -v @{upstream})
    if [[ $st == "" ]]; then
      echo " "
    else
      echo " with %{$fg_bold[blue]%}unpushed%{$reset_color%} "
    fi
  fi
}

is_git_repo() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

git_infos() {
  if is_git_repo; then
    echo "on $(git_branch)$(git_need_push)$(git_wip)"
  fi
}

rbenv_infos() {
  if $(which rbenv &> /dev/null); then
    version=$(rbenv version | awk '{print $1}')
    gemset=$(rbenv gemset active 2&>/dev/null | head -n1)
    if [[ "$gemset" != "" ]]; then
      gemset="%{$fg_bold[yellow]%} ($gemset)%{$reset_color%}"
    fi
    echo "%{$fg_bold[green]%}$version$gemset%{$reset_color%}"
  fi
}

pomodoro(){
  current_day_of_week=$(date +'%u')
  (( time = `date +'%k'` * 60 + `date +'%M'` ))
  pomodoro_file=~/.current_pomodoro
  if [[ ! ( -a $pomodoro_file ) && ( $current_day_of_week -le 5 ) && ( $time -ge 540 ) && ( $time -le 1080) ]]; then
    echo "\x1b[5m%{$fg_bold[red]%}⚡%{$reset_color%}\x1b[25m"
  else
    echo "%{$fg[green]%}›%{$reset_color%}"
  fi
}

directory_name(){
  echo "%{$fg_bold[blue]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(rbenv_infos) in $(directory_name) $(git_infos)\n$(pomodoro) '
set_prompt () {
  export RPROMPT=""
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  _z --add "$(pwd -P)"
  set_prompt
}
