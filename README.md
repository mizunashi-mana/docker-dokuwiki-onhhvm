# docker-dokuwiki
Dokuwiki on nginx + hhvm for Docker

PHPエンジンとしてHHVM、Webサーバーとしてnginxを使ったDokuwikiのdebian:jessieコンテナです。

# Install

```
$ git clone https://github.com/mizunashi-mana/docker-dokuwiki.git
$ cd docker-dokuwiki
$ docker build -t mizunashi/dokuwiki .
```

# How to use

```
$ docker run -d -p 80 --name my_wiki mizunashi/dokuwiki
```

Going to http://127.0.0.1/install.php
