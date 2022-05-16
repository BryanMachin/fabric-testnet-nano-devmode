#!/usr/bin/env sh
set -eu

# imports
. ./env.sh

export FABRIC_LOGGING_SPEC=chaincode=debug
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ID=peer0.org1.example.com
export CORE_PEER_LISTENADDRESS=0.0.0.0:7051
export CORE_PEER_CHAINCODEADDRESS=127.0.0.1:7052
export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052
# gossip
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=127.0.0.1:7051
export CORE_PEER_GOSSIP_BOOTSTRAP=127.0.0.1:7051
export CORE_PEER_FILESYSTEMPATH="${PWD}"/data/peer0.org1.example.com
export CORE_LEDGER_SNAPSHOTS_ROOTDIR="${PWD}"/data/peer0.org1.example.com/snapshots
# used in metrics
export CORE_METRICS_PROVIDER=prometheus
export CORE_OPERATIONS_LISTENADDRESS=0.0.0.0:8446


# uncomment the lines below to utilize couchdb state database, when done with the environment you can stop the couchdb container with "docker rm -f worldstate"
#export CORE_LEDGER_STATE_STATEDATABASE=CouchDB
#export CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=127.0.0.1:5984
#export CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=portainer
#export CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=N@rut0
## remove the container only if it exists
#CONTAINER_NAME=$(docker ps -aqf "NAME=worldstate")
#if [ -z "$CONTAINER_NAME" -o "$CONTAINER_NAME" == " " ]; then
#	echo "---- No world-state container available for deletion ----"
#else
#	docker rm -f $CONTAINER_NAME
#fi
#docker run --publish 5984:5984 --detach -e COUCHDB_USER=portainer -e COUCHDB_PASSWORD=N@rut0 --name worldstate couchdb:3.1.1

# start peer node in development mode
peer node start --peer-chaincodedev=true
