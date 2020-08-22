FROM nginx:v1
MAINTAINER racohen

RUN apk update && apk add wget && mkdir /www \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

# We get the last version of Wordpress and uncompress it
RUN wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& mv wordpress/* /www \
&& rm -rf /var/cache/apk/*

# We copy wordpress database config file
COPY wp-config.php /www/wp-config.php

RUN sed -i -e "s/\"nginx\"/\"wordpress\"/g" /etc/telegraf/telegraf.conf
# Here we go
COPY start.sh .
RUN chmod +x start.sh
EXPOSE 5050
CMD ./start.sh
