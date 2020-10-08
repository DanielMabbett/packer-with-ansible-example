#!/bin/bash

# Validation
ROOT=$(pwd)
DIRS=$(find . -type f -name '*.pkr.hcl' -printf '%h\n' | sort -u)

for i in $DIRS
do
    echo "[info] Validating: " ${i}
    cd ${i}
    packer validate .
    cd $ROOT
done
