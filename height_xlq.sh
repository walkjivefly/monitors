#!/bin/bash
CONFIG="${HOME}/.alqocrypto/alqo.conf"
NODETYPE=$(awk -F= '/^masternode=/ {print $1}' ${CONFIG})
LOCAL=$(alqo-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    status=$(alqo-cli getmasternodestatus|jq -r .message)
    if [[ "$status" != "Masternode successfully started" ]]; then
      LOCAL=$status
    fi
  fi
else
  LOCAL="problem"
fi
EXPLORER="https://alqo.cryptoscope.io/api/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount/ 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq -r .blockcount)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
