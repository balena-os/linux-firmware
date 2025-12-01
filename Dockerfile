FROM alpine:3.22 AS builder

WORKDIR /src

# hadolint ignore=DL3018
RUN apk add --no-cache make findutils rdfind zstd coreutils

COPY ./linux-firmware /src

# dedup target was only added recently
RUN make -C /src DESTDIR=/out install-zst && ( make dedup || true )

FROM scratch

COPY --from=builder /out/lib/firmware /lib/firmware
