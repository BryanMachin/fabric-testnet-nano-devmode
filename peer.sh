#!/usr/bin/env sh
set -eu

# imports
. ./env.sh

export FABRIC_LOGGING_SPEC=chaincode=debug
export CORE_PEER_CHAINCODELISTENADDRESS=127.0.0.1:7052
export CORE_OPERATIONS_LISTENADDRESS=127.0.0.1:8446
export CORE_PEER_FILESYSTEMPATH="${PWD}"/data/peer0.org1.example.com
export CORE_LEDGER_SNAPSHOTS_ROOTDIR="${PWD}"/data/peer0.org1.example.com/snapshots

# uncomment the lines below to utilize couchdb state database, when done with the environment you can stop the couchdb container with "docker rm -f worldstate"
# export CORE_LEDGER_STATE_STATEDATABASE=CouchDB
# export CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=127.0.0.1:5984
# export CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=admin
# export CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=adminpw
# docker run --publish 5984:5984 --detach -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=adminpw --name worldstate couchdb:3.1.1


# en git bash, cmd o powershell usamos .exe de fabric
if [ "$(uname)" = "Linux" ] ; then
  binary=peer
else
  binary=peer.exe
fi

# start peer node in development mode
"${binary}" node start --peer-chaincodedev=true
