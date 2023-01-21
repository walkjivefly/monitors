#!/bin/bash
CONFIG="${HOME}/.stakecubecoin/stakecubecoin.conf"
NODETYPE=$(awk -F= '/^masternodeblsprivkey=/ {print $1}' ${CONFIG})
LOCAL=$(scc-cli getblockcount)
if [[ $? -eq 0 ]]; then
  if [[ -n ${NODETYPE} ]]; then
    MNSTATUS=$(scc-cli masternode status)
    status=$(echo $MNSTATUS|jq -r .status)
    penalty=$(echo $MNSTATUS|jq -r .dmnState.PoSePenalty)
    banned=$(echo $MNSTATUS|jq -r .dmnState.PoSeBanHeight)
    if [[ $penalty != "0" || $banned != "-1" ]]; then
      LOCAL="PoSe"
    elif [[ "$status" != "Ready" ]]; then
      LOCAL=$status
    fi
  fi
else
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
