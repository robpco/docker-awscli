FROM alpine:3.7

LABEL maintainer Robert Peteuil <https://github.com/robertpeteuil>

RUN apk --update add py-pip curl zip groff less bash && \
    pip install -U awscli && \
    rm -rf `find / -regex '.*\.py[co]' -or -name apk`

WORKDIR /aws
ENTRYPOINT ["aws"]
