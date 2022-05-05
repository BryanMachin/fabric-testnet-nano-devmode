#!/usr/bin/env sh

# Set environment variables for the peer org

# look for binaries in local dev environment /build/bin directory and then in local samples /bin directory
export PATH="${PWD}"/../../fabric/build/bin:"${PWD}"/../bin:"$PATH"
export FABRIC_CFG_PATH="${PWD}"/../config

export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_TLS_ENABLED=false
export CORE_PEER_MSPCONFIGPATH="${PWD}"/crypto-config/msp
export CORE_PEER_ADDRESS=127.0.0.1:7051
export CORE_PEER_LOCALMSPID=SampleOrg