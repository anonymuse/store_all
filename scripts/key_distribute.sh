#!/bin/bash

set -o nounset
set -o errexit

if [ $# -lt 1 ]; then
  echo "Usage: $0 <User>@<Host>"
  echo ""
  echo "  Copies your id_rsa.pub file to the remote host and adds it to the"
  echo "  authorized keys."
  exit 1
fi

declare -r CONNECTION="${1}"
declare -r REMOTE_KEY_PATH=/tmp/id_rsa.${USER}.pub

echo "Copy key..."
scp ~/.ssh/id_rsa.pub ${CONNECTION}:${REMOTE_KEY_PATH}
echo "Attach key to authorized_keys..."
ssh ${CONNECTION} "mkdir -p .ssh;chmod og-rwx .ssh;cat ${REMOTE_KEY_PATH} >> .ssh/authorized_keys;rm -f ${REMOTE_KEY_PATH}"

echo "Key got added to authorized keys."
