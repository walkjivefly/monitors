#!/bin/bash
CONFIG="${HOME}/.crown/crown.conf"
NODETYPE=$(awk -F= '/^systemnode=|^masternode=/ {print $1}' ${CONFIG})
LOCAL=$(crown-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    status=$(crown-cli ${NODETYPE} status|jq -r .status)
    if [[ "$status" != "${NODETYPE^} successfully started" ]]; then
      LOCAL=$status
    fi
  fi
else
  LOCAL="problem"
fi
EXPLORER="https://chainz.cryptoid.info/crw/api.dws?q="
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}')
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
