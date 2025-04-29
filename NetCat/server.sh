#!/bin/bash
if [ -d recd ]; then
        rm -rf recd
fi
mkdir recd
nc -l 250 > "recd/aaa"
