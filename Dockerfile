FROM alpine:3.3
ADD checksums.sha256 checksums.sha256
RUN wget http://repo.or.cz/w/pachi.git/snapshot/pachi-11.00-retsugen.tar.gz && \
    sha256sum -c checksums.sha256 && \
    apk add --update build-base && \
    tar -xzf pachi-11.00-retsugen.tar.gz && \
    cd pachi-pachi-11.00-retsugen-9f8c498 && \
    SYS_CFLAGS='' make && \
    make install && \
    cd .. && \
    rm pachi-11.00-retsugen.tar.gz && \
    rm -rf pachi-pachi-11.00-retsugen-9f8c498 && \
    rm -rf /var/cache/apk/* && \
    rm checksums.sha256 && \
    apk del build-base
EXPOSE 6809
USER nobody
CMD ["pachi", "-g", "6809"]
