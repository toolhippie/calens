FROM ghcr.io/dockhippie/golang:1.23@sha256:384a2beb92828b3f2aa019b28673ef4a6f61df4451905f39a7574c993d414e18 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.22@sha256:29332ffd57d5b3922d93a7e0d47484f5da7a963fc8dfd7654ec10a48bf36a20f
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
