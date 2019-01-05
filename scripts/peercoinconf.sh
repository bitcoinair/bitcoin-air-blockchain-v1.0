#!/bin/bash -ev

mkdir -p ~/.bitcoinair
echo "rpcuser=username" >>~/.bitcoinair/bitcoinair.conf
echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.bitcoinair/bitcoinair.conf

