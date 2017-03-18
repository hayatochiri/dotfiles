function ghq
  if [ -z "$argv" ]
     eval "$GOPATH/bin/ghq list" | fzf --exit-0 | read -l result
    if [ -z "$result" ]
      return
    end
    builtin cd (ghq root)"/$result"
    ls
  else
    eval "$GOPATH/bin/ghq $argv"
  end
end
