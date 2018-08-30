FROM alpine:latest

LABEL maintainer Robert Peteuil <https://github.com/robertpeteuil>

RUN apk --update add python py-pip groff less bash curl git openssh && \
    pip install -U awscli && \
    apk --purge -v del py-pip && \
    rm -rf `find / -regex '.*\.py[co]' -or -name apk`

WORKDIR /aws
ENTRYPOINT ["aws"]
