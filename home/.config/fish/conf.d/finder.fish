function _up_dir
  for i in (seq $argv[1])
    builtin cd ..
  end
  ls
end
function ..          ; _up_dir 1 ; end
function ...         ; _up_dir 2 ; end
function ....        ; _up_dir 3 ; end
function .....       ; _up_dir 4 ; end
function ......      ; _up_dir 5 ; end
function .......     ; _up_dir 6 ; end
function ........    ; _up_dir 7 ; end
function .........   ; _up_dir 8 ; end
function ..........  ; _up_dir 9 ; end
function ........... ; _up_dir 10; end

function cd
  if [ -n "$argv" ]
    builtin cd $argv
    ls -a
    return
  end
  while true
    clear
    ls -a
    _dirs | fzf --height 50% --border --exit-0 | read -l result
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
  set CURRENT_PATH (pwd)
  find / -type d 2>/dev/null | fzf --exit-0 --query="$CURRENT_PATH" | read -l result
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
