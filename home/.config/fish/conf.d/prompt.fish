function fish_prompt
  set IS_REPOSITORY (command git rev-parse --is-inside-work-tree 2>/dev/null)

  if [ "$IS_REPOSITORY" = 'true' ]
    _prompt_git
  else
    echo -n (pwd)
  end

  echo -e "\n>"
end

# function fish_right_prompt
#   echo '<hoge'
# end

function _prompt_git
  set TOPLEVEL (command git rev-parse --show-toplevel)
  set PREFIX (command git rev-parse --show-prefix)
  set BRAnCh (command git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  echo -n "$TOPLEVEL > $BRAnCh > $PREFIX"
end
