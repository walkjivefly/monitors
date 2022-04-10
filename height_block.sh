#!/bin/bash
CONFIG="${HOME}/.blocknet/blocknet.conf"
NODETYPE=$(awk -F= '/^servicenode=/ {print $1}' ${CONFIG})
LOCAL=$(blocknet-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    status=$(blocknet-cli servicenodestatus|jq -r .[0].status)
    if [[ "$status" != "running" ]]; then
      LOCAL=$status
    fi
  fi
else
  LOCAL="problem"
fi
EXPLORER="https://chainz.cryptoid.info/block/api.dws?q="
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}')
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
