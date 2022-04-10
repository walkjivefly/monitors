#!/bin/bash
LOCAL=$(verge-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="https://verge-blockchain.info/api/"
res=$(curl -w " %{http_code}" --silent ${EXPLORER}blockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq .data.blockcount)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
