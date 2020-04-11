# ip для подключения по ssh к домофону

INTERCOM_HOST=192.168.69.202

# целевая платформа -  arm | pc

TARGET=arm

# сборка - release | debug

BUILD=release

# версия прошивки

VERSION=2.0

# вспомогательные переменные

PATH_SCRIPT=$(shell pwd)
PATH_BUILD=build/firmware

SD=/dev/mmcblk1

# метаданные ipk пакетов

ARCH=armv7ahf-vfpv3
#ARCH=armv7ahf-neon
PACKAGE_PREFIX=20
PACKAGE_UPDATED_PREFIX=50


# build (сборка приложений)


compile:
	if [ ! -d build/$(TARGET)/$(BUILD) ]; then \
		mkdir -p build/$(TARGET)/$(BUILD) ; \
		cd build/$(TARGET)/$(BUILD) ; cmake ../../../ -DTARGET=$(TARGET) -DBUILD=$(BUILD) ; \
	fi
	cd build/$(TARGET)/$(BUILD) ; $(MAKE) -j8

clean:
	- rm -rf build/$(TARGET)/$(BUILD)

distclean:
	- sudo rm -rf build


# firmware (файл обновления через сервер cwmp)


clean-firm: clean-ipks
	- rm $(PATH_BUILD)/install
	- rm $(PATH_BUILD)/$(VERSION).tar.gz
	- rm $(PATH_BUILD)/*.ipk

build-firm: clean-firm compile build-ipks
	cp firmware/install $(PATH_BUILD)/
	cp firmware/ipks/*.ipk $(PATH_BUILD)/
	cd $(PATH_BUILD); tar -czvf $(VERSION).tar.gz install *.ipk

install-firm: build-firm
	scp $(PATH_BUILD)/$(VERSION).tar.gz root@$(INTERCOM_HOST):/tmp
	ssh root@$(INTERCOM_HOST) 'echo $(VERSION) > /tmp/version'

install-firm-force:
	#ssh root@$(INTERCOM_HOST) 'echo $(HOST) > /etc/hostname'
	#ssh root@$(INTERCOM_HOST) hostname -F /etc/hostname
	
	ssh root@$(INTERCOM_HOST) 'echo $(VERSION) > /etc/version'
	
	$(MAKE) install-voipd install-snmpd install-cwmpd install-updated install-misc


# images (образ для прошивки внутренней флеш "burn-nand")


build-rootfs: build-firm
	
	# clean 
	
	sudo rm -rf $(PATH_BUILD)/rootfs
	mkdir -pv $(PATH_BUILD)/rootfs
	
	# copy rootfs archives
		
	sudo tar xf firmware/rootfs.tar.gz -C $(PATH_BUILD)/rootfs
	sudo tar xf firmware/rootfs-misc.tar.gz -C $(PATH_BUILD)/rootfs
	
	# copy firmware update to install on startup
	
	sudo cp $(PATH_BUILD)/$(VERSION).tar.gz $(PATH_BUILD)/rootfs/opt/firmware-factory.tar.gz
	echo $(VERSION) | sudo tee $(PATH_BUILD)/rootfs/opt/version
	
	# create rootfs image to flash nand
	
	sudo mkfs.ubifs -q -r $(PATH_BUILD)/rootfs -m 2048 -e 126976 -c 2047 -o $(PATH_BUILD)/rootfs.ubifs.img

build-rootfs-burn-nand: build-rootfs
	
	# clean
	
	sudo rm -rf $(PATH_BUILD)/rootfs-burn-nand
	mkdir -pv $(PATH_BUILD)/rootfs-burn-nand
	
	# copy rootfs archives
		
	sudo tar xf firmware/rootfs.tar.gz -C $(PATH_BUILD)/rootfs-burn-nand
	sudo tar xf firmware/rootfs-misc.tar.gz -C $(PATH_BUILD)/rootfs-burn-nand
	echo $(VERSION) | sudo tee $(PATH_BUILD)/rootfs-burn-nand/etc/version
	
	# copy rootfs image
	
	sudo cp $(PATH_BUILD)/rootfs.ubifs.img $(PATH_BUILD)/rootfs-burn-nand/home/root

build-burn-nand: build-rootfs-burn-nand
	
	# create partitions
	-rm $(PATH_BUILD)/burn-nand-$(VERSION).img
	dd if=/dev/zero of=$(PATH_BUILD)/burn-nand-$(VERSION).img bs=512 count=573440
	-sudo losetup -d /dev/loop0
	sudo losetup /dev/loop0 $(PATH_BUILD)/burn-nand-$(VERSION).img
	sudo sfdisk -f -L /dev/loop0 < firmware/sdcard.sfdisk
	sudo losetup -d /dev/loop0
	sync && sleep 3
	sudo losetup -P /dev/loop0 $(PATH_BUILD)/burn-nand-$(VERSION).img
	
	# boot
	
	sudo mkfs.vfat -n BOOT -F32 /dev/loop0p1
	mkdir -p $(PATH_BUILD)/.boot
	sudo mount /dev/loop0p1 $(PATH_BUILD)/.boot
	sudo tar xf firmware/boot.tar.gz -C $(PATH_BUILD)/.boot
	sudo umount /dev/loop0p1
	rm -rf $(PATH_BUILD)/.boot
	
	# rootfs
	
	sudo mkfs.ext4 -F -L rootfs /dev/loop0p2
	mkdir -p $(PATH_BUILD)/.rootfs
	sudo mount /dev/loop0p2 $(PATH_BUILD)/.rootfs
	sudo rsync -a $(PATH_BUILD)/rootfs-burn-nand/ $(PATH_BUILD)/.rootfs/
	sudo umount /dev/loop0p2
	rm -rf $(PATH_BUILD)/.rootfs
	
	# clean
	
	sync
	sudo losetup -d /dev/loop0
	cd $(PATH_BUILD); 7za a burn-nand-$(VERSION).img.7z burn-nand-$(VERSION).img
	rm $(PATH_BUILD)/burn-nand-$(VERSION).img

install-burn-nand:
	cd $(PATH_BUILD); 7za x -so burn-nand-$(VERSION).img.7z | sudo dd of=$(SD) bs=4M
	sync

test-sfdisk:
	-rm burn-nand.img
	-sudo losetup -d /dev/loop0
	dd if=/dev/zero of=burn-nand.img bs=512 count=573440
	sudo losetup /dev/loop0 burn-nand.img
	sudo sfdisk -f -L /dev/loop0 < firmware/sdcard.sfdisk
	sudo losetup -d /dev/loop0
	sync && sleep 3
	sudo losetup -P /dev/loop0 burn-nand.img
	ls /dev | grep loop0p*

# packages


clean-ipks: clean-ipk-voipd clean-ipk-snmpd clean-ipk-cwmpd clean-ipk-updated clean-ipk-misc
build-ipks: build-ipk-voipd build-ipk-snmpd build-ipk-cwmpd build-ipk-updated build-ipk-misc
build-ipk:
	$(call build_ipk,$(PATH_BUILD),$(PACKAGE_PREFIX),$(PACKAGE),$(VERSION),$(DESC))


# daemons


clean-ipk-voipd:
	$(call clean_ipk,$(PATH_BUILD),voipd)
clean-ipk-snmpd:
	$(call clean_ipk,$(PATH_BUILD),snmpd)
clean-ipk-cwmpd:
	$(call clean_ipk,$(PATH_BUILD),cwmpd)
clean-ipk-updated:
	$(call clean_ipk,$(PATH_BUILD),updated)
clean-ipk-misc:
	$(call clean_ipk,ipks,stm32)
	$(call clean_ipk,ipks,alsa-config)
	$(call clean_ipk,ipks,startup-script)
	$(call clean_ipk,ipks,misc-files)

build-ipk-voipd: clean-ipk-voipd
	$(call build_ipk_daemon,voipd,$(PACKAGE_PREFIX))
build-ipk-snmpd: clean-ipk-snmpd
	$(call build_ipk_daemon,snmpd,$(PACKAGE_PREFIX))
build-ipk-cwmpd: clean-ipk-cwmpd
	$(call build_ipk_daemon,cwmpd,$(PACKAGE_PREFIX))
build-ipk-updated: clean-ipk-updated
	$(call build_ipk_daemon,updated,$(PACKAGE_UPDATED_PREFIX))
build-ipk-misc: clean-ipk-misc
	$(call build_ipk,firmware/ipks/ipk-stm32,20,stm32firmware,1.0,Firmware for stm32 intercom controller,$(PATH_BUILD))
	$(call build_ipk,firmware/ipks/ipk-alsa-config,01,alsa-config,1.0,Alsa controls config,$(PATH_BUILD))
	$(call build_ipk,firmware/ipks/ipk-startup-script,01,startup-script,1.0,Startup script,$(PATH_BUILD))
	$(call build_ipk,firmware/ipks/ipk-misc-files,01,misc-files,1.0,Misc rootfs files,$(PATH_BUILD))

install-voipd: build-ipk-voipd
	$(call install_ipk,voipd)
install-snmpd: build-ipk-snmpd
	$(call install_ipk,snmpd)
install-cwmpd: build-ipk-cwmpd
	$(call install_ipk,cwmpd)
install-updated: build-ipk-updated
	$(call install_ipk,updated)
install-misc: build-ipk-misc
	$(call install_ipk_misc,stm32)
	$(call install_ipk_misc,alsa-config)
	$(call install_ipk_misc,startup-script)
	$(call install_ipk_misc,misc-files)

run-voipd:
	$(call run_daemon,voipd)
run-snmpd:
	$(call run_daemon,snmpd)
run-cwmpd:
	$(call run_daemon,cwmpd)
run-updated:
	$(call run_daemon,updated)

log-voipd:
	$(call log_daemon,voipd)
log-snmpd:
	$(call log_daemon,snmpd)
log-cwmpd:
	$(call log_daemon,cwmpd)
log-updated:
	$(call log_daemon,updated)

kill-voipd:
	$(call kill_daemon,voipd)
kill-snmpd:
	$(call kill_daemon,snmpd)
kill-cwmpd:
	$(call kill_daemon,cwmpd)
kill-updated:
	$(call kill_daemon,updated)

# creates daemon ipk
# usage: $(call build_ipk_daemon,daemonName,prefix)
define build_ipk_daemon
	# prepare temp dir
	- rm -rf $(PATH_BUILD)/ipk
	mkdir -pv $(PATH_BUILD)/ipk/{control,data}
	cp -vr firmware/ipks/ipk-daemon/* $(PATH_BUILD)/ipk

	# fill template
	cd $(PATH_BUILD)/; mv ipk/data/etc/init.d/DAEMON ipk/data/etc/init.d/$1
	sed -i 's|DAEMON=|DAEMON=$1|g' $(PATH_BUILD)/ipk/data/etc/init.d/$1
	sed -i 's|DAEMON|$1|g' $(PATH_BUILD)/ipk/control/conffiles
	mkdir -p $(PATH_BUILD)/ipk/data/usr/sbin
	cp -v build/arm/$(BUILD)/$1/$1 $(PATH_BUILD)/ipk/data/usr/sbin

	sed -i 's|DAEMON|$1|g' $(PATH_BUILD)/ipk/control/postinst
	sed -i 's|DAEMON|$1|g' $(PATH_BUILD)/ipk/control/prerm

	# copy daemon specific overrides
	- cp -vr $1/ipk/control $(PATH_BUILD)/ipk/
	- cp -vr $1/ipk/data $(PATH_BUILD)/ipk/

	$(eval VER = $(shell cat $1/src/defines.h | grep DAEMON_VERSION | awk -F\" '{print $$2}'))
	$(eval DESC = $(shell cat $1/src/defines.h | grep DAEMON_DESCRIPTION | awk -F\" '{print $$2}'))

	$(call build_ipk,$(PATH_BUILD)/ipk,$2,$1,$(VER),$(DESC),$(PATH_BUILD))
endef

# creates ipk
# usage: $(call build_ipk,rootpath,prefix,packageName,version,description,destination)
define build_ipk
	# prepare control
	echo 'Package: $3' >  $1/control/control
	echo 'Version: $4' >> $1/control/control
	echo 'Architecture: $(ARCH)' >> $1/control/control
	echo 'Maintainer: io2357911@gmail.com' >> $1/control/control
	echo 'Provides: $3' >> $1/control/control
	echo 'Description: $5' >> $1/control/control
	cd $1/control; tar czvf control.tar.gz *
	mv -v $1/control/control.tar.gz $1

	# prepare data
	cd $1/data; tar czvf data.tar.gz *
	mv -v $1/data/data.tar.gz $1

	# prepare debian-binary
	echo 2.0 > $1/debian-binary

	# create package
	cd $1; ar r $2_$3_$4.ipk control.tar.gz data.tar.gz debian-binary
	mv $1/$2_$3_$4.ipk $6/

	# # clean
	rm -rf $1/{control.tar.gz,data.tar.gz,debian-binary} $1/control/control
endef

define clean_ipk
	- rm $1/*$2*.ipk
endef

define install_ipk
	scp $(PATH_BUILD)/*$1*.ipk root@$(INTERCOM_HOST):/tmp
	ssh root@$(INTERCOM_HOST) opkg --force-reinstall --force-downgrade install /tmp/*$1*.ipk

	ssh root@$(INTERCOM_HOST) rm /tmp/*$1*.ipk
endef

define install_ipk_misc
        scp ipks/*$1*.ipk root@$(INTERCOM_HOST):/tmp
        ssh root@$(INTERCOM_HOST) opkg --force-reinstall --force-downgrade install /tmp/*$1*.ipk

        ssh root@$(INTERCOM_HOST) rm /tmp/*$1*.ipk
endef

define run_daemon
	cd $(PATH_SCRIPT)/../$1/; build/pc/$(BUILD)/$1 -c $1.cfg -d
endef

define log_daemon
	while :; do cat /var/log/$(HOST)/$1.log; sleep 1; done
endef

define kill_daemon
	ssh root@$(INTERCOM_HOST) killall -9 $1
endef
