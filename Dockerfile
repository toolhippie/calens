FROM ghcr.io/dockhippie/golang:1.23@sha256:09691472e299bd12831b3207a1111b0fbf04c42ec440c04d866579b80af9dfdb AS build

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
