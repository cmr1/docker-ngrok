FROM alpine:3.5

LABEL maintainer "Charlie McClung <charlie@cmr1.com>"

RUN apk add --no-cache \
  bash \
  curl \
  unzip

RUN mkdir -p /ngrok

WORKDIR /ngrok

RUN curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip

RUN unzip ngrok.zip && rm ngrok.zip

COPY docker-entrypoint.sh .
COPY status .

ENTRYPOINT [ "./docker-entrypoint.sh" ]