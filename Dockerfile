FROM ghcr.io/dockhippie/golang:1.25@sha256:f0d59ac761969fa7c8c1bb553b6b0acc2278df4c9d1ab2a1521e6a7fe1340553 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:1007587cf611613076e699591a06b62713fa611d14a69118d7b363fd1a8804ca
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
