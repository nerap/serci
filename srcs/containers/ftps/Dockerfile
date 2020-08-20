FROM telegraf:v1
MAINTAINER racohen
RUN apk add vsftpd openssl
RUN {echo "pass"; echo "pass"; } | adduser -D user
RUN mkdir -p /home/user/ftp /etc/ssl/private /var/run/vsftpd/empty
RUN chown nobody:nogroup /home/user/ftp && chmod a-w /home/user/ftp
RUN echo "user" | tee -a /etc/vsftpd/vsftpd.userlist
RUN echo "ITS WORKING" > /home/user/ftp/hello.txt
RUN sed -i -e "s/TMPBDD/ftps/g" /etc/telegraf/telegraf.conf
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/vsftpd.conf /etc/vsftpd.conf
COPY srcs/*.pem /etc/ssl/private/
COPY srcs/start-ftps.sh /bin/startscript/start-ftps.sh
CMD sh /bin/startscript/start-ftps.sh && tail -F /dev/null

EXPOSE 20 21 30000
