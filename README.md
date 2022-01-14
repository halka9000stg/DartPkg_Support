# DartPkg_Support

Dart のパッケージ管理システム「Pub」のためのパッケージ管理支援ツール。

Control Support Tool for Dart Package Management System "Pub".

使用するには以下のコマンドを実行してコマンドを有効化(インストール)する。

```sh
> dart pub global activate dartpkg_support
```

## 開発者向け

未リリース(開発)状態のコマンドを有効化(インストール)する場合はレポジトリルートにて以下のコマンドを実行する。

```sh
> dart pub global activate --source path .
```

まだレポジトリをしていない場合はクローンをしてから上記手順を行うか、クローンせずに以下のコマンドを実行する。

```sh
> dart pub global activate --sgit https://github.com/halka9000stg/DartPkg_Support.git
```
