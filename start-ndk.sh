#!/bin/sh

CC_LOC="/media/android/toolchain/ndk-aarch64-linux-android"
TRIPLE=`ls ${CC_LOC}/bin | grep -E "aarch64.+linux-.+gcc$" | awk -F-gcc '{print $1}'`

export PATH=${CC_LOC}/bin:$PATH
export CC="$CC_LOC/bin/${TRIPLE}-gcc"
export CXX="$CC_LOC/bin/${TRIPLE}-g++"
export CPPFLAGS="-DMKSH_DEFAULT_EXECSHELL=\\\"/system/bin/sh\\\" -DMKSH_DEFAULT_TMPDIR=\\\"/data/local/tmp\\\" \
-DMKSHRC_PATH=\\\"/system/etc/mkshrc\\\""

CFLAGS="-fPIE -Os" LDFLAGS="-fPIE -pie" TARGET_OS=Android HAVE_STRLCPY=0 sh Build.sh -r -c lto

if [ -f ./mksh ]; then
	$CC_LOC/bin/${TRIPLE}-strip --strip-unneeded ./mksh
fi
if [ -d /sdcard/system/develop ]; then
	cp ./mksh /sdcard/system/develop/
fi
