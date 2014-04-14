alias b="bundle"
alias bi="b install"
alias bo="b open"
alias bs="b show"
alias bu="b update"

alias -g rc="rails console"
alias rs="rails server"
alias rg="rails g"

alias rgco="rg controller"
alias rgmo="rg model"
alias rgmi="rg migration"
alias rgp="rg showcase:presenter"

# to test both up an down migrations
alias rr="rake routes"
alias rdm="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias rdp="rake db:test:prepare"
alias rdmm="rake db:migrate db:test:prepare"
alias -g rdr="rake db:rollback"
alias -g rds="rake db:seed"

alias devlog="tail -f log/development.log"
alias fs="foreman start"
alias fr="foreman run"
alias zs="zeus start"

