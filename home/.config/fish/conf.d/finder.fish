function cd
  if [ -n "$argv" ]
    builtin cd $argv
    return
  end
  while true
    clear
    ls -a
    _dirs | fzf --height 5% --border --exit-0 | read -l result
    switch "$result"
    case '.'
      return
    case ''
      return
    case '*'
      builtin cd $result
    end
  end
end

# unlimited cd
function ucd
  if [ -z "$argv" ]
    set argv '.'
  end
  find $argv -type d 2>/dev/null | fzf --exit-0 | read -l result
  if [ -z "$result" ]
    return
  end
  builtin cd $result
end

function _dirs
  echo '.'
  echo '..'
  find . -maxdepth 1 -type d 2>/dev/null | grep -v '^\.$'
  find / -maxdepth 1 -type d 2>/dev/null
end
