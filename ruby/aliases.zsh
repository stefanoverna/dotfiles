alias b="bundle"
alias bi="b install --binstubs=bin/stubs"

alias rc="rails console"
alias rs="rails server"
alias rg="rails g"

alias rgco="rg controller"
alias rgmo="rg model"
alias rgmi="rg migration"
alias rgp="rg showcase:presenter"

# to test both up an down migrations
alias rdm="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias rdr="rake db:rollback"
alias rds="rake db:seed"

alias devlog="tail -f log/development.log"

