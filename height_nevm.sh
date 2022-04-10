#!/bin/bash
EXPLORER="https://explorer.syscoin.org/api"
xblock=$(curl --silent -X GET "$EXPLORER?module=block&action=eth_block_number&id=1" -H "accept: application/json" | jq -r .result )
CHAINHIGH=$(( 16#${xblock/0x/} ))
local=$(syscoin-cli getnevmblockchaininfo)
height=$(echo $local | jq -r .height)
status=$(echo $local | jq -r .status)
if [[ $status == "online" ]]; then
  echo $height/$CHAINHIGH
else
  echo $status
fi
