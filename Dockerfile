FROM ubuntu:focal

RUN apt update ; apt install -y autossh ; apt clean ; rm -rf rm -rf /var/lib/apt/lists/* /var/cache/apt/* 

COPY init.sh /init.sh
COPY ssh_config /sshtunnel/ssh_config

RUN chmod +x /init.sh

ENV SSHCONFIGFILE=/sshtunnel/ssh_config
ENV TUNNEL_PORT=22

CMD /init.sh
