FROM webhippie/golang:1.19 AS build

# renovate: datasource=github-tags depName=restic/calens
ENV CALENS_VERSION=0.2.0

RUN git clone -b v${CALENS_VERSION} https://github.com/restic/calens.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install

FROM webhippie/alpine:3.17
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add make && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/calens /usr/bin/
