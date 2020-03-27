FROM alpine:3.11 AS builder

ENV VERSION=1.3.4

RUN set -eux; \
    apk add --no-cache go gcc g++; \
    wget --no-check-certificate -q https://github.com/syncthing/syncthing/archive/v${VERSION}.zip -O /tmp/syncthing.zip; \
    unzip /tmp/syncthing.zip -d /tmp; \
    mv /tmp/syncthing-${VERSION} /tmp/syncthing; \
    cd /tmp/syncthing; \
    CGO_ENABLED=0 go run build.go -no-upgrade build syncthing

FROM alpine:3.11

ENV UID=1000 \
    GID=1000 \
    HOME=/var/syncthing \
    STGUIADDRESS=0.0.0.0:8384

RUN apk add --no-cache ca-certificates su-exec

COPY --from=builder /tmp/syncthing/syncthing /bin/syncthing
COPY --from=builder /tmp/syncthing/script/docker-entrypoint.sh /entrypoint.sh

EXPOSE 8384 22000 21027/udp

VOLUME ["/var/syncthing"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/syncthing", "-home", "/var/syncthing/config"]