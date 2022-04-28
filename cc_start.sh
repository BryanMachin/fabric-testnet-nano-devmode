#!/usr/bin/env sh
set -eu

# imports
. ./env.sh

CC_NAME="mycc:1.0"

echo "starting chaincode"
CORE_CHAINCODE_LOGLEVEL=debug CORE_CHAINCODE_ID_NAME=mycc:1.0 ./chaincodes/mychaincode -peer.address 127.0.0.1:7052