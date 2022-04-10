#!/bin/bash
LOCAL=$(raven-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="https://api.ravencoin.org/api/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}status 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq -r .info.blocks)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
