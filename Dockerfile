FROM alpine:3.6

RUN apk update && \
    apk upgrade && \
    apk add --nocache ca-certificates wget bash git openssh && \
    update-ca-certificates

# https://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ENV REVIEWDOG_VERSION v0.10.0

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin ${REVIEWDOG_VERSION} && \
    chmod +x /usr/local/bin/reviewdog

CMD ["/usr/local/bin/reviewdog"]
