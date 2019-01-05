#!/bin/bash
# create multiresolution windows icon
ICON_SRC=../../src/qt/res/icons/bitcoinair.png
ICON_DST=../../src/qt/res/icons/bitcoinair.ico
convert ${ICON_SRC} -resize 16x16 bitcoinair-16.png
convert ${ICON_SRC} -resize 32x32 bitcoinair-32.png
convert ${ICON_SRC} -resize 48x48 bitcoinair-48.png
convert bitcoinair-48.png bitcoinair-32.png bitcoinair-16.png ${ICON_DST}

