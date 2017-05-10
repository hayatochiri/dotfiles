set fish_prompt_pwd_dir_length 3

function fish_prompt
  set IS_REPOSITORY (command git rev-parse --is-inside-work-tree 2>/dev/null)

  # TODO: git statuses
  # TODO: short path(e.g. /path/to/dir -> /p/t/dir)
  # TODO: color
  # TODO: command status
  # TODO: command exec time

  echo -n '╦═══ '
  echo -n (whoami)@(hostname)
  test -e /etc/DOTFILES_EMULATOR; and echo -n '(emulator)'
  echo -n ' > '

  if [ "$IS_REPOSITORY" = 'true' ]
    _prompt_git
  else
    echo -n (_highlight_path (prompt_pwd))
  end

  echo -e -n "\n╚═ "
  if [ (whoami) = 'root' ]
    echo -n '# '
  else
    echo -n '$ '
  end

  echo
end

# function fish_right_prompt
#   echo '<hoge'
# end

function _prompt_git
  set CURRENT (command pwd)
  set TOPLEVEL (builtin cd (command git rev-parse --show-toplevel); and prompt_pwd)
  builtin cd $CURRENT
  set PREFIX (string sub -s 2 (command git rev-parse --show-prefix | rev) | rev)
  set BRANCH (command git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  echo -n (_highlight_path $TOPLEVEL)
  echo -n " > $BRANCH > "
  echo -n (_highlight_path $PREFIX)
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
    set_color normal
    echo -n $i
  end
end
