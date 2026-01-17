FROM debian:13-slim

LABEL org.opencontainers.image.authors="Matthew F. Fox <matt@foundry81.com>" \
      org.opencontainers.image.description="Containerized BIND DNS for authoritative and recursive use" \
      org.opencontainers.image.licenses="MIT"

ENV DATA_DIR=/data \
    BIND_USER=bind \
    CONFIG_DIR=/bind/etc

# Install BIND and minimal supporting tooling
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       bind9 \
       bind9-utils \
       dnsutils \
       bash \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
RUN chmod 755 /usr/local/sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp

VOLUME ["${DATA_DIR}"]

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named"]
