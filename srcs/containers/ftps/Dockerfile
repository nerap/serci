FROM telegraf:v1
MAINTAINER racohen
RUN apk add vsftpd openssl
RUN { echo "pass"; echo "pass"; } | adduser -D ftpuser
RUN mkdir -p /home/ftpuser/ftp /etc/ssl/private /var/run/vsftpd/empty
RUN chown nobody:nogroup /home/ftpuser/ftp && chmod a-w /home/ftpuser/ftp
RUN echo "ftpuser" | tee -a /etc/vsftpd/vsftpd.userlist
RUN mkdir /home/ftpuser/ftp/files
RUN chown ftpuser:ftpuser /home/ftpuser/ftp/files
RUN echo "test file" > /home/ftpuser/ftp/files/test.txt
RUN sed -i -e "s/TMPBDD/ftps/g" /etc/telegraf/telegraf.conf
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/vsftpd.conf /etc/vsftpd.conf
COPY srcs/*.pem /etc/ssl/private/
CMD sh /bin/startscript/start-telegraf.sh && screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf && tail -F /dev/null

EXPOSE 20 21 30000
