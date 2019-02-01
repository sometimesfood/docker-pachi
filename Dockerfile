FROM alpine:3.9 as builder
WORKDIR /src
ADD checksums.sha256 checksums.sha256
RUN wget http://repo.or.cz/w/pachi.git/snapshot/pachi-11.00-retsugen.tar.gz
RUN sha256sum -c checksums.sha256
RUN apk add --no-cache build-base
RUN tar -xzf pachi-11.00-retsugen.tar.gz
RUN cd pachi-pachi-11.00-retsugen-9f8c498 && \
    SYS_CFLAGS='' make && \
    strip pachi

FROM alpine:3.9
COPY --from=builder \
    /src/pachi-pachi-11.00-retsugen-9f8c498/pachi \
    /usr/local/bin/pachi
EXPOSE 6809
USER nobody
CMD ["pachi", "-g", "6809"]
