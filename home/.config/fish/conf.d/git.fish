function g
  # git --help -a
  switch (git --version)
  case 'git version 2.11.0'
    set subcommands "add\ncheck-attr\ncommit-tree\ndiff-files\nfsck\ninit\nmerge-index\nnotes\nreceive-pack\nrequest-pull\nshow-branch\nunpack-objects\nwrite-tree\nadd--interactive\ncheck-ignore\nconfig\ndiff-index\nfsck-objects\ninit-db\nmerge-octopus\np4\nreflog\nrerere\nshow-index\nupdate-index\nam\ncheck-mailmap\ncount-objects\ndiff-tree\ngc\ninstaweb\nmerge-one-file\npack-objects\nrelink\nreset\nshow-ref\nupdate-ref\nannotate\ncheck-ref-format\ncredential\ndifftool\nget-tar-commit-id\ninterpret-trailers\nmerge-ours\npack-redundant\nremote\nrev-list\nstage\nupdate-server-info\napply\ncheckout\ncredential-cache\ndifftool--helper\ngrep\nlog\nmerge-recursive\npack-refs\nremote-ext\nrev-parse\nstash\nupload-archive\narchimport\ncheckout-index\ncredential-cache--daemon\nfast-export\ngui\nls-files\nmerge-resolve\npatch-id\nremote-fd\nrevert\nstatus\nupload-pack\narchive\ncherry\ncredential-store\nfast-import\ngui--askpass\nls-remote\nmerge-subtree\nprune\nremote-ftp\nrm\nstripspace\nvar\nbisect\ncherry-pick\ncvsexportcommit\nfetch\nhash-object\nls-tree\nmerge-tree\nprune-packed\nremote-ftps\nsend-email\nsubmodule\nverify-commit\nbisect--helper\ncitool\ncvsimport\nfetch-pack\nhelp\nmailinfo\nmergetool\npull\nremote-http\nsend-pack\nsubmodule--helper\nverify-pack\nblame\nclean\ncvsserver\nfilter-branch\nhttp-backend\nmailsplit\nmktag\npush\nremote-https\nsh-i18n--envsubst\nsvn\nverify-tag\nbranch\nclone\ndaemon\nfmt-merge-msg\nhttp-fetch\nmerge\nmktree\nquiltimport\nremote-testsvn\nshell\nsymbolic-ref\nweb--browse\nbundle\ncolumn\ndescribe\nfor-each-ref\nimap-send\nmerge-base\nmv\nread-tree\nrepack\nshortlog\ntag\nwhatchanged\ncat-file\ncommit\ndiff\nformat-patch\nindex-pack\nmerge-file\nname-rev\nrebase\nreplace\nshow\nunpack-file\nworktree"
  case 'git version 2.12.0'
    set subcommands "add\nclone\nfetch\nlog\np4\nreplace\nsvn\nadd--interactive\ncolumn\nfetch-pack\nls-files\npack-objects\nrequest-pull\nsymbolic-ref\nam\ncommit\nfilter-branch\nls-remote\npack-redundant\nrerere\ntag\nannotate\ncommit-tree\nfmt-merge-msg\nls-tree\npack-refs\nreset\nunpack-file\napply\nconfig\nfor-each-ref\nmailinfo\npatch-id\nrev-list\nunpack-objects\narchimport\ncount-objects\nformat-patch\nmailsplit\nprune\nrev-parse\nupdate-index\narchive\ncredential\nfsck\nmerge\nprune-packed\nrevert\nupdate-ref\nbisect\ncredential-cache\nfsck-objects\nmerge-base\npull\nrm\nupdate-server-info\nbisect--helper\ncredential-cache--daemon\ngc\nmerge-file\npush\nsend-email\nupload-archive\nblame\ncredential-store\nget-tar-commit-id\nmerge-index\nquiltimport\nsend-pack\nupload-pack\nbranch\ncvsexportcommit\ngrep\nmerge-octopus\nread-tree\nsh-i18n--envsubst\nvar\nbundle\ncvsimport\ngui\nmerge-one-file\nrebase\nshell\nverify-commit\ncat-file\ncvsserver\ngui--askpass\nmerge-ours\nreceive-pack\nshortlog\nverify-pack\ncheck-attr\ndaemon\nhash-object\nmerge-recursive\nreflog\nshow\nverify-tag\ncheck-ignore\ndescribe\nhelp\nmerge-resolve\nremote\nshow-branch\nweb--browse\ncheck-mailmap\ndiff\nhttp-backend\nmerge-subtree\nremote-ext\nshow-index\nwhatchanged\ncheck-ref-format\ndiff-files\nhttp-fetch\nmerge-tree\nremote-fd\nshow-ref\nworktree\ncheckout\ndiff-index\nimap-send\nmergetool\nremote-ftp\nstage\nwrite-tree\ncheckout-index\ndiff-tree\nindex-pack\nmktag\nremote-ftps\nstash\ncherry\ndifftool\ninit\nmktree\nremote-http\nstatus\ncherry-pick\ndifftool--helper\ninit-db\nmv\nremote-https\nstripspace\ncitool\nfast-export\ninstaweb\nname-rev\nremote-testsvn\nsubmodule\nclean\nfast-import\ninterpret-trailers\nnotes\nrepack\nsubmodule--helper"
  case '*'
    commandline "git "
    return
  end
  set git_aliases (git config --list | grep 'alias\.' | sed 's/alias\.\([^=]*\)=\(.*\)/\1\     => \2/')
  echo -e "$subcommands\n$git_aliases" | fzf | awk '{print $1;}' | read -l result
  if [ -z "$result" ]
    return
  end
  commandline "git $result "
end

function git
  switch "$argv[1]"
  case 'add'
    set -e result
    command git status --short --ignored | fzf --ansi --multi | awk '{print $2;}' | while read -l r
      set result $result $r
    end
    echo "git $argv $result"
    command git $argv $result
  case 'push'
    git remote -v | grep '(push)' | fzf --exit-0 --multi | awk '{print $1;}' | while read -l result
      echo "git $argv $result"
      command git $argv $result
    end
  case 'fetch'
    git remote -v | grep '(fetch)' | fzf --exit-0 --multi | awk '{print $1;}' | while read -l result
      echo "git $argv $result"
      command git $argv $result
    end
  case 'blame'
    command git $argv | fzf --exit-0 --tac | awk '{print $1;}' | read -l result
    command git show $result
  case '*'
    command git $argv
  end
end
