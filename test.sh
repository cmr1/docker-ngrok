#!/bin/bash

set -e

endpoints="$(docker-compose exec ngrok /bin/bash /ngrok/status)"

for ep in $endpoints; do
  trimmed=$(echo $ep | tr -d '[:space:]')

  echo "Verifying endpoint: '$trimmed'"

  [[ "$(curl -Is ${trimmed} | head -n 1|cut -d$' ' -f2)" == "200" ]] || exit 1
done