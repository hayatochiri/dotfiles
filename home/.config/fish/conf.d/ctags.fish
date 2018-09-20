function ctags
  set GIT_TOPLEVEL_DIR (command git rev-parse --show-toplevel)
  eval "command git ls-files; command git ls-files --others --exclude-standard" | command ctags --tag-relative -L - -f "$GIT_TOPLEVEL_DIR/.tags"
end
