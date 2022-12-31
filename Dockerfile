FROM ubuntu:focal

COPY init.sh /init.sh

RUN apt update ; apt install -y autossh ; apt clean ; rm -rf rm -rf /var/lib/apt/lists/* /var/cache/apt/* ; chmod +x /init.sh

CMD /init.sh
