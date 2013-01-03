autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
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
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
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

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo_next(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "⚑ $todos"
    else
      echo ""
    fi
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

export PROMPT=$'\n$(rb_prompt) in $(directory_name) $(git_dirty)$(need_push)\n$(pomodoro) '
set_prompt () {
  export RPROMPT="%{$fg[blue]%}$(todo_next)%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  _z --add "$(pwd -P)"
  set_prompt
}
