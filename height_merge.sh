#!/bin/bash
CONFIG="${HOME}/.merge/merge.conf"
NODETYPE=$(awk -F= '/^masternode=/ {print $1}' ${CONFIG})
LOCAL=$(merge-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    status=$(merge-cli getmasternodestatus|jq -r .message)
    if [[ "$status" != "Masternode successfully started" ]]; then
      LOCAL=$status
    fi
  fi
else
  LOCAL="problem"
fi
EXPLORER="https://explorer.projectmerge.org/api/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}')
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
