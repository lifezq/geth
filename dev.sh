# init personal eth service
geth init genesis.json
# start 
geth --rpc --rpcaddr=0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,admin,shh,txpool,debug,miner" --nodiscover --maxpeers 30 --networkid 1981 --port 30303 --mine --minerthreads 1 --etherbase "0x0000000000000000000000000000000000000001" console
# another shell terminal
geth attach

# create new account with password 123456 in console
> personal.newAccount("123456")
"0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92"
ls ~/.ethereum/keystore/UTC--2018-09-09T09-45-07.274497171Z--81ca02640287afaf7dc8e3dd200e4f66bfbb3d92 
/home/yql/.ethereum/keystore/UTC--2018-09-09T09-45-07.274497171Z--81ca02640287afaf7dc8e3dd200e4f66bfbb3d92
cat ~/.ethereum/keystore/UTC--2018-09-09T09-45-07.274497171Z--81ca02640287afaf7dc8e3dd200e4f66bfbb3d92
{"address":"81ca02640287afaf7dc8e3dd200e4f66bfbb3d92","crypto":{"cipher":"aes-128-ctr","ciphertext":"e8e67ee93463e9dc84d04fc3b8919d86d16bfac271e572a3c32054f624576e04","cipherparams":{"iv":"64765141cd7d234476b0a861a22edcb7"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"2b71661c8fb8648ee9e86ca90bccac9be429ed576b1fab11f3c13775c4ee6834"},"mac":"1deebaa3191d366a81641983f77c30d0961e12b66cd86c850f4dc93eefe40f64"},"id":"a7c2a949-7fc9-4d9f-94a7-a61417ab873d","version":3}

> personal.newAccount("123456")
"0x61d9e81b7ce4d80e3311cb52b73d27a5217a7166"
> eth.accounts
["0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92", "0x61d9e81b7ce4d80e3311cb52b73d27a5217a7166"]

# show account balance
> balance = web3.fromWei(eth.getBalance(eth.accounts[0]),"ether")
0
# miner set ether base reward account address
> miner.setEtherbase(eth.accounts[0])
true

# show if set success or not
> eth.coinbase
"0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92"

# miner start, param 1 represents the number of threads in mining
> miner.start(1)
null

> balance = web3.fromWei(eth.getBalance(eth.accounts[0]),"ether")
640
> miner.stop()
null

# unlock account
> personal.unlockAccount(eth.accounts[0],"123456")
true

# send transaction
> eth.sendTransaction({from:eth.accounts[0], to:eth.accounts[1],value: web3.toWei(1,"ether")})
"0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255"
# geth log INFO [09-09|18:07:37.145] Submitted transaction                    fullhash=0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255 recipient=0x61d9E81B7CE4D80E3311cB52B73D27a5217A7166

# show txpool status
> txpool.status
{
  pending: 1,
  queued: 0
}

# show transaction detail
> txpool.inspect.pending
{
  0x81cA02640287aFaf7dC8e3Dd200E4F66BfBB3D92: {
    0: "0x61d9E81B7CE4D80E3311cB52B73D27a5217A7166: 1000000000000000000 wei + 90000 gas × 1000000000 wei"
  }
}

# to be process transaction, we need start miner
> miner.start(1);admin.sleepBlocks(1);miner.stop();
null
# now the deal has been handled successfully, transactions have been successfully packaged and added to the blockchain,and eth.accounts[1] balance is 1
> balance = web3.fromWei(eth.getBalance(eth.accounts[1]),"ether")
1
# get transaction by hash
> eth.getTransaction("0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255")
{
  blockHash: "0x7f50d87f704f4c69e365453dee37e6b6cf1f578bcdaaf9ee310c9ef8e7a042f2",
  blockNumber: 886,
  from: "0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92",
  gas: 90000,
  gasPrice: 1000000000,
  hash: "0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255",
  input: "0x",
  nonce: 0,
  r: "0x2ef204eb645293f1c3936d3d52729d3b435e3a39b556992dfe844b28f09a14e9",
  s: "0x707d7633f1ff91eb49e57d5814a1442a16bd9b0b961eac051f83b1ee61f7f6a3",
  to: "0x61d9e81b7ce4d80e3311cb52b73d27a5217a7166",
  transactionIndex: 0,
  v: "0x41",
  value: 1000000000000000000
}

# get transaction receipt by hash
> eth.getTransactionReceipt("0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255")
{
  blockHash: "0x7f50d87f704f4c69e365453dee37e6b6cf1f578bcdaaf9ee310c9ef8e7a042f2",
  blockNumber: 886,
  contractAddress: null,
  cumulativeGasUsed: 21000,
  from: "0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92",
  gasUsed: 21000,
  logs: [],
  logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  root: "0x94c0a862429428494d8ba977c9b4e5676faf41905e322d6ecb8bd2a37db65953",
  to: "0x61d9e81b7ce4d80e3311cb52b73d27a5217a7166",
  transactionHash: "0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255",
  transactionIndex: 0
}

# show block number
> eth.blockNumber
886

# get latest block, params can be number/block hash
> eth.getBlock("latest")
{
  difficulty: 190083,
  extraData: "0xd88301080f846765746888676f312e31302e34856c696e7578",
  gasLimit: 7457786,
  gasUsed: 21000,
  hash: "0x7f50d87f704f4c69e365453dee37e6b6cf1f578bcdaaf9ee310c9ef8e7a042f2",
  logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  miner: "0x81ca02640287afaf7dc8e3dd200e4f66bfbb3d92",
  mixHash: "0x592eb3f1a6f095ad6522bfc73f3c27390fc427eb27a25d991a1c177114d65239",
  nonce: "0x474e8f3bd6305bfe",
  number: 886,
  parentHash: "0xe98532453489f9a9c5dc61fd9c9c61238d45a1720a1136d19e6ee4efdd601177",
  receiptsRoot: "0xe4412b39bf20decfd642877a9e41a5bd7121f3d10d72d8a4a5e4153a74dc975b",
  sha3Uncles: "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
  size: 651,
  stateRoot: "0x53d1fb2c9874a40b85157c097c6f92a8550ddfa6d247efada3ee5d8f1455911f",
  timestamp: 1536487942,
  totalDifficulty: 143898729,
  transactions: ["0xbcada3d263c64522f54f0365995e7777c37724e2d9aa0f644bb3e613c9aad255"],
  transactionsRoot: "0x2a09bbd9bb5a7def594c6550a68684eaa1abb05524afb099070a9f931cb2d472",
  uncles: []
}

