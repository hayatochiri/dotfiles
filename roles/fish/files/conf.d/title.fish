function fish_title
  if [ -n "$GLOBAL_ENV_TITLE" ]
    echo -n "$GLOBAL_ENV_TITLE"
    return
  end

  if [ -n "$GLOBAL_ENV_LOCATION" ]
    echo -n "$GLOBAL_ENV_LOCATION"
  else if [ -z "$SSH_TTY" ]
    echo -n 'local'
  else
    echo -n (hostname)
  end

  echo -n '>'

  set IS_REPOSITORY (command git rev-parse --is-inside-work-tree 2>/dev/null)
  if [ -n "$GLOBAL_ENV_CURRENT" ]
    echo -n "$GLOBAL_ENV_CURRENT"
  else if [ "$IS_REPOSITORY" = 'true' ]
    echo -n (basename (command git rev-parse --show-toplevel))
  else
    echo -n (basename (prompt_pwd))
  end
end

function t
  echo -e "global\nlocation\ncurrent" | fzf --exit-0 --height=1% | read -l result
  switch "$result"
  case 'global'
    read -g GLOBAL_ENV_TITLE
  case 'location'
    read -g GLOBAL_ENV_LOCATION
  case 'current'
    read -g GLOBAL_ENV_CURRENT
  end
end

function title_global
  set -g GLOBAL_ENV_TITLE $argv
end

function title_location
  set -g GLOBAL_ENV_LOCATION $argv
end

function title_current
  set -g GLOBAL_ENV_CURRENT $argv
end

function ssh
  for line in $argv
    if [ -n (echo -n "$line" | grep '@') ]
      sh -c "echo \"\\033]0;$line\\007\""
    end
  end
  command ssh $argv
end
