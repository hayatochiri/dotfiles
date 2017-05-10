set ghq_fzf_binds 'ctrl-v:page-down,ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-v:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up,alt-d:preview-page-down,alt-u:preview-page-up,alt-j:preview-down,alt-n:preview-down,alt-k:preview-up,alt-p:preview-up,alt-enter:toggle-preview'
set ghq_root_path (command ghq root)

function ghq
  if [ -z "$argv" ]
     eval "$GOPATH/bin/ghq list" | fzf --exit-0 --bind="$ghq_fzf_binds" --preview="fish -c \"_ghq_previewer {}\"" | read -l result
    if [ -z "$result" ]
      return
    end
    builtin cd "$ghq_root_path/$result"
    ls
  else
    eval "$GOPATH/bin/ghq $argv"
  end
end

function _ghq_previewer
  echo '[configs]'
  echo "  user.name  :" (git --git-dir=$ghq_root_path/$argv/.git/ config user.name)
  echo "  user.email :" (git --git-dir=$ghq_root_path/$argv/.git/ config user.email)
  echo ''
  echo '[remotes]'
  git --git-dir=$ghq_root_path/$argv/.git/ remote -v
  echo ''
  echo '[root]'
  if [ (uname) = 'Darwin' ]
    gls -alpF --color=yes $ghq_root_path/$argv
  else
    command ls --color -al $ghq_root_path/$argv
  end
end
