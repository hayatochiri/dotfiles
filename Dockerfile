FROM debian:jessie
MAINTAINER hayatochiri <dev@sucret.sakura.ne.jp>

ENV GIT_VERSION v2.12.0

# Look https://golang.org/dl/
ENV GO_VERSION 1.8
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN apt-get update && \
  apt-get -y install tzdata && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV TEMPORARY_PACKAGES unzip \
  autoconf \
  make \
  gcc \
  g++ \
  gettext \
  asciidoc \
  docbook2x \
  libz-dev \
  install-info

ENV INSTALL_PACKAGES wget \
  libcurl4-openssl-dev \
  ca-certificates

RUN apt-get update && \
  apt-get -y install $TEMPORARY_PACKAGES $INSTALL_PACKAGES

# Install git
RUN mkdir -p /tmp/git && \
  cd /tmp/git && \
  wget https://github.com/git/git/archive/$GIT_VERSION.zip && \
  unzip *.zip && \
  rm -f *.zip && \
  cd git-* && \
  make configure && \
  ./configure --prefix=/usr && \
  make prefix=/usr all doc info && \
  make prefix=/usr install install-doc install-html install-info && \
  cd ../.. && \
  rm -rf git

# Install fish
RUN cd /tmp && \
  wget http://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key && \
  apt-key add - < Release.key && \
  rm -f Release.key && \
  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' > /etc/apt/sources.list.d/fish.list && \
  apt-get update && \
  apt-get -y install fish

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  yes 'y' | ~/.fzf/install

# Install Go lang
RUN cd /tmp && \
  wget https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz && \
  rm -f go$GO_VERSION.linux-amd64.tar.gz && \
  mkdir -p /go

RUN apt-get clean && \
  apt-get -y --purge remove $TEMPORARY_PACKAGES

CMD ["/usr/bin/fish"]
