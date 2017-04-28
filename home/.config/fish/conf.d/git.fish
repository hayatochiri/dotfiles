set git_fzf_binds 'ctrl-v:page-down,ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-v:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up,alt-d:preview-page-down,alt-u:preview-page-up,alt-j:preview-down,alt-n:preview-down,alt-k:preview-up,alt-p:preview-up,alt-enter:toggle-preview'

function gg-less
  _gg $argv | less -RSX
end

function gg
  _gg $argv | fzf --ansi --reverse --preview='bash -c "[[ {1} =~ ^[0-9a-f]+$ ]] && git show --color {1}"' --bind="$git_fzf_binds,enter:execute(git show --color {1} | less -RSX)"
end

function _gg
  git-forest --style=20 --branches --remotes --tags $argv | while read -l r
    echo "$r    "
  end
end

function g
  # git --help -a
  switch (git --version)
  case 'git version 2.1.4'
    set subcommands "add\ncheck-attr\ncommit-tree\ndiff-tree\nfsck-objects\ninit-db\nmerge-octopus\nnotes\nreceive-pack\nreplace\nshow\nunpack-file\nwhatchanged\nadd--interactive\ncheck-ignore\nconfig\ndifftool\ngc\ninstaweb\nmerge-one-file\npack-objects\nreflog\nrequest-pull\nshow-branch\nunpack-objects\nwrite-tree\nam\ncheck-mailmap\ncount-objects\ndifftool--helper\nget-tar-commit-id\nlog\nmerge-ours\npack-redundant\nrelink\nrerere\nshow-index\nupdate-index\nannotate\ncheck-ref-format\ncredential\nfast-export\ngrep\nls-files\nmerge-recursive\npack-refs\nremote\nreset\nshow-ref\nupdate-ref\napply\ncheckout\ncredential-cache\nfast-import\nhash-object\nls-remote\nmerge-resolve\npatch-id\nremote-ext\nrev-list\nstage\nupdate-server-info\narchive\ncheckout-index\ncredential-cache--daemon\nfetch\nhelp\nls-tree\nmerge-subtree\nprune\nremote-fd\nrev-parse\nstash\nupload-archive\nbisect\ncherry\ncredential-store\nfetch-pack\nhttp-backend\nmailinfo\nmerge-tree\nprune-packed\nremote-ftp\nrevert\nstatus\nupload-pack\nbisect--helper\ncherry-pick\ndaemon\nfilter-branch\nhttp-fetch\nmailsplit\nmergetool\npull\nremote-ftps\nrm\nstripspace\nvar\nblame\nclean\ndescribe\nfmt-merge-msg\nhttp-push\nmerge\nmktag\npush\nremote-http\nsend-pack\nsubmodule\nverify-commit\nbranch\nclone\ndiff\nfor-each-ref\nimap-send\nmerge-base\nmktree\nquiltimport\nremote-https\nsh-i18n--envsubst\nsubtree\nverify-pack\nbundle\ncolumn\ndiff-files\nformat-patch\nindex-pack\nmerge-file\nmv\nread-tree\nremote-testsvn\nshell\nsymbolic-ref\nverify-tag\ncat-file\ncommit\ndiff-index\nfsck\ninit\nmerge-index\nname-rev\nrebase\nrepack\nshortlog\ntag\nweb--browse"
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
  echo -e "$subcommands\n$git_aliases" | fzf --bind="$git_fzf_binds" --preview='man git ${1}' | awk '{print $1;}' | read -l result
  if [ -z "$result" ]
    return
  end
  commandline "git $result "
end

function git
  switch "$argv[1]"
    case 'status'  ; _git_status   $argv
    case 'add'     ; _git_add      $argv
    case 'push'    ; _git_push     $argv
    case 'fetch'   ; _git_fetch    $argv
    case 'blame'   ; _git_blame    $argv
    case 'checkout'; _git_checkout $argv
    case '*'       ; command git $argv
  end
end

function _git_status
  command git $argv -su
end

function _git_add
  echo $argv
  set -e result
  command git status -su | fzf --ansi --multi | awk '{print $2;}' | while read -l r
    set result $result $r
  end
  echo "git $argv $result"
  command git $argv $result
end

function _git_push
  git remote -v | grep '(push)' | fzf --exit-0 --multi --bind="$git_fzf_binds,ctrl-a:select-all" | awk '{print $1;}' | while read -l result
    echo "git $argv $result"
    command git $argv $result
  end
end

function _git_fetch
  git remote -v | grep '(fetch)' | fzf --exit-0 --multi --bind="$git_fzf_binds,ctrl-a:select-all" | awk '{print $1;}' | while read -l result
    echo "git $argv $result"
    command git $argv $result
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

  command git $argv $result | fzf --reverse --exit-0 --bind="$git_fzf_binds" --no-sort --preview="git show --color {1}" | awk '{print $1;}' | read -l result
  commandline "git show $result"
end

function _git_checkout
  command git branch -a
  for remote in (command git remote)
    command git ls-remote --tags $remote
  end
end
