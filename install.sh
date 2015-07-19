#!/bin/bash
set -e

echo "daemon off;" >> /etc/nginx/nginx.conf
echo "expose_php = Off" >> /etc/hhvm/php.ini

/usr/share/hhvm/install_fastcgi.sh
/etc/init.d/hhvm restart

rm -rf /etc/nginx/sites-enabled/*

# hhvm configure
cat > /etc/supervisor/conf.d/hhvm.conf <<EOF
[program:hhvm]
directory=/
command=hhvm --mode server -vServer.Type=fastcgi -vServer.Port=9000
user=root
autostart=true
autorestart=true
EOF

# nginx configure
cat > /etc/supervisor/conf.d/nginx.conf <<EOF
[program:nginx]
directory=/
command=/usr/sbin/nginx
user=root
autostart=true
autorestart=true
EOF
