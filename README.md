# Dotfiles

Ansible Playbookでdotfilesのデプロイを行う。
dotfilesだけど環境構築(パッケージのインストール)も行う。

## 動作確認

* 確認用環境の用意

    ```sh
    $ vagrant up
    ```

    ※ Vagrant, VirtualBoxに依存

* 環境構築

    ```sh
    $ vagrant provision
    ```

    ※ 確認用環境にAnsible Playbookを実行

* 確認用環境の停止

    ```sh
    $ vagrant halt
    ```

    ※ `vagrant up` で再開

* 確認用環境の削除

    ```sh
    $ vagrant destroy
    ```

## ファイル構成

* /playbook/

* /exporter/

    古いAnsible Playbook。移植して消す。

* export

    シェルスクリプトでデプロイしていた頃の名残。移植して消す。
