FROM kalilinux/kali-linux-docker

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm
SHELL ["/bin/bash", "-c"]
WORKDIR /kali

ADD ddash/* /usr/local/sbin/
ADD ddash/apt-fast.conf /etc/apt-fast.conf

RUN echo 'Dpkg::Use-Pty "0";' > /etc/apt/apt.conf.d/00usepty && \
    apt-get update && \
    apt-get -qq install aria2 httpie jq curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "deb http://repo.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://repo.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
    apt-get -qq update && \
    apt-get -qq upgrade && \
    apt-get -qq dist-upgrade && \
    rm -rf /var/lib/apt/lists/*