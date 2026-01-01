FROM ghcr.io/dockhippie/golang:1.25@sha256:77c2c44ee1faa7d3b2602d572a83f2fb8283feadfeb36e91657d6f9f334aefef AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:5e39b361571bce625f139dea01d8adec6219f266e3517886e48c0134948d6df8
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
