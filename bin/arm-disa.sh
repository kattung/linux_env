#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: $0 machine_code"
	echo "example: $0 e12fff1e"
	exit
fi

tmp=tmp.bin

echo $1 | sed -e 's/\(..\)\(..\)\(..\)\(..\)/0x\4\3\2\1/'| xxd -r > $tmp
arm-linux-gnueabihf-objdump -D -b binary -m arm $tmp

rm $tmp
