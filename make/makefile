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

# second monitor

MONITOR_MAIN?=eDP1
MONITOR?=HDMI1
monitor-up:
	xrandr --output $(MONITOR) --auto --right-of $(MONITOR_MAIN)
monitor-down:
	xrandr --output $(MONITOR) --off

# backup

BACKUP_DIRS?=--include ~/notes --include ~/docs
BACKUP_LOCAL_DIR?=~
BACKUP_REMOTE_DIR?=rclone://gdrive:/backups
#BACKUP_REMOTE_DIR?=file:///tmp/backup
BACKUP_RESTORE_DIR?=backup
BACKUP_PASS=$(shell secret-tool lookup backup pass)
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
