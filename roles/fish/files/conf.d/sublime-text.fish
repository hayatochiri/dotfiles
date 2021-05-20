function subl2
  set git_root (git rev-parse --show-toplevel)
  if [ (uname) = 'Darwin' ]
    /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl --command "sublimerge_diff {\"left\":\"$argv[1]\",\"right\":\"$git_root/$argv[2]\"}"

    # Sublime Text 2 で一時ファイルを開く前に git difftool が一時ファイルを削除してしまうのでその対策
    sleep 1
  else
    vimdiff $argv[1] "$git_root/$argv[2]"
  end
end

# merge tool?
# http://www.sublimerge.com/sm2/docs/vcs-integration.html#command-templates-diff-tool-2-way
function subl3
  echo $argv[2]
  set git_root (git rev-parse --show-toplevel)
  if [ (uname) = 'Darwin' ]
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n --wait "$argv[1]" "$argv[2]" --command "sublimelinter_disable_linting" --command "sublimerge_diff_views {\"left_read_only\": true, \"right_read_only\": false}"
  else
    vimdiff $argv[1] "$git_root/$argv[2]"
  end
end

function subl3_merge
  set git_root (git rev-parse --show-toplevel)
  if [ (uname) = 'Darwin' ]
    s $argv[4]
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n --wait "$argv[1]" "$argv[2]" "$argv[3]" "$argv[4]" --command "sublimelinter_disable_linting" --command "sublimerge_diff_views"
  end
end

if [ (uname) = 'Darwin' ]
  function s
    for f in $argv
      open -a 'Sublime Text.app' $f
    end
  end
  complete -c s -w less
else
  function s
    for f in $argv
      set FULL_PATH (readlink -f $f | string sub -s 2 | string split '/' | tac | string join ' < ')
      set BASENAME (basename $f)
      command rsub --name "$FULL_PATH * $BASENAME" $f
    end
  end
end
