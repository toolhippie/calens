FROM ghcr.io/dockhippie/golang:1.27@sha256:19c92db448fe90395770677792d200bcd56f245184ee3dd255f98e73b2449f93 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:1194c744e2b2a03ecb3214aecb89005830fa422b4a8f84cd12951d6d29df7a4c
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
