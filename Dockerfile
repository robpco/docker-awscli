FROM alpine:latest

LABEL maintainer Robert Peteuil <https://github.com/robertpeteuil>

RUN apk --update add python py-pip zip groff less bash curl git && \
    pip install -U awscli && \
    apk --purge -v del py-pip && \
    rm -rf `find / -regex '.*\.py[co]'`

WORKDIR /aws
ENTRYPOINT ["aws"]
