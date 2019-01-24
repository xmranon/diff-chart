#!/bin/bash

read -p "You ready to pull some motherFUCKING DATA? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
exit 1
fi

total=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_info","params":{"height":1}}' -H 'Content-Type: application/json' | jq '.result.height')

for i in `seq 1 $total`;

do
item=$i
a=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.difficulty') &
b=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.timestamp' | gawk '{print strftime("%c", $0)}') &
c=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.nonce') &
d=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.num_txs') &
e=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.reward') &
f=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.major_version') &
g=$(curl -s -X POST http://127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"getblock","params":{"height":'$i'}}' -H 'Content-Type: application/json' | jq '.result.block_header.block_size') &
echo $i','$a','$b','$c','$d','$e','$f','$g \ >> ~/Desktop/difficulty.csv
percent=$(awk "BEGIN { pc=100*${item}/${total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
clear
echo $percent

done

echo "All Done - now go get your shiz"
