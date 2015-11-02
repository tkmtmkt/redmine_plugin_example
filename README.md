redmine_plugin_example
======================


### テスト

```sh
$ rake redmine:plugins:test NAME=redmine_plugin_example
```


### デプロイ

```sh
$ cd $REDMINE_HOME
```

```sh
$ bundle install
```

```sh
$ RAILS_ENV=production
$ rake redmine:plugins:migrate NAME=redmine_plugin_example
```
