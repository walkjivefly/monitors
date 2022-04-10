#!/bin/bash
LOCAL=$(bitcoin-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="https://blockchain.info/"
res=$(curl -w " %{http_code}" --silent "${EXPLORER}latestblock")
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}'|jq -r .height)
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
