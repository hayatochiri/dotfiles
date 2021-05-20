#!/bin/sh

# TODO: 初期セットアップ(READMEに書く)
# pip3 -> ansible and git
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python3 get-pip.py
# pip3 install ansible
# git clone
# ansible-playbook(MacOSだと最初はパスが通っていない)
# TODO: MacOS: nkfをインストール
# TODO: MacOS: diff-highlightをインストール
#   $(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight
# TODO: MacOS: brewでgitをインストール

~/Library/Python/3.8/bin/ansible-playbook --ask-become-pass playbook.yml
