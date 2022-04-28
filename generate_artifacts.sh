#!/usr/bin/env sh
set -eu

# remove existing artifacts, or proceed on if the directories don't exist
echo "Removing existing artifacts"
rm -r "${PWD}"/channel-artifacts || true
rm -r "${PWD}"/data || true

# look for binaries in local dev environment /build/bin directory and then in local samples /bin directory
export PATH="${PWD}"/../../fabric/build/bin:"${PWD}"/../bin:"$PATH"

# set FABRIC_CFG_PATH to configtx.yaml directory that contains the profiles
export FABRIC_CFG_PATH="${PWD}/crypto-config"

echo "Generating orderer genesis block"
configtxgen -profile SampleDevModeSolo -channelID syschannel -outputBlock channel-artifacts/genesis.block

echo "Generating channel create config transaction"
configtxgen -channelID mychannel -outputCreateChannelTx channel-artifacts/mychannel.tx -profile SampleSingleMSPChannel
