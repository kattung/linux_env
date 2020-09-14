#!/bin/bash

function print_usage ()
{
    echo "usage: $0 kernel_dir to_dir version"
    echo "example: $0 ~/work/linux-mtl 0611-fix 201807"
    echo "the output directory will includes below files"
}

if [ -z $1 ] || [ -z $2 ]; then
	print_usage
	exit
fi

if [ ! -d $1 ]; then
    echo "ERROR: no such directory $1"
    exit
fi

if [ ! -d $2 ]; then
    if [ -f $2 ]; then
        echo "ERROR: Path '$2' is a file."
        echo "ERROR: Please indicate a directory for to_dir."
        exit
    else
        mkdir $2
    fi
fi

set -x

from_path=$1
to_path=$2
ver=$3

arch=arm64

if [ "$arch" == "arm" ]; then
    toolchain=arm-linux-gnueabi-
else
    toolchain=aarch64-linux-gnu-
fi

if [ "$arch" == "arm" ]; then
    cp $from_path/arch/$arch/boot/zImage $to_path
fi

cd $from_path
git_cmt=`git log --oneline -1 | awk -F" " '{print $1}'`
suffix=${ver}-${git_cmt}
cd -

cp $from_path/System.map $to_path
cp $from_path/.config $to_path/config
cp $from_path/vmlinux $to_path
${toolchain}objdump -d $to_path/vmlinux > $to_path/vmlinux.disa
gzip $to_path/vmlinux.disa

cp $from_path/arch/$arch/boot/Image $to_path/Image-A3900-${suffix}
cp $from_path/arch/$arch/boot/dts/xxx/xxx*.dtb $to_path

### rename dtb
cd ${to_path}
for i in *.dtb
do
    mv $i ${i%.dtb}-${suffix}.dtb
done

