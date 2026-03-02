FROM ghcr.io/dockhippie/golang:1.25@sha256:e53b907d2e20196c9b98de089693feebb0315bfe9c74331532f9cce8b0d3e618 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:ecf1af2fb0a1dd8a7c5db631a254ac3b77fcb53c51b18ab7bc8548699afad289
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
