#!/usr/bin/env sh
set -eu

# imports
. ./env.sh

export FABRIC_LOGGING_SPEC=debug:cauthdsl,policies,msp,common.configtx,common.channelconfig=info
export ORDERER_GENERAL_TLS_ENABLED=false
export ORDERER_GENERAL_BOOTSTRAPFILE="${PWD}"/channel-artifacts/genesis.block
export ORDERER_FILELEDGER_LOCATION="${PWD}"/data/orderer
export ORDERER_GENERAL_LOCALMSPDIR="${PWD}"/crypto-config/msp

# en git bash, cmd o powershell usamos .exe de fabric
if [ "$(uname)" = "Linux" ] ; then
  binary=orderer
else
  binary=orderer.exe
fi

# start orderer in development mode
ORDERER_GENERAL_GENESISPROFILE=SampleDevModeSolo "${binary}"


