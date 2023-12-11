FROM ghcr.io/dockhippie/golang:1.21 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=0.4.0

RUN git clone -b v${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.19
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
