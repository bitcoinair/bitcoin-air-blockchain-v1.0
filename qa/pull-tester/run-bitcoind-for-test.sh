#!/bin/bash
DATADIR="/media/root/Data1/Projects/qt/bitcoin-air-blockchain-v1.0/.bitcoin"
rm -rf "$DATADIR"
mkdir -p "$DATADIR"/regtest
touch "$DATADIR/regtest/debug.log"
tail -q -n 1 -F "$DATADIR/regtest/debug.log" | grep -m 1 -q "Done loading" &
WAITER=$!
"/media/root/Data1/Projects/qt/bitcoin-air-blockchain-v1.0/src/bitcoind" -connect=0.0.0.0 -datadir="$DATADIR" -rpcuser=user -rpcpassword=pass -listen -keypool=3 -debug -logtimestamps -port=18444 -regtest &
BITCOIND=$!

#Install a watchdog.
(sleep 10 && kill -0 $WAITER 2>/dev/null && kill -9 $BITCOIND $$)&
wait $WAITER

if [ -n "$TIMEOUT" ]; then
  timeout "$TIMEOUT"s "$@"
  RETURN=$?
else
  "$@"
  RETURN=$?
fi

(sleep 15 && kill -0 $BITCOIND 2>/dev/null && kill -9 $BITCOIND $$)&
kill $BITCOIND && wait $BITCOIND

# timeout returns 124 on timeout, otherwise the return value of the child
exit $RETURN
