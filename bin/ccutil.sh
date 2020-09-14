#!/bin/bash

#####################################################################
# CCUtil (Cross Compiler Utiltiy)
# Author: Raymond Huang <rhuang@rhuang.com>
####################################################################

alias lscc='cat -n ~/.cclist'
alias lsp='echo PATH=$PATH'
alias dqp='dqp-silent; lsp'
alias dqp-silent='export PATH=${PATH#*:}'
alias savp='export CCUTIL_SAVED_PATH=${PATH}; echo "CCUTIL_SAVED_PATH=${PATH}"'
alias arm='ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-'
alias armeabi='ARCH=arm CROSS_COMPILE=arm-eabi-'
alias armcs='ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-'
alias armuc='ARCH=arm CROSS_COMPILE=arm-uclinuxeabi-'

savp

index=1
while read line; do
#echo $line # or whaterver you want to do with the $line variable
	alias usecc$index='export PATH='$line':${CCUTIL_SAVED_PATH}; lsp'
	index=$((index + 1))
done < ~/.cclist
