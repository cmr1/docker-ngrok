#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

ARGS=$@

# NGROK_AUTH - Authentication key for your Ngrok account. This is needed for custom subdomains, custom domains, and HTTP authentication.
# NGROK_SUBDOMAIN - Name of the custom subdomain to use for your tunnel. You must also provide the authentication token.
# NGROK_HOSTNAME - Paying Ngrok customers can specify a custom domain. Only one subdomain or domain can be specified, with the domain taking priority.
# NGROK_PROTOCOL - Can either be HTTP or TCP, and it defaults to HTTP if not specified. If set to TCP, Ngrok will allocate a port instead of a subdomain and proxy TCP requests directly to your application.
# NGROK_PORT - Port to expose (defaults to 80 for HTTP protocol).

if [ -z $NGROK_PROTOCOL ]; then
  NGROK_PROTOCOL=http
fi

if [ -z $NGROK_PORT ]; then
  NGROK_PORT=80
fi

if [ -z $NGROK_TARGET ]; then
  NGROK_TARGET=172.17.42.1
fi

if [ ! -z $NGROK_AUTH ]; then
  ./ngrok authtoken $NGROK_AUTH
fi

if [[ "$ARGS" == "" ]]; then
  NGROK_OPTIONS="-config=/ngrok/ngrok.yml"

  if [ ! -z $NGROK_HOSTNAME ]; then
    NGROK_OPTIONS="$NGROK_OPTIONS -hostname=${NGROK_HOSTNAME}"
  elif [ ! -z $NGROK_SUBDOMAIN ]; then
    NGROK_OPTIONS="$NGROK_OPTIONS -subdomain=${NGROK_SUBDOMAIN}"
  fi

  ./ngrok $NGROK_PROTOCOL $NGROK_OPTIONS $NGROK_TARGET:$NGROK_PORT
elif [ -x $ARGS ]; then
  exec "$ARGS"
else
  ./ngrok $ARGS
  # Execute the CMD from the Dockerfile and pass in all of its arguments.
fi
