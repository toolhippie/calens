FROM ghcr.io/dockhippie/golang:1.25@sha256:9882e7d28461c509641c956f8cdbd37677105a7c8f4e9df7418403ff81f8a1d9 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:abaed72a71402d9cd7ca6e5fda8798374db11bee0959231c26c651721f283968
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
