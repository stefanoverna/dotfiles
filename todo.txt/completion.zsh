function _t() {
  setopt localoptions braceccl

  local expl curcontext="$curcontext" state line pri nextstate item
  local -a cmdlist itemlist match mbegin mend
  integer NORMARG

  _arguments -s -n : \
    '-d[alternate config file]:config file:_files' \
    '-f[force, no confirmation]' \
    '-h[display help]' \
    '-p[plain mode, no colours]' \
    '-v[verbose mode, confirmation messages]' \
    '-V[display version etc.]' \
    '1:command:->commands' \
    '*:arguments:->arguments' && return 0

  local projmsg="context or project"
  local txtmsg="text with contexts or projects"

  # Skip "command" as command prefix if words after
  if [[ $words[NORMARG] == command && NORMARG -lt CURRENT ]]; then
    (( NORMARG++ ))
  fi

  case $state in
    (commands)
    cmdlist=(
      "add:add TODO ITEM to todo.txt."
      "addm:add TODO ITEMs, one per line, to todo.txt."
      "addto:add text to file (not item)"
      "append:adds to item on line NUMBER the text TEXT."
      "archive:moves done items from todo.txt to done.txt."
      "command:run internal commands only"
      "del:deletes the item on line NUMBER in todo.txt."
      "depri:remove prioritization from item"
      "do:marks item on line NUMBER as done in todo.txt."
      "help:display help"
      "list:displays all todo items containing TERM(s), sorted by priority."
      "listall:displays items including done ones containing TERM(s)"
      "projectview:displays items including done ones containing TERM(s), divided per project"
      "listcon:list all contexts"
      "listfile:display all files in .todo directory"
      "listpri:displays all items prioritized at PRIORITY."
      "move:move item between files"
      "prepend:adds to the beginning of the item on line NUMBER text TEXT."
      "pri:adds or replace in NUMBER the priority PRIORITY (upper case letter)."
      "replace:replace in NUMBER the TEXT."
      "remdup:remove exact duplicates from todo.txt."
      "report:adds the number of open and done items to report.txt."
    )
    _describe -t todo-commands 't command' cmdlist
    ;;

    (arguments)
    case $words[NORMARG] in
      (append|command|del|move|mv|prepend|pri|replace|rm)
      if (( NORMARG == CURRENT - 1 )); then
        nextstate=item
      else
        case $words[NORMARG] in
    (pri)
    nextstate=pri
    ;;
    (append|prepend)
    nextstate=proj
    ;;
    (move|mv)
    nextstate=file
    ;;
    (replace)
    item=${words[CURRENT-1]##0##}
    compadd -Q -- "${(qq)$(todo.sh -p list "^[ 0]*$item " | sed '/^--/,$d')##<-> (\([A-Z]\) |)}"
    ;;
        esac
      fi
      ;;

      (depri|do|dp)
      nextstate=item
      ;;

      (a|add|addm|list|ls|listall|lsa|pv|projectview)
      nextstate=proj
      ;;

      (addto)
      if (( NORMARG == CURRENT - 1 )); then
        nextstate=file
      else
        nexstate=proj
      fi
      ;;

      (listfile|lf)
      if (( NORMARG == CURRENT -1 )); then
        nextstate=file
      else
        _message "Term to search file for"
      fi
      ;;

      (listpri|lsp)
      nextstate=pri
      ;;

      (*)
      return 1
      ;;
    esac
    ;;
  esac

  case $nextstate in
    (file)
    _path_files -W ~/.todo
    ;;

    (item)
    itemlist=(${${(M)${(f)"$(todo.sh -p list | sed '/^--/,$d')"}##<-> *}/(#b)(<->) (*)/${match[1]}:${match[2]}})
    _describe -t todo-items 'todo item' itemlist
    ;;

    (pri)
    if [[ $words[CURRENT] = (|[A-Z]) ]]; then
      if [[ $words[CURRENT] = (|Z) ]]; then
        pri=A
      else
        # cycle priority
        pri=$words[CURRENT]
        pri=${(#)$(( #pri + 1 ))}
      fi
      _wanted priority expl 'priority' compadd -U -S '' -- $pri
    else
      _wanted priority expl 'priority' compadd {A-Z}
    fi
    ;;

    (proj)
    # This completes stuff beginning with + (projects) or @ (contexts);
    # these are todo.sh conventions.
    if [[ ! -prefix + && ! -prefix @ ]]; then
      projmsg=$txtmsg
    fi
    # In case there are quotes, ignore anything up to whitespace before
    # the + or @ (which may not even be there yet).
    compset -P '*[[:space:]]'
    _wanted search expl $projmsg \
      compadd $(todo.sh lsprj) $(todo.sh lsc)
    ;;
  esac
}

 compdef _t t
