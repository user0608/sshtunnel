FROM alpine:3.17.1

RUN apk add --update autossh && rm -rf /var/cache/apk/*; 

COPY init.sh /init.sh
COPY ssh_config /sshtunnel/ssh_config

RUN chmod +x /init.sh

ENV SSHCONFIGFILE=/sshtunnel/ssh_config
ENV TUNNEL_PORT=22
ENV AUTOSSH_LOGLEVEL=1
ENV SSHLOGLEVEL=""

CMD /init.sh