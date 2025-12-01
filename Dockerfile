FROM alpine:3.22 AS builder

WORKDIR /src

# hadolint ignore=DL3018
RUN apk add --no-cache make findutils rdfind zstd coreutils

COPY ./linux-firmware /src

# dedup target was only added recently
RUN make -C /src DESTDIR=/out install-zst && ( make dedup || true )

FROM alpine:3.22

# hadolint ignore=DL3018
RUN apk add --no-cache rsync

COPY --from=builder /out/lib/firmware /lib/firmware

# If the supervisor label io.balena.features.extra-firmware is truthy
# the extra firmware volume will be mounted to /extra-firmware and needs
# to be populated with the current firmware files from the container runtime.
# If the label is not truthy, this mount point will not exist.
CMD [ "rsync", "-av", "--delete", "/lib/firmware/", "/extra-firmware/" ]
