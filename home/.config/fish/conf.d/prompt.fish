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

  echo -n (_git_highlight_path $TOPLEVEL)
  echo -n " > $BRANCH > "
  echo -n (_highlight_path "/$PREFIX")
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
  #set_color normal
  set_color brgreen
  echo -n $PWDS[-1]

  set_color normal
end
