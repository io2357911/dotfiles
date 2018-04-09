#!/bin/bash

ARCH=amd64
OS=debian
DISTRO=stretch
TARGET=/mnt

preinst() {
	debootstrap --arch $ARCH --variant=minbase $DISTRO $TARGET

	mount -o bind /dev $TARGET/dev
	mount -o bind /sys $TARGET/sys
}

confinst() {
	cp -vr conf/* $TARGET/
}

postinst() {
	cp ./postinst.sh $TARGET/
	env LANG=C env HOME=/root chroot $TARGET /bin/bash /postinst.sh
	rm $TARGET/postinst.sh
}

preinst
confinst
postinst
