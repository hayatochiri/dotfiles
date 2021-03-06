set fish_prompt_pwd_dir_length 3

function show_colors
  set COLORS (string split ' ' 'black red green yellow blue magenta cyan white brblack brred brgreen bryellow brblue brmagenta brcyan brwhite')
  set_color normal
  echo -n 'Normal: '; for c in $COLORS; set_color        $c; echo -n "$c "; end; echo
  set_color normal
  echo -n 'Bold  : '; for c in $COLORS; set_color --bold $c; echo -n "$c "; end; echo
end

function fish_prompt
  set STATUS $status
  set IS_REPOSITORY (command git rev-parse --is-inside-work-tree 2>/dev/null)

  tput cup $LINES 0

  echo -n '╦═══ '

  set_color brcyan; echo -n (whoami)
  set_color normal; echo -n '@'
  set_color --bold brblack; echo -n (hostname)
  set_color normal

  test -e /etc/DOTFILES_EMULATOR; and echo -n '(emulator)'
  echo -n ' > '

  if [ "$IS_REPOSITORY" = 'true' ]
    _prompt_git
  else
    echo -n (_highlight_path (prompt_pwd))
  end

  echo -e -n "\n╚═ "

  test $STATUS != 0; and set_color red
  if [ (whoami) = 'root' ]
    echo -n '# '
  else
    echo -n '$ '
  end

  set_color normal
  echo
end

function fish_right_prompt
  set_color brblack
  [ -z "$CMD_DURATION" -o "$CMD_DURATION" -eq 0 ]; or echo -n "$CMD_DURATION ms < "
  echo (date "+%c")
  set_color normal
end

function _prompt_git
  set CURRENT (command pwd)
  set TOPLEVEL (builtin cd (command git rev-parse --show-toplevel); and prompt_pwd)
  builtin cd $CURRENT
  set PREFIX (string sub -s 2 (command git rev-parse --show-prefix | rev) | rev)
  set BRANCH (command git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  set STATUS (_get_git_status)
  set STASHES_NUMBER (command git stash list | wc -l | string trim)

  echo -n (_git_highlight_path $TOPLEVEL)' > '

  if [ "$STASHES_NUMBER" != '0' ]
    set_color --bold brblack
    echo -n "{$STASHES_NUMBER}"
  end

  set_color normal
  switch $STATUS
    case 'clean'     ; set_color green
    case 'staging'   ; set_color yellow
    case 'unstaging' ; set_color red
    case 'nfs'       ; set_color --bold brblack
  end
  echo -n $BRANCH

  if [ "$STATUS" = 'staging' ]
    set_color brblack
    echo -n ' signer '
    set_color normal
    echo -n (command git config user.name)
  end

  set_color normal
  echo -n ' > '(_highlight_path "/$PREFIX")
end

function _get_git_status
  set IS_NFS (pwd | grep '/nfs/')
  if [ -n "$IS_NFS" ]
    echo 'nfs'
    return
  end

  set STATUS 'clean'
  command git status --porcelain | while read -l r
    set STAGING (string sub -s 1 -l 1 "$r")
    set UNSTAGING (string sub -s 2 -l 1 "$r")
    test "$STAGING" != 'U'; and test "$STAGING" != '?'; and test "$STAGING" != ' '; and set STATUS 'staging'; and break
    set STATUS 'unstaging'
  end
  echo $STATUS
end

function _highlight_path
  set IS_FIRST 'TRUE'
  for i in (string split '/' "$argv")
    if [ "$IS_FIRST" = 'TRUE' ]
      set -u IS_FIRST
    else
      set_color brblack
      echo -n '/'
    end
    set_color --bold blue
    echo -n $i
  end
  set_color normal
end

function _git_highlight_path
  set IS_FIRST 'TRUE'
  set PWDS (string split '/' "$argv")
  for i in $PWDS[1..-2]
    if [ "$IS_FIRST" = 'TRUE' ]
      set -u IS_FIRST
    else
      set_color brblack
      echo -n '/'
    end
    set_color --bold blue
    echo -n $i
  end

  set_color brblack
  echo -n '/'
  set_color normal
  set_color cyan
  echo -n $PWDS[-1]

  set_color normal
end
