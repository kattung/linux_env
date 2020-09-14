#!/bin/bash

file=$1

function print_usage () {
    echo "usage: $0 <file>"
    exit
}


if [ -z $1 ]; then
    print_usage
fi

sed -i 's/\x1b\[[0-9;]*m//g' $file
tr -d '\a\b\r' < $file > tmp
mv tmp $file
