function ls
  if [ (uname) = 'Darwin' ]
    gls -p -F --color=tty $argv
  else
    command ls -p -F --color=tty $argv
  end
end

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
    echo
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

function cdgr
  cd (command git rev-parse --show-toplevel)
end

function cdg
  set GLOBAL_COLUMNS (math $COLUMNS - 10)
  set PREFIX (command git rev-parse --show-prefix)
  set TOPLEVEL (command git rev-parse --show-toplevel)
  command git ls-files "$TOPLEVEL" --full-name | fzf --query="$PREFIX" --preview-window=top:50% --preview="dirname $TOPLEVEL/{}; echo; fish -c 'set -g GLOBAL_COLUMNS $GLOBAL_COLUMNS; _lsa_color (dirname '$TOPLEVEL/{}')'" | read -l result
  test -z "$result"; and return
  cd (dirname "$TOPLEVEL/$result")
end

function cdgg
  set GLOBAL_COLUMNS (math $COLUMNS - 10)
  set TOPLEVEL (command git rev-parse --show-toplevel)
  find "$TOPLEVEL" -name '.git' -prune -o -type d | string sub -s (string length "$TOPLEVEL++") | fzf --query=(pwd | string sub -s (string length "$TOPLEVEL++")) --preview-window=top:50% --preview="echo $TOPLEVEL/{}; echo; fish -c 'set -g GLOBAL_COLUMNS $GLOBAL_COLUMNS; _lsa_color '$TOPLEVEL/{}''" | read -l result
  test -z "$result"; and return
  cd "$TOPLEVEL/$result"
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

function _lsla_color
  if [ (uname) = 'Darwin' ]
    gls -alpF --color=yes $argv
  else
    command ls --color -al $argv
  end
end

function _lsa_color
  if [ (uname) = 'Darwin' ]
    bash -c "COLUMNS=$GLOBAL_COLUMNS gls -apFC --color=yes $argv"
  else
    bash -c "COLUMNS=$GLOBAL_COLUMNS command ls --color -aC $argv"
  end
end

function _rm_osx_hidden_files
  if [ -d "$argv" ]
    set TARGET_DIRECTORY $argv
  else if [ -f "$argv" ]
    set TARGET_DIRECTORY (dirname $argv)
  else
    return
  end

  set TARGET_DIRECTORY (string replace -r '/$' '' "$TARGET_DIRECTORY")

  command ls -a1 "$TARGET_DIRECTORY" | command grep -E '\._.+?$' | while read -l HIDDEN_FILE
    set BASE_FILE (string replace -r '^\._' '' "$HIDDEN_FILE")
    if [ -f "$TARGET_DIRECTORY/$BASE_FILE" ]
      echo "[_rm_osx_hidden_files]rm $TARGET_DIRECTORY/$HIDDEN_FILE" 1>&2
      rm -f "$TARGET_DIRECTORY/$HIDDEN_FILE"
    end
  end
end
