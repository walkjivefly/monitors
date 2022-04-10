#!/bin/bash
CONFIG="${HOME}/.scalaris/scalaris.conf"
NODETYPE=$(awk -F= '/^servicenode=/ {print $1}' ${CONFIG})
LOCAL=$(scalaris-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    status=$(scalaris-cli servicenodestatus|jq -r .[0].status)
    if [[ "$status" != "running" ]]; then
      LOCAL=$status
    fi
  fi
else
  LOCAL="problem"
fi
EXPLORER="https://explorer.scalaris.info/api/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk -F "\r" '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk -F "\r" '{$NF=""; print $0}')
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
