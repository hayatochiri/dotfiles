set git_fzf_binds 'ctrl-v:page-down,ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-v:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up,alt-d:preview-page-down,alt-u:preview-page-up,alt-j:preview-down,alt-n:preview-down,alt-k:preview-up,alt-p:preview-up,alt-enter:toggle-preview'

# set .gitconfig
if [ (uname) = 'Darwin' ]
  git config --global core.editor "/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w"
else
  git config --global core.editor vim
end
git config --global rebase.autostash true

function gg-less
  if [ (count $argv) = 0 ]
    git-foresta --branches --remotes --tags | less -RSX
  else
    git-foresta $argv | less -RSX
  end
  return 0
end

function gg
  if [ (count $argv) = 0 ]
    git-foresta --branches --remotes --tags | fzf --ansi --reverse --preview='bash -c "[[ {1} =~ ^[0-9a-f]+$ ]] && git show --color --pretty=fuller {1}"' --bind="$git_fzf_binds,enter:execute(git show --color --pretty=fuller {1} | less -RSX)"
  else
    git-foresta $argv | fzf --ansi --reverse --preview='bash -c "[[ {1} =~ ^[0-9a-f]+$ ]] && git show --color --pretty=fuller {1}"' --bind="$git_fzf_binds,enter:execute(git show --color --pretty=fuller {1} | less -RSX)"
  end
  return 0
end

function g
  # git --help -a
  switch (git --version)
  case 'git version 2.1.4'
    set subcommands "add\ncheck-attr\ncommit-tree\ndiff-tree\nfsck-objects\ninit-db\nmerge-octopus\nnotes\nreceive-pack\nreplace\nshow\nunpack-file\nwhatchanged\nadd--interactive\ncheck-ignore\nconfig\ndifftool\ngc\ninstaweb\nmerge-one-file\npack-objects\nreflog\nrequest-pull\nshow-branch\nunpack-objects\nwrite-tree\nam\ncheck-mailmap\ncount-objects\ndifftool--helper\nget-tar-commit-id\nlog\nmerge-ours\npack-redundant\nrelink\nrerere\nshow-index\nupdate-index\nannotate\ncheck-ref-format\ncredential\nfast-export\ngrep\nls-files\nmerge-recursive\npack-refs\nremote\nreset\nshow-ref\nupdate-ref\napply\ncheckout\ncredential-cache\nfast-import\nhash-object\nls-remote\nmerge-resolve\npatch-id\nremote-ext\nrev-list\nstage\nupdate-server-info\narchive\ncheckout-index\ncredential-cache--daemon\nfetch\nhelp\nls-tree\nmerge-subtree\nprune\nremote-fd\nrev-parse\nstash\nupload-archive\nbisect\ncherry\ncredential-store\nfetch-pack\nhttp-backend\nmailinfo\nmerge-tree\nprune-packed\nremote-ftp\nrevert\nstatus\nupload-pack\nbisect--helper\ncherry-pick\ndaemon\nfilter-branch\nhttp-fetch\nmailsplit\nmergetool\npull\nremote-ftps\nrm\nstripspace\nvar\nblame\nclean\ndescribe\nfmt-merge-msg\nhttp-push\nmerge\nmktag\npush\nremote-http\nsend-pack\nsubmodule\nverify-commit\nbranch\nclone\ndiff\nfor-each-ref\nimap-send\nmerge-base\nmktree\nquiltimport\nremote-https\nsh-i18n--envsubst\nsubtree\nverify-pack\nbundle\ncolumn\ndiff-files\nformat-patch\nindex-pack\nmerge-file\nmv\nread-tree\nremote-testsvn\nshell\nsymbolic-ref\nverify-tag\ncat-file\ncommit\ndiff-index\nfsck\ninit\nmerge-index\nname-rev\nrebase\nrepack\nshortlog\ntag\nweb--browse"
  case 'git version 2.7.4 (Apple Git-66)'
    set subcommands "add\ncheck-attr\ncommit-tree\ndiff\nformat-patch\nindex-pack\nmerge-file\nname-rev\nrebase\nreplace\nshow\ntag\nwhatchanged\nadd--interactive\ncheck-ignore\nconfig\ndiff-files\nfsck\ninit\nmerge-index\nnotes\nreceive-pack\nrequest-pull\nshow-branch\nunpack-file\nworktree\nam\ncheck-mailmap\ncount-objects\ndiff-index\nfsck-objects\ninit-db\nmerge-octopus\np4\nreflog\nrerere\nshow-index\nunpack-objects\nwrite-tree\nannotate\ncheck-ref-format\ncredential\ndiff-tree\ngc\ninstaweb\nmerge-one-file\npack-objects\nrelink\nreset\nshow-ref\nupdate-index\napply\ncheckout\ncredential-cache\ndifftool\nget-tar-commit-id\ninterpret-trailers\nmerge-ours\npack-redundant\nremote\nrev-list\nstage\nupdate-ref\narchimport\ncheckout-index\ncredential-cache--daemon\ndifftool--helper\ngrep\nlog\nmerge-recursive\npack-refs\nremote-ext\nrev-parse\nstash\nupdate-server-info\narchive\ncherry\ncredential-osxkeychain\nfast-export\ngui--askpass\nls-files\nmerge-resolve\npatch-id\nremote-fd\nrevert\nstatus\nupload-archive\nbisect\ncherry-pick\ncredential-store\nfast-import\nhash-object\nls-remote\nmerge-subtree\nprune\nremote-ftp\nrm\nstripspace\nupload-pack\nbisect--helper\ncitool\ncvsexportcommit\nfetch\nhelp\nls-tree\nmerge-tree\nprune-packed\nremote-ftps\nsend-email\nsubmodule\nvar\nblame\nclean\ncvsimport\nfetch-pack\nhttp-backend\nmailinfo\nmergetool\npull\nremote-http\nsend-pack\nsubmodule--helper\nverify-commit\nbranch\nclone\ncvsserver\nfilter-branch\nhttp-fetch\nmailsplit\nmktag\npush\nremote-https\nsh-i18n--envsubst\nsubtree\nverify-pack\nbundle\ncolumn\ndaemon\nfmt-merge-msg\nhttp-push\nmerge\nmktree\nquiltimport\nremote-testsvn\nshell\nsvn\nverify-tag\ncat-file\ncommit\ndescribe\nfor-each-ref\nimap-send\nmerge-base\nmv\nread-tree\nrepack\nshortlog\nsymbolic-ref\nweb--browse"
  case 'git version 2.10.1 (Apple Git-78)'
    set subcommands "add\ncheck-ref-format\ncredential-osxkeychain\nfetch-pack\nimap-send\nmerge-octopus\npack-refs\nremote-ftps\nshell\nunpack-file\nadd--interactive\ncheckout\ncredential-store\nfilter-branch\nindex-pack\nmerge-one-file\npatch-id\nremote-http\nshortlog\nunpack-objects\nam\ncheckout-index\ncvsexportcommit\nfmt-merge-msg\ninit\nmerge-ours\nprune\nremote-https\nshow\nupdate-index\nannotate\ncherry\ncvsimport\nfor-each-ref\ninit-db\nmerge-recursive\nprune-packed\nremote-testsvn\nshow-branch\nupdate-ref\napply\ncherry-pick\ncvsserver\nformat-patch\ninstaweb\nmerge-resolve\npull\nrepack\nshow-index\nupdate-server-info\narchimport\ncitool\ndaemon\nfsck\ninterpret-trailers\nmerge-subtree\npush\nreplace\nshow-ref\nupload-archive\narchive\nclean\ndescribe\nfsck-objects\nlog\nmerge-tree\nquiltimport\nrequest-pull\nstage\nupload-pack\nbisect\nclone\ndiff\ngc\nls-files\nmergetool\nread-tree\nrerere\nstash\nvar\nbisect--helper\ncolumn\ndiff-files\nget-tar-commit-id\nls-remote\nmktag\nrebase\nreset\nstatus\nverify-commit\nblame\ncommit\ndiff-index\ngrep\nls-tree\nmktree\nreceive-pack\nrev-list\nstripspace\nverify-pack\nbranch\ncommit-tree\ndiff-tree\ngui--askpass\nmailinfo\nmv\nreflog\nrev-parse\nsubmodule\nverify-tag\nbundle\nconfig\ndifftool\nhash-object\nmailsplit\nname-rev\nrelink\nrevert\nsubmodule--helper\nweb--browse\ncat-file\ncount-objects\ndifftool--helper\nhelp\nmerge\nnotes\nremote\nrm\nsubtree\nwhatchanged\ncheck-attr\ncredential\nfast-export\nhttp-backend\nmerge-base\np4\nremote-ext\nsend-email\nsvn\nworktree\ncheck-ignore\ncredential-cache\nfast-import\nhttp-fetch\nmerge-file\npack-objects\nremote-fd\nsend-pack\nsymbolic-ref\nwrite-tree\ncheck-mailmap\ncredential-cache--daemon\nfetch\nhttp-push\nmerge-index\npack-redundant\nremote-ftp\nsh-i18n--envsubst\ntag"
  case 'git version 2.8.3'
    set subcommands "add\nclone\nfetch\nlog\np4\nrepack\nsubmodule--helper\nadd--interactive\ncolumn\nfetch-pack\nls-files\npack-objects\nreplace\nsvn\nam\ncommit\nfilter-branch\nls-remote\npack-redundant\nrequest-pull\nsymbolic-ref\nannotate\ncommit-tree\nfmt-merge-msg\nls-tree\npack-refs\nrerere\ntag\napply\nconfig\nfor-each-ref\nmailinfo\npatch-id\nreset\nunpack-file\narchimport\ncount-objects\nformat-patch\nmailsplit\nprune\nrev-list\nunpack-objects\narchive\ncredential\nfsck\nmerge\nprune-packed\nrev-parse\nupdate-index\nbisect\ncredential-cache\nfsck-objects\nmerge-base\npull\nrevert\nupdate-ref\nbisect--helper\ncredential-cache--daemon\ngc\nmerge-file\npush\nrm\nupdate-server-info\nblame\ncredential-store\nget-tar-commit-id\nmerge-index\nquiltimport\nsend-email\nupload-archive\nbranch\ncvsexportcommit\ngrep\nmerge-octopus\nread-tree\nsend-pack\nupload-pack\nbundle\ncvsimport\ngui\nmerge-one-file\nrebase\nsh-i18n--envsubst\nvar\ncat-file\ncvsserver\ngui--askpass\nmerge-ours\nreceive-pack\nshell\nverify-commit\ncheck-attr\ndaemon\nhash-object\nmerge-recursive\nreflog\nshortlog\nverify-pack\ncheck-ignore\ndescribe\nhelp\nmerge-resolve\nrelink\nshow\nverify-tag\ncheck-mailmap\ndiff\nhttp-backend\nmerge-subtree\nremote\nshow-branch\nweb--browse\ncheck-ref-format\ndiff-files\nhttp-fetch\nmerge-tree\nremote-ext\nshow-index\nwhatchanged\ncheckout\ndiff-index\nhttp-push\nmergetool\nremote-fd\nshow-ref\nworktree\ncheckout-index\ndiff-tree\nindex-pack\nmktag\nremote-ftp\nstage\nwrite-tree\ncherry\ndifftool\ninit\nmktree\nremote-ftps\nstash\ncherry-pick\ndifftool--helper\ninit-db\nmv\nremote-http\nstatus\ncitool\nfast-export\ninstaweb\nname-rev\nremote-https\nstripspace\nclean\nfast-import\ninterpret-trailers\nnotes\nremote-testsvn\nsubmodule"
  case 'git version 2.11.0'
    set subcommands "add\ncheck-attr\ncommit-tree\ndiff-files\nfsck\ninit\nmerge-index\nnotes\nreceive-pack\nrequest-pull\nshow-branch\nunpack-objects\nwrite-tree\nadd--interactive\ncheck-ignore\nconfig\ndiff-index\nfsck-objects\ninit-db\nmerge-octopus\np4\nreflog\nrerere\nshow-index\nupdate-index\nam\ncheck-mailmap\ncount-objects\ndiff-tree\ngc\ninstaweb\nmerge-one-file\npack-objects\nrelink\nreset\nshow-ref\nupdate-ref\nannotate\ncheck-ref-format\ncredential\ndifftool\nget-tar-commit-id\ninterpret-trailers\nmerge-ours\npack-redundant\nremote\nrev-list\nstage\nupdate-server-info\napply\ncheckout\ncredential-cache\ndifftool--helper\ngrep\nlog\nmerge-recursive\npack-refs\nremote-ext\nrev-parse\nstash\nupload-archive\narchimport\ncheckout-index\ncredential-cache--daemon\nfast-export\ngui\nls-files\nmerge-resolve\npatch-id\nremote-fd\nrevert\nstatus\nupload-pack\narchive\ncherry\ncredential-store\nfast-import\ngui--askpass\nls-remote\nmerge-subtree\nprune\nremote-ftp\nrm\nstripspace\nvar\nbisect\ncherry-pick\ncvsexportcommit\nfetch\nhash-object\nls-tree\nmerge-tree\nprune-packed\nremote-ftps\nsend-email\nsubmodule\nverify-commit\nbisect--helper\ncitool\ncvsimport\nfetch-pack\nhelp\nmailinfo\nmergetool\npull\nremote-http\nsend-pack\nsubmodule--helper\nverify-pack\nblame\nclean\ncvsserver\nfilter-branch\nhttp-backend\nmailsplit\nmktag\npush\nremote-https\nsh-i18n--envsubst\nsvn\nverify-tag\nbranch\nclone\ndaemon\nfmt-merge-msg\nhttp-fetch\nmerge\nmktree\nquiltimport\nremote-testsvn\nshell\nsymbolic-ref\nweb--browse\nbundle\ncolumn\ndescribe\nfor-each-ref\nimap-send\nmerge-base\nmv\nread-tree\nrepack\nshortlog\ntag\nwhatchanged\ncat-file\ncommit\ndiff\nformat-patch\nindex-pack\nmerge-file\nname-rev\nrebase\nreplace\nshow\nunpack-file\nworktree"
  case 'git version 2.12.0'
    set subcommands "add\nclone\nfetch\nlog\np4\nreplace\nsvn\nadd--interactive\ncolumn\nfetch-pack\nls-files\npack-objects\nrequest-pull\nsymbolic-ref\nam\ncommit\nfilter-branch\nls-remote\npack-redundant\nrerere\ntag\nannotate\ncommit-tree\nfmt-merge-msg\nls-tree\npack-refs\nreset\nunpack-file\napply\nconfig\nfor-each-ref\nmailinfo\npatch-id\nrev-list\nunpack-objects\narchimport\ncount-objects\nformat-patch\nmailsplit\nprune\nrev-parse\nupdate-index\narchive\ncredential\nfsck\nmerge\nprune-packed\nrevert\nupdate-ref\nbisect\ncredential-cache\nfsck-objects\nmerge-base\npull\nrm\nupdate-server-info\nbisect--helper\ncredential-cache--daemon\ngc\nmerge-file\npush\nsend-email\nupload-archive\nblame\ncredential-store\nget-tar-commit-id\nmerge-index\nquiltimport\nsend-pack\nupload-pack\nbranch\ncvsexportcommit\ngrep\nmerge-octopus\nread-tree\nsh-i18n--envsubst\nvar\nbundle\ncvsimport\ngui\nmerge-one-file\nrebase\nshell\nverify-commit\ncat-file\ncvsserver\ngui--askpass\nmerge-ours\nreceive-pack\nshortlog\nverify-pack\ncheck-attr\ndaemon\nhash-object\nmerge-recursive\nreflog\nshow\nverify-tag\ncheck-ignore\ndescribe\nhelp\nmerge-resolve\nremote\nshow-branch\nweb--browse\ncheck-mailmap\ndiff\nhttp-backend\nmerge-subtree\nremote-ext\nshow-index\nwhatchanged\ncheck-ref-format\ndiff-files\nhttp-fetch\nmerge-tree\nremote-fd\nshow-ref\nworktree\ncheckout\ndiff-index\nimap-send\nmergetool\nremote-ftp\nstage\nwrite-tree\ncheckout-index\ndiff-tree\nindex-pack\nmktag\nremote-ftps\nstash\ncherry\ndifftool\ninit\nmktree\nremote-http\nstatus\ncherry-pick\ndifftool--helper\ninit-db\nmv\nremote-https\nstripspace\ncitool\nfast-export\ninstaweb\nname-rev\nremote-testsvn\nsubmodule\nclean\nfast-import\ninterpret-trailers\nnotes\nrepack\nsubmodule--helper"
  case 'git version 2.12.2'
    set subcommands "add\ncat-file\ncolumn\ndaemon\nfilter-branch\nhelp\nls-tree\nmerge-subtree\npatch-id\nremote-fd\nrev-parse\nstage\nupdate-ref\nadd--interactive\ncheck-attr\ncommit\ndescribe\nfmt-merge-msg\nhttp-backend\nmailinfo\nmerge-tree\nprune\nremote-ftp\nrevert\nstash\nupdate-server-info\nam\ncheck-ignore\ncommit-tree\ndiff\nfor-each-ref\nhttp-fetch\nmailsplit\nmergetool\nprune-packed\nremote-ftps\nrm\nstatus\nupload-archive\nannotate\ncheck-mailmap\nconfig\ndiff-files\nformat-patch\nhttp-push\nmerge\nmktag\npull\nremote-http\nsend-email\nstripspace\nupload-pack\napply\ncheck-ref-format\ncount-objects\ndiff-index\nfsck\nindex-pack\nmerge-base\nmktree\npush\nremote-https\nsend-pack\nsubmodule\nvar\narchimport\ncheckout\ncredential\ndiff-tree\nfsck-objects\ninit\nmerge-file\nmv\nquiltimport\nremote-testsvn\nsh-i18n--envsubst\nsubmodule--helper\nverify-commit\narchive\ncheckout-index\ncredential-cache\ndifftool\ngc\ninit-db\nmerge-index\nname-rev\nread-tree\nrepack\nshell\nsvn\nverify-pack\nbisect\ncherry\ncredential-cache--daemon\ndifftool--helper\nget-tar-commit-id\ninstaweb\nmerge-octopus\nnotes\nrebase\nreplace\nshortlog\nsymbolic-ref\nverify-tag\nbisect--helper\ncherry-pick\ncredential-store\nfast-export\ngrep\ninterpret-trailers\nmerge-one-file\np4\nreceive-pack\nrequest-pull\nshow\ntag\nweb--browse\nblame\ncitool\ncvsexportcommit\nfast-import\ngui\nlog\nmerge-ours\npack-objects\nreflog\nrerere\nshow-branch\nunpack-file\nwhatchanged\nbranch\nclean\ncvsimport\nfetch\ngui--askpass\nls-files\nmerge-recursive\npack-redundant\nremote\nreset\nshow-index\nunpack-objects\nworktree\nbundle\nclone\ncvsserver\nfetch-pack\nhash-object\nls-remote\nmerge-resolve\npack-refs\nremote-ext\nrev-list\nshow-ref\nupdate-index\nwrite-tree"
  case '*'
    commandline "git "
    return
  end
  set git_aliases (git config --list | grep 'alias\.' | sed 's/alias\.\([^=]*\)=\(.*\)/\1\     => \2/')
  echo -e "$subcommands\n$git_aliases" | fzf --bind="$git_fzf_binds" --preview='git {1} --help' | awk '{print $1;}' | read -l result
  if [ -z "$result" ]
    return
  end
  commandline "git $result "
end

function git
  set SUBCOMMAND $argv[1]
  set --erase argv[1]
  switch "$SUBCOMMAND"
    case 'status'   ; _git_status    $argv
    case 'add'      ; _git_add       $argv
    case 'push'     ; _git_push      $argv
    case 'fetch'    ; _git_fetch     $argv
    case 'blame'    ; _git_blame     $argv
    case 'difftool' ; _git_difftool  $argv
    case 'mergetool'; _git_mergetool $argv
    case 'checkout' ; _git_checkout  $argv
    case '*'        ; command git $SUBCOMMAND $argv
  end
end

function _git_status
  command git status $argv -su
end

function _git_status_colorize
  git status -su | while read -l r
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
    _git_status_colorize| fzf --exit-0 --ansi --bind="$git_fzf_binds" --expect=ctrl-c --preview='git diff --color {2..-1}' | string sub -s 4 | while read -l r
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
  end | sort -rn | awk '{print $2;}' | fzf --exit-0 --tac --query="$default_query" --bind="$git_fzf_binds" --no-sort --preview="git log -U3 --color $git_root_path{}" | read -l result

  command git blame $argv "$git_root_path$result" | fzf --reverse --exit-0 --bind="$git_fzf_binds" --no-sort --preview="git show --color {1}" | awk '{print $1;}' | read -l result
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
  command git branch -a --color | grep -v 'HEAD' | string sub -s 3 | fzf --ansi --tac --exit-0 --bind="$git_fzf_binds" --preview="git show --color --pretty=fuller {}" --expect=ctrl-r | while read -l r
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
  git-foresta --branches --remotes --tags $argv | fzf --ansi --reverse --preview='bash -c "[[ {1} =~ ^[0-9a-f]+$ ]] && git show --color --pretty=fuller {1}"' --bind="$git_fzf_binds"  --expect=ctrl-r | while read -l r
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
