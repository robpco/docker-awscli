FROM alpine:latest

LABEL maintainer Robert Peteuil <https://github.com/robertpeteuil>

RUN apk --update add python3 py3-pip zip groff less bash curl git && \
    pip install -U awscli six && \
    apk --purge -v del && \
    rm -rf `find / -regex '.*\.py[co]'`

WORKDIR /aws
ENTRYPOINT ["aws"]
