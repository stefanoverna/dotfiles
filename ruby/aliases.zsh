alias b="bundle"
alias bi="b install --binstubs=bin/stubs"
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
alias rdm="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias -g rdmm="rake db:migrate"
alias -g rdr="rake db:rollback"
alias -g rds="rake db:seed"

alias devlog="tail -f log/development.log"
alias fs="foreman start"

