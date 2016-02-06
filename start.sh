#!/bin/sh
#chmod +x Build.sh
CC="$(which klcc)" TARGET_OS=Android CFLAGS=-Os MKSHRC_PATH=/system/etc/mkshrc LDSTATIC=-static sh Build.sh -r -c lto && ./test.sh
strip --strip-unneeded ./mksh
if [ -d /sdcard/system/develop/ ]; then
	cp ./mksh /sdcard/system/develop/
fi
