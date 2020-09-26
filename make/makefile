# DO NOT EDIT!
# Add machine specific overrides and recipes to ~/local.mk
-include local.mk

# share

mount-share:
	$(call smb_mount,user,pass,/share-path,/mount-path)
umount-share:
	sudo umount /mount-path

define smb_mount
	@sudo mount -t cifs -o username=$1,password=$2,uid=io,gid=io //$3 $4
endef

# luks

LUKS_PART?=/dev/dummy
LUKS_NAME?=luks
LUKS_MOUNT?=$(LUKS_NAME)

mount-luks:
	sudo cryptsetup luksOpen $(LUKS_PART) $(LUKS_NAME)
	sudo mount /dev/mapper/$(LUKS_NAME) $(LUKS_MOUNT)
	-sudo systemctl start syncthing@$(USER)
umount-luks:
	-sudo systemctl stop syncthing@$(USER)
	sudo umount $(LUKS_MOUNT)
	sudo cryptsetup luksClose $(LUKS_NAME)

# second monitor

MONITOR_MAIN?=eDP1
MONITOR?=HDMI1
monitor-up:
	xrandr --output $(MONITOR) --auto --right-of $(MONITOR_MAIN)
monitor-down:
	xrandr --output $(MONITOR) --off
