#!/bin/sh
#chmod +x Build.sh
PATH=~/arm-uclibc/bin:$PATH
LD_LIBRARY_PATH=~/arm-uclibc/lib:$LD_LIBRARY_PATH
CROSS_COMPILE=~/arm-uclibc/bin/arm-buildroot-linux-uclibcgnueabi-
CC=arm-buildroot-linux-uclibcgnueabi-gcc TARGET_OS=Android CFLAGS=-Os MKSHRC_PATH=/system/etc/mkshrc LDSTATIC=-static sh Build.sh -r -c lto && ./test.sh
${CROSS_COMPILE}strip --strip-unneeded ./mksh
if [ -d /sdcard/system/develop ]; then
	cp ./mksh /sdcard/system/develop/
fi
