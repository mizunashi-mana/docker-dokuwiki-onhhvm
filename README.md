# docker-dokuwiki
Dokuwiki on nginx + hhvm for Docker

PHPエンジンとしてHHVM、Webサーバーとしてnginxを使ったDokuwikiのdebian:jessieコンテナです。

# Install

```
$ git clone /path/to/docker-dokuwiki.git
$ cd docker-dokuwiki
$ make build
```

# How to use

```
$ make quickstart
$ make logs
```

Going to http://127.0.0.1/install.php, and do initial settings.
After:

```
$ docker exec mydokuwiki-app after_install
```