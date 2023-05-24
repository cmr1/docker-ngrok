FROM alpine:latest

LABEL maintainer "Charlie McClung <charlie@cmr1.com>"

RUN apk add --no-cache bash curl && \
    mkdir -p /ngrok

WORKDIR /ngrok

RUN curl -s https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -o ngrok.tgz && \
    tar -xvzf ngrok.tgz -C . && \
    rm ngrok.tgz

COPY . .

EXPOSE 4040

ENTRYPOINT [ "./docker-entrypoint.sh" ]
