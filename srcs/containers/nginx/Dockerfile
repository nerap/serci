FROM telegraf:v1
MAINTAINER racohen

RUN apk update && apk add nginx php-fpm openrc php7-pdo_mysql openssh
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN adduser -D sshuser
RUN sed -i -e "s/TMPBDD/nginx/g" /etc/telegraf/telegraf.conf

COPY srcs/ssh /home/sshuser/.ssh
COPY srcs/certs /etc/nginx/certs
COPY srcs/start.sh /bin/startscript/start.sh
COPY srcs/default /etc/nginx/conf.d/default.conf
COPY srcs/index.html /var/www

CMD sh /bin/startscript/start.sh && tail -F /dev/null
