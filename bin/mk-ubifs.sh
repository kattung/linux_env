#!/bin/bash

function print_usage
{
    echo "This script will create ubifs image from rootfs directory"
    echo "usage: $0 dir image"
    exit
}

if [ -z $1 ] || [ -z $2 ]; then
    print_usage
fi

dir=$1
image=$2

mkfs.ubifs -r $dir  -m 4KiB -e 248KiB -c 1900 -o $image -x zlib
# example
# ./mk-ubifs.sh rfs-buildroot-16.08.0-20180905/ rfs-buildroot-16.08.0-newboard-ubifs.img
