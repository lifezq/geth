geth init genesis.json
geth --rpc --rpcaddr=0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,admin,shh,txpool,debug,miner" --nodiscover --maxpeers 30 --networkid 1981 --port 30303 --mine --minerthreads 1 --etherbase "0x0000000000000000000000000000000000000001" console
