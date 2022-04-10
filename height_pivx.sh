#!/bin/bash
LOCAL=$(pivx-cli getblockcount)
if [[ $? -ne 0 ]]; then
  LOCAL="problem"
fi
EXPLORER="https://chainz.cryptoid.info/pivx/api.dws?q="
res=$(curl -w " %{http_code}" --silent ${EXPLORER}getblockcount 2>/dev/null)
if [[ $(echo $res|awk '{print $NF}') -eq 200 ]]; then
  EXPLORER=$(echo $res|awk '{$NF=""; print $0}')
else
  EXPLORER="problem"
fi
echo $LOCAL/$EXPLORER
