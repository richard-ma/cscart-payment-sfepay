#!/bin/sh

ADDON_NAME=$1

cd $ADDON_NAME
tar -zcvf $ADDON_NAME.tar.gz $ADDON_NAME
mv $ADDON_NAME.tar.gz ..
cd ..
