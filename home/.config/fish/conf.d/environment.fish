if [ -e /etc/DOTFILES_EMULATOR ]
  # Dockerのエミュレータの場合は環境変数をホームディレクトリにしない
  set GOPATH /.go; and mkdir -p $GOPATH
  export GOPATH=/.go
else
  set GOPATH ~/.go; and mkdir -p $GOPATH
  export GOPATH=$HOME/.go
end

set PATH $PATH /usr/local/go/bin $GOPATH/bin
