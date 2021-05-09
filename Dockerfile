FROM alpine:3.12

LABEL maintainer Robert Peteuil <https://github.com/robertpeteuil>

RUN apk --update add python3 py3-pip py3-six zip groff less bash curl git && \
    pip install -U awscli && \
    apk --purge -v del && \
    rm -rf `find / -regex '.*\.py[co]'`

WORKDIR /aws
ENTRYPOINT ["aws"]
