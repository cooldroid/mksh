#!/bin/sh

NDK=/media/android/android-ndk-r10e
API=19
CC_LOC="${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64"
SYSPREFIX="${NDK}/platforms/android-${API}/arch-arm"
TRIPLE=`ls ${CC_LOC}/bin | grep -E "arm.+linux-.+gcc$" | awk -F-gcc '{print $1}'`

export PATH=${CC_LOC}/bin:$PATH
export CC="$CC_LOC/bin/${TRIPLE}-gcc --sysroot=${SYSPREFIX} -D__ANDROID_API__=$API"
export CXX="$CC_LOC/bin/${TRIPLE}-g++ --sysroot=${SYSPREFIX} -D__ANDROID_API__=$API"
export CPPFLAGS="-DMKSH_DEFAULT_EXECSHELL=\\\"/system/bin/sh\\\" -DMKSH_DEFAULT_TMPDIR=\\\"/data/local/tmp\\\" \
-DMKSH_DEFAULT_PROFILEDIR=\\\"/sbin/.core/img/cooldroid/etc\\\" -DMKSHRC_PATH=\\\"/system/etc/mkshrc\\\""

LDFLAGS="-static" CFLAGS="-Os -static" TARGET_OS=Android HAVE_STRLCPY=0 sh Build.sh -r -c lto

if [ -f ./mksh ]; then
	$CC_LOC/bin/${TRIPLE}-strip --strip-unneeded ./mksh
fi
if [ -d /sdcard/system/develop ]; then
	cp ./mksh /sdcard/system/develop/
fi
