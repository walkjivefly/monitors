#!/bin/bash
LOCAL=$(scc-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="https://www.coinexplorer.net/api/v1/SCC/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}block/latest 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq -r .result.height)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
