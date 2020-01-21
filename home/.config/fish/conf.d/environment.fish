if [ -e /etc/DOTFILES_EMULATOR ]
  # Dockerのエミュレータの場合は環境変数をホームディレクトリにしない
  set GOPATH /.go; and mkdir -p $GOPATH
  export GOPATH=/.go
else
  set GOPATH ~/.ghq; and mkdir -p $GOPATH
  export GOPATH=$HOME/.ghq
end

set PATH $PATH $GOPATH/bin

if [ (uname) = 'Darwin' ]
  set PATH $PATH /Applications/VMware\ OVF\ Tool
end
