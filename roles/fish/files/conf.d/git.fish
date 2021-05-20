set git_fzf_binds 'ctrl-v:page-down,ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-v:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up,alt-d:preview-page-down,alt-u:preview-page-up,alt-j:preview-down,alt-n:preview-down,alt-k:preview-up,alt-p:preview-up,alt-enter:toggle-preview'

function _git_config
  if [ (uname) = 'Darwin' ]
    # TODO: Sublime Text3で編集を確定できないバグの修正
    set CORE_EDITOR "/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w"
  else
    set CORE_EDITOR vim
  end
  git config --global core.editor $CORE_EDITOR
  git config --global core.quotepath false
  git config --global core.pager 'nkf -w | LESSCHARSET=utf-8 LESS=-RSX less'
  git config --global core.excludesfile ~/.gitignore_global

  git config --global ghq.root ~/.ghq/src

  git config --global color.ui true

  git config --global color.diff.meta yellow

  git config --global alias.cached 'diff --cached'

  git config --global diff.tool subl2

  git config --global difftool.subl2.cmd 'fish -c "subl2 $LOCAL $REMOTE"'

  git config --global merge.tool subl3_merge

  git config --global mergetool.subl3_merge.cmd 'fish -c "subl3_merge $REMOTE $BASE $LOCAL $MERGED"'

  git config --global rebase.autostash true

  git config --global pager.log 'diff-highlight | less'
  git config --global pager.show 'diff-highlight | less'
  git config --global pager.diff 'diff-highlight | less'
end
_git_config

function foresta
  git-foresta --graph-symbol-commit='o' --graph-symbol-merge='x' --graph-symbol-root='0' --graph-symbol-tip='@' $argv
end

function gg-less
  if [ (count $argv) = 0 ]
    foresta --branches --remotes --tags | less -RSX
  else
    foresta $argv | less -RSX
  end
  return 0
end

function gg
  if [ (count $argv) = 0 ]
    foresta --branches --remotes --tags | fzf --ansi --reverse --no-sort --preview='test -n (echo {1} | grep -E "^[0-9a-f]+\$"); and command git show --color --pretty=fuller {1}' --bind="$git_fzf_binds,enter:execute(git show --color --pretty=fuller {1} | diff-highlight | less -RSX)"
  else
    foresta $argv | fzf --ansi --reverse --no-sort --preview='test -n (echo {1} | grep -E "^[0-9a-f]+\$"); and command git show --color --pretty=fuller {1}' --bind="$git_fzf_binds,enter:execute(git show --color --pretty=fuller {1} | diff-highlight | less -RSX)"
  end
  return 0
end

function g
  commandline "git "
end

function git
  set SUBCOMMAND $argv[1]
  set --erase argv[1]
  switch "$SUBCOMMAND"
    case 'status'       ; _git_status       $argv
    case 'add'          ; _git_add          $argv
    case 'push'         ; _git_push         $argv
    case 'fetch'        ; _git_fetch        $argv
    case 'blame'        ; _git_blame        $argv
    case 'difftool'     ; _git_difftool     $argv
    case 'mergetool'    ; _git_mergetool    $argv
    case 'checkout'     ; _git_checkout     $argv
    case 'sublime-diff' ; _git_sublime_diff $argv
    case '*'            ; command git $SUBCOMMAND $argv
  end

  switch "$SUBCOMMAND"
    case 'stash'       ; ctags
    case 'reset'       ; ctags
    case 'merge'       ; ctags
    case 'rebase'      ; ctags
    case 'checkout'    ; ctags
    case 'fetch'       ; ctags
    case 'cherry-pick' ; ctags
    case 'am'          ; ctags
  end
end

function _git_status
  command git status $argv -su | string replace -r '^.. ' '' | xargs -I /// dirname '///' | sort | uniq | while read -l r
    _rm_osx_hidden_files $r
  end
  command git status $argv -su
end

function _git_status_colorize
  git status -su $argv | while read -l r
    set STAGING (string sub -s 1 -l 1 "$r")
    set UNSTAGING (string sub -s 2 -l 1 "$r")
    set TARGET_FILE (string sub -s 3 "$r")

    if [ "$UNSTAGING" = 'U' -o "$UNSTAGING" = '?' ]
      set_color red
    else
      set_color green
    end
    echo -n "$STAGING"

    set_color red
    echo -n "$UNSTAGING"

    set_color normal
    echo "$TARGET_FILE"
  end
end

function _is_untracked_file_exist
  set EXIST 'FALSE'
  for i in (git status --porcelain)
    set UNTRACKED (string sub -s 2 -l 1 "$i")
    if [ "$UNTRACKED" != ' ' ]
      set EXIST 'TRUE'
      break
    end
  end
  echo "$EXIST"
end

function _git_add
  while [ (_is_untracked_file_exist) = 'TRUE' ]
    set -u result
    _git_status_colorize .| fzf --exit-0 --ansi --bind="$git_fzf_binds" --expect=ctrl-c --preview='command git diff --color {2..-1}' | string sub -s 4 | while read -l r
      set result $result $r
    end
    test -z "$result"; and break
    test "$result[1]" = 'l-c'; and git diff --color --cached | less -RSX; and continue
    command git add $argv $result[2]
  end
  echo 'There is no unstag file.'
end

function _git_push
  if [ (count $argv) = 0 ]
    command git branch -a --color | grep -v 'HEAD' | fzf --ansi --tac --exit-0 --bind="$git_fzf_binds" | string sub -s 3 | read -l result
    if [ (string sub -s 1 -l 8 "$result") = 'remotes/' ]
      set result (string sub -s 9 "$result")
    end
    commandline "git push $result"
    return
  end
  git remote -v | grep '(push)' | fzf --exit-0 --multi --bind="$git_fzf_binds,ctrl-a:select-all" | awk '{print $1;}' | while read -l result
    echo "git push $result $argv"
    command git push $result $argv
  end
end

function _git_fetch
  git remote -v | grep '(fetch)' | fzf --exit-0 --multi --bind="$git_fzf_binds,ctrl-a:select-all" | awk '{print $1;}' | while read -l result
    echo "git fetch $argv $result"
    command git fetch $argv $result
  end
end

function _git_blame
  # TODO: git_root_path の取得をスマートにする(コマンドで取得できる)
  set current_path (pwd)'/'
  builtin cd ./(git rev-parse --show-cdup)
  set git_root_path (pwd)'/'

  set default_query (echo $current_path | cut -c (string length "$git_root_path ")-)
  set git_ls_files (string join "\n" (git ls-files))

  builtin cd $current_path

  echo -e "$git_ls_files" | while read -l r
    echo -n (string length (echo $r | sed -e "s/[^\/]//g"))
    echo " $r"
  end | sort -rn | awk '{print $2;}' | fzf --exit-0 --tac --query="$default_query" --bind="$git_fzf_binds" --no-sort --preview="command git log -U3 --color $git_root_path{}" | read -l result

  command git blame $argv "$git_root_path$result" | fzf --reverse --exit-0 --bind="$git_fzf_binds" --no-sort --preview="command git show --color {1}" | awk '{print $1;}' | read -l result
  commandline "git show $result"
end

function _git_difftool
  if [ (uname) = 'Darwin' ]
    yes 'y' | command git difftool $argv
  else
    command git difftool $argv
  end
end

function _git_mergetool
  command git mergetool $argv
end

function _git_checkout
  if [ (count $argv) -gt 0 ]
    command git checkout $result $argv
    return
  end
  _git_select_commit | read -l result
  test -z "$result"; and return
  test "$result" = '(none)'; and return
  commandline "git checkout $result"
end

function _git_select_commit
  while true
    set -u SELECTED; _git_select_branches | read -l SELECTED
    test -n "$SELECTED"; and echo $SELECTED; and break
    set -u SELECTED; _git_select_graph | read -l SELECTED
    test -n "$SELECTED"; and echo $SELECTED; and break
  end
end

function _git_select_branches
  set -u result
  command git branch -a --color | grep -v 'HEAD' | string sub -s 3 | fzf --ansi --tac --exit-0 --bind="$git_fzf_binds" --preview="command git show --color --pretty=fuller {}" --expect=ctrl-r | while read -l r
    set result $result $r
  end
  test -z "$result"; and echo '(none)'; and return
  set EXPECT $result[1]
  set BRANCH $result[2]

  if [ "$EXPECT" = 'ctrl-r' ]
    return
  end

  if [ (string sub -s 1 -l 8 "$BRANCH") = 'remotes/' ]
    set BRANCH (string sub -s 9 "$BRANCH")
  end
  echo $BRANCH
end

function _git_select_tags
end

function _git_show_refses
  set COMMIT (command git rev-parse (echo $argv | awk '{print $1}'))
  echo $COMMIT
  command git show-ref | grep "$COMMIT" | sed -E "s/[0-9a-f]{40} refs\/(heads\/)?//"
end

function _git_select_graph
  set -u result
  foresta --branches --remotes --tags $argv | fzf --ansi --reverse --preview='test -n (echo {1} | grep -E "^[0-9a-f]+\$"); and command git show --color --pretty=fuller {1}' --bind="$git_fzf_binds"  --expect=ctrl-r | while read -l r
    set result $result $r
  end

  test -z "$result"; and echo '(none)'; and return
  set EXPECT $result[1]
  set COMMIT (echo $result[2] | awk '{print $1}' | command grep -E '^[0-9a-f]+$')
  test -z "$COMMIT"; and echo 'err' >&2; and echo '(none)'; and return

  if [ "$EXPECT" = 'ctrl-r' ]
    return
  end

  set -u result
  _git_show_refses $COMMIT | grep -Ev '/HEAD$' | fzf --bind="$git_fzf_binds"  --expect=ctrl-r --exit-0 --select-1 | while read -l r
    set result $result $r
  end
  test -z "$result"; and echo '(none)'; and return
  set EXPECT $result[1]
  if [ "$EXPECT" = 'ctrl-r' ]
    return
  end
  echo $result[2]
end

function _git_sublime_diff
  set GIT_TOPLEVEL (command git rev-parse --show-toplevel)
  command git diff --name-only $argv | while read -l r
    s "$GIT_TOPLEVEL/$r"
  end
end
