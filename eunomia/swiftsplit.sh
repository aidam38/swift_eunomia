#!/bin/sh

FILE=eunomia

./swiftsplit $FILE 400
tar -czf $FILE.tar.gz ${FILE}_[0-9]*
rm -r ${FILE}_[0-9]*


