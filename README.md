# Fabric DEVMODE - Nano bash
# _1 ORG + 1 PEER + 1 ORDERER_

Based on fabric-samples/test-network-nano-bash, but using [devmode](https://hyperledger-fabric.readthedocs.io/en/release-2.4/peer-chaincode-devmode.html?highlight=devmode) fabric peer

# Prereqs

- Follow the Fabric documentation for the [Prereqs](https://hyperledger-fabric.readthedocs.io/en/release-2.2/prereqs.html)
- Follow the Fabric documentation for [downloading the Fabric samples and binaries](https://hyperledger-fabric.readthedocs.io/en/release-2.2/install.html). You can skip the docker image downloads by using `curl -sSL https://bit.ly/2ysbOFE | bash -s -- -d`

# Instructions for starting network

Open terminal windows for 1 ordering node, 1 peer node, and 1 peer admin. The peer and peer admins belong to Org1.

The following instructions will have you run simple bash scripts that set environment variable overrides for a component and then runs the component.
The scripts contain only simple single-line commands so that they are easy to read and understand.
If you have trouble running bash scripts in your environment, you can just as easily copy and paste the individual commands from the script files instead of running the script files.

- cd to the `test-network-devmode` directory in each terminal window
- In the first terminal, run `./generate_artifacts.sh` to generate crypto material (calls cryptogen) and system and application channel genesis block and configuration transactions (calls configtxgen). The artifacts will be created in the `crypto-config` and `channel-artifacts` directories.
- In the orderer terminal, run `./orderer.sh`
- In the peer terminal, run `./peer.sh`
- Note that orderer and peer write their data (including their ledgers) to their own subdirectory under the `data` directory
- In the peer admin terminal, run `source peeradmin.sh`

Note the syntax of running the scripts. The peer admin scripts run with the `source` command in order to source the script files in the respective shells. This is important so that the exported environment variables can be utilized by any subsequent user commands.

The `peeradmin.sh` script sets the peer admin environment variables, creates the application channel `mychannel`, updates the channel configuration for the org1 gossip anchor peer, and joins peer to `mychannel`.
The remaining peer admin scripts join their respective peers to `mychannel`.

# Instructions for deploying and running the basic asset transfer sample go chaincode

To deploy and invoke the chaincode, utilize the peer admin terminal that you have created in the prior steps.

## 1. Build the chaincode
```go
// we move to the chaincode directory (ex: cd chaincodes/chaincode-go/)
cd chaincodes/chaincode-go

// in linux
go build -o mychaincode
	
// in windows	
go build -o mychaincode.exe
```



## 1. Start the chaincode

Run the following batch script to start the chaincode and connect it to the peer:

```
sh cc_start.sh
```

## 2. Approve and commit the chaincode definition

Run the following batch script to approve and commit the chaincode definition to the channel:
```
sh cc_approve_commit.sh
```

```go
// we copy to the chaincode binary to chaincodes/ folder
mv chaincodes/chaincode-go/mychaincode chaincodes/
```

The command will return output similar to the following:
```
...
committed with status (VALID) at 127.0.0.1:7051
```

## Interact with the chaincode

Invoke the chaincode to create an asset.
Then query the asset, update it, and query again to see the resulting asset changes on the ledger. Note that you need to wait a bit for invoke transactions to complete.

```
// InitLedger: adds a base set of assets to the ledger.
CORE_PEER_ADDRESS=127.0.0.1:7051 peer chaincode invoke -o 127.0.0.1:7050 -C mychannel -n mycc -c '{"Args":["InitLedger"]}'

// CreateAsset: issues a new asset to the world state with given details.
CORE_PEER_ADDRESS=127.0.0.1:7051 peer chaincode invoke -o 127.0.0.1:7050 -C mychannel -n mycc -c '{"Args":["CreateAsset", "id1", "verde", "10", "kmilo", "1"]}'

// ReadAsset: returns the asset stored in the world state with given id.
CORE_PEER_ADDRESS=127.0.0.1:7051 peer chaincode invoke -o 127.0.0.1:7050 -C mychannel -n mycc -c '{"Args":["ReadAsset", "id1"]}'

// UpdateAsset: updates an existing asset in the world state with provided parameters.
CORE_PEER_ADDRESS=127.0.0.1:7051 peer chaincode invoke -o 127.0.0.1:7050 -C mychannel -n mycc -c '{"Args":["UpdateAsset", "id1", "negro", "10", "kmilo", "1"]}'
```

Congratulations, you have deployed a minimal Fabric network! Inspect the scripts if you would like to see the minimal set of commands that were required to deploy the network.

Utilize `Ctrl-C` in the orderer and peer terminal windows to kill the orderer and peer processes. You can run the scripts again to restart the components with their existing data, or run `./generate_artifacts` again to clean up the existing artifacts and data if you would like to restart with a clean environment.

Note: The benefit of running the peer in DevMode is that you can now iteratively make updates to your smart contract, save your changes, build the chaincode, and then start it again using the steps above. You do not need to run the peer lifecycle commands to update the chaincode every time you make a change.
