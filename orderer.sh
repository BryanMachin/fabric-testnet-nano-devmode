#!/usr/bin/env sh
set -eu

# imports
. ./env.sh

export ORDERER_GENERAL_BOOTSTRAPFILE="${PWD}"/channel-artifacts/genesis.block

if [ ! -f "${ORDERER_GENERAL_BOOTSTRAPFILE}" ]; then
	echo "==> There is no genesis block, make sure you run the generate-artifacts script first."
	return 1
fi

export FABRIC_LOGGING_SPEC=debug:cauthdsl,policies,msp,common.configtx,common.channelconfig=info
export ORDERER_GENERAL_TLS_ENABLED=false
export ORDERER_FILELEDGER_LOCATION="${PWD}"/data/orderer
export ORDERER_GENERAL_LOCALMSPDIR="${PWD}"/crypto-config/msp
# used in metrics
export ORDERER_METRICS_PROVIDER=prometheus
export ORDERER_OPERATIONS_LISTENADDRESS=0.0.0.0:9443

# start orderer in development mode
ORDERER_GENERAL_GENESISPROFILE=SampleDevModeSolo orderer


