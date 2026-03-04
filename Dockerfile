FROM ghcr.io/dockhippie/golang:1.25@sha256:5f47ca0055f998157b7265674197b134b427100d22116d161a6bf69bc49ef2e9 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.4.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM ghcr.io/dockhippie/alpine:3.23@sha256:9d02517b6423d07d763d4eff86f19dc0d329791380e946438822137c9244da30
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
