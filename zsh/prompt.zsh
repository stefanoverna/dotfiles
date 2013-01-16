autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_wip() {
  if [[ `git log --format="%s" -1 | tr '[:upper:]' '[:lower:]'` == "wip" ]]
  then
    echo "— %{$fg_bold[magenta]%}WIP!%{$reset_color%}"
  else
    echo ""
  fi
}

git_dirty() {
  st=$(git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit, working directory clean" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)!%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[blue]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
    echo "%{$fg_bold[green]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
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

export PROMPT=$'\n$(rb_prompt) in $(directory_name) $(git_dirty)$(need_push)$(git_wip)\n$(pomodoro) '
set_prompt () {
  export RPROMPT=""
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  _z --add "$(pwd -P)"
  set_prompt
}
