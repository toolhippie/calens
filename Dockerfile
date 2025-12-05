FROM ghcr.io/dockhippie/golang:1.25@sha256:28bfb54d5f96f0a194f2543ac115fe3d9ed48d0e546c60fa51189d17313f2206 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:95760a33908b66020311e4d50c71ae7ac3132aee8971e037d99a858cdc5b074e
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
