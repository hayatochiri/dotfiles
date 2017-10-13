set git_fzf_binds 'ctrl-v:page-down,ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-v:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up,alt-d:preview-page-down,alt-u:preview-page-up,alt-j:preview-down,alt-n:preview-down,alt-k:preview-up,alt-p:preview-up,alt-enter:toggle-preview'

function rake
  if [ (count $argv) = 0 ]
    command rake -T | fzf --select-1 --ansi --bind="$git_fzf_binds" --expect=ctrl-c | while read -l r
      set result $result $r
    end
    if [ $result[1] = 'ctrl-c' ]
      return
    end
    set task (echo $result[2] | awk '{print $2;}')
    command rake $task
  else
    command rake $argv
  end
end
