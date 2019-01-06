#!/bin/bash

VERSION=$1

if [[ -n "$VERSION" ]]; then
	echo ${VERSION}
else
    echo "argument error, provide commit, branch or tag"
	exit
fi

cd /gitian-builder/

./bin/gbuild --commit bitcoinair=${VERSION} ../bitcoinair/contrib/gitian-descriptors/gitian-linux.yml
pushd build/out
zip -r bitcoinair-${VERSION}-linux-gitian.zip *
mv bitcoinair-${VERSION}-linux-gitian.zip /bitcoinair/
popd

./bin/gbuild --commit bitcoinair=${VERSION} ../bitcoinair/contrib/gitian-descriptors/gitian-win.yml
pushd build/out
zip -r bitcoinair-${VERSION}-win-gitian.zip *
mv bitcoinair-${VERSION}-win-gitian.zip /bitcoinair/
popd

./bin/gbuild --commit bitcoinair=${VERSION} ../bitcoinair/contrib/gitian-descriptors/gitian-osx.yml
pushd build/out
zip -r bitcoinair-${VERSION}-osx-gitian.zip *
mv bitcoinair-${VERSION}-osx-gitian.zip /bitcoinair/
popd

echo "build complete, files are in /bitcoinair/ directory"
