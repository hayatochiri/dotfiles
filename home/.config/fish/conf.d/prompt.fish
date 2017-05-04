function fish_prompt
  set IS_REPOSITORY (command git rev-parse --is-inside-work-tree 2>/dev/null)
end

# function fish_right_prompt
#   echo '<hoge'
# end
