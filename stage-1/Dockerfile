FROM kalilinux/kali-linux-docker

ENV TERM=xterm
SHELL ["/bin/bash", "-c"]
WORKDIR /kali

ADD ddash/* /usr/local/sbin/
ADD ddash/apt-fast.conf /etc/apt-fast.conf

RUN apt-get update && \
    apt-get -y install aria2 httpie jq curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "deb http://repo.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://repo.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
    apt-fast update && \
    apt-fast -y upgrade && \
    apt-fast -y dist-upgrade && \
    rm -rf /var/lib/apt/lists/*