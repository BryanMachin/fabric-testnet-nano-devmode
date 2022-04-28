#!/usr/bin/env sh

# imports
. ./env.sh

peer channel create -o 127.0.0.1:7050 -c mychannel -f "${PWD}"/channel-artifacts/mychannel.tx --outputBlock "${PWD}"/channel-artifacts/mychannel.block

# Now join the peer to the channel 
echo "join the peer to the channel"
peer channel join -b "${PWD}"/channel-artifacts/mychannel.block
