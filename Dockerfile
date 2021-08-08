FROM webhippie/golang:1.16 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=v0.2.0

RUN git clone -b ${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM webhippie/alpine:latest

ENTRYPOINT ["/usr/bin/calens"]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
