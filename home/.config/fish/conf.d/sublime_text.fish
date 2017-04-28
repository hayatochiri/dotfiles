function subl2
  set git_root (git rev-parse --show-toplevel)
  /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl --command "sublimerge_diff {\"left\":\"$argv[1]\",\"right\":\"$git_root/$argv[2]\"}"

  # Sublime Text 2 で一時ファイルを開く前に git difftool が一時ファイルを削除してしまうのでその対策
  sleep 0.1
end
