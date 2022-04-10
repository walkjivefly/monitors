#!/bin/bash
EXPLORER="https://www.coinexplorer.net/api/v1/SCC/"
CHAIN=$(curl --silent ${EXPLORER}block/latest 2>/dev/null)
if [[ $? -eq 0 ]]; then
  CHAINHIGH=$(echo $CHAIN | jq -r .result.height)
  [[ "$CHAINHIGH" == "null" ]] && CHAINHIGH="problem"
else
  CHAINHIGH="problem"
fi
LOCAL=$(scc-cli getblockcount 2>/dev/null)
[[ $? -ne 0 ]] && LOCAL="problem"
echo $LOCAL/$CHAINHIGH
