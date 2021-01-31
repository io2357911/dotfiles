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

setup-luks:
	sudo cryptsetup -y -v luksFormat $(LUKS_PART)
	sudo cryptsetup luksOpen $(LUKS_PART) $(LUKS_NAME)
	sudo mkfs.ext4 /dev/mapper/$(LUKS_NAME)
	sudo mount /dev/mapper/$(LUKS_NAME) $(LUKS_MOUNT)
	sudo chown -R $(USER):$(USER) $(LUKS_MOUNT)
	sudo rm -rf $(LUKS_MOUNT)/lost+found
	sudo umount $(LUKS_MOUNT)
	sudo cryptsetup luksClose $(LUKS_NAME)
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

# backup

BACKUP_DIRS?=--include ~/luks/notes --include ~/luks/docs
BACKUP_LOCAL_DIR?=~/luks
BACKUP_REMOTE_DIR?=rclone://gdrive:/backups
#BACKUP_REMOTE_DIR?=file:///tmp/backup
BACKUP_RESTORE_DIR?=~/luks/backup
BACKUP_PASS?=
BACKUP_DT?=0D
#BACKUP_DT?=1M
#BACKUP_DT?=2020-10-20

backup:
	@PASSPHRASE=$(BACKUP_PASS) duplicity  \
		$(BACKUP_DIRS) \
		--exclude '**' \
		$(BACKUP_LOCAL_DIR) $(BACKUP_REMOTE_DIR) 
backup-list:
	@PASSPHRASE=$(BACKUP_PASS) duplicity collection-status $(BACKUP_REMOTE_DIR)
backup-restore:
	@PASSPHRASE=$(BACKUP_PASS) duplicity --force -t $(BACKUP_DT) $(BACKUP_REMOTE_DIR) $(BACKUP_RESTORE_DIR)
backup-rotate:
	@PASSPHRASE=$(BACKUP_PASS) duplicity remove-older-than $(DT) --force $(BACKUP_REMOTE_DIR) 

