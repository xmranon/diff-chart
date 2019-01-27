#!/bin/bash

total=$(curl -s -X POST http://127.0.0.1:17566/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_info","params":{"height":1}}' -H 'Content-Type: application/json' | jq '.result.height')

file=~/Desktop/BlockchainDataExtract.csv
if [ ! -e "$file" ]; then
echo "Height" ',' "Difficulty" ',' "Timestamp" ',' "Nonce" ',' "Transactions"  \ >> ~/Desktop/BlockchainDataExtract.csv
chmod 777 ~/Desktop/BlockchainDataExtract.csv
lines=$(1)
else
lines=$(wc -l < ~/Desktop/BlockchainDataExtract.csv)
fi

for i in `seq $lines $total`;

do
item=$i
a=$(curl -s -X POST http://127.0.0.1:17566/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.difficulty')
b=$(curl -s -X POST http://127.0.0.1:17566/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.timestamp' | gawk '{print strftime("%c", $0)}')
c=$(curl -s -X POST http://127.0.0.1:17566/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.nonce')
d=$(curl -s -X POST http://127.0.0.1:17566/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.num_txes')
echo $i','$a','$b','$c','$d \ >> ~/Desktop/BlockchainDataExtract.csv

percent=$(awk "BEGIN { pc=100*${item}/${total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
clear
echo $i

done

echo "All Done - now go get your shiz"
