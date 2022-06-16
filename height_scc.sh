#!/bin/bash
LOCAL=$(scc-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="http://79.143.186.234/api/"                   # Iquidus alternative
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq -r .)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
