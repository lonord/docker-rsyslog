FROM alpine:3.11

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --no-cache rsyslog \
    && echo 'module(load="imudp")' >> /etc/rsyslog.conf \
    && echo 'input(type="imudp" port="514")' >> /etc/rsyslog.conf \
    && echo 'module(load="imtcp")' >> /etc/rsyslog.conf \
    && echo 'input(type="imtcp" port="514")' >> /etc/rsyslog.conf

EXPOSE 514 514/udp

VOLUME [ "/var/log", "/etc/rsyslog.d" ]

ENTRYPOINT [ "rsyslogd", "-n" ]