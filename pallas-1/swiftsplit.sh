#!/bin/sh

FILE=pallas-1

./swiftsplit $FILE 100
tar -czf $FILE.tar.gz ${FILE}_[0-9]*
rm -r ${FILE}_[0-9]*


