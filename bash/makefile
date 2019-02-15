
# ----- Wireless -----

wlan-up:
	sudo ip link set wlan0 up
	sudo systemctl start wpa_supplicant@wlan0

wlan-down:
	sudo systemctl stop wpa_supplicant@wlan0
	sudo ip link set wlan0 down

wlan-scan:
	sudo ip link set wlan0 up
	sudo iw dev wlan0 scan | grep SSID

wlan-set:
	sudo ln -sf /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

wlan-add:
	wpa_passphrase '$(SSID)' '$(PASS)' > /tmp/wpa_supplicant-$(SSID).conf
	sudo mv /tmp/wpa_supplicant-$(SSID).conf /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf
	$(MAKE) wlan-set

wlan-list:
	cat /etc/wpa_supplicant/wpa_supplicant-*.conf | grep ssid

lan-scan:
	sudo arp-scan -l

# --- Share ---

SHARE_HOST=192.168.1.26/share
SHARE_PATH=/mnt/smb-share

mount-smb-share:
	@ sudo mount -t cifs -o username=nullptr,password=2662 //$(SHARE_HOST) $(SHARE_PATH)

umount-smb-share:
	sudo umount $(SHARE_PATH)

# --- Backups ---

BACKUPS_HOST=192.168.0.3/backups
BACKUPS_PATH=/mnt/smb-backups

mount-smb-backups:
	@ sudo mount -t cifs -o username=nullptr,password=2662 //$(BACKUPS_HOST) $(BACKUPS_PATH)

umount-smb-backups:
	sudo umount $(BACKUPS_PATH)


# --- Spkb Share ---

SP_SHARE_HOST=192.168.55.30/smb
SP_SHARE_PATH=/mnt/smb-spkb-share

mount-smb-spkb-share:
	@ mount -t cifs -o username=smb,password=mysmb //$(SP_SHARE_HOST) $(SP_SHARE_PATH)

umount-smb-spkb-share:
	umount $(SP_SHARE_PATH)

mount-phone:
	su -l nullptr -c "simple-mtpfs /mnt/phone"

umount-phone:
	umount /mnt/phone

# --- Battery ---

power-verbose:
	sudo upower -i $(shell upower -e | grep BAT)
	
power-info:
	sudo upower -i $(shell upower -e | grep BAT) | grep --color=never -E "state|to full|to empty|percentage"


# --- Mount USB ---

mount-usb:
	sudo mount /dev/sdb1 /mnt/usb -o uid=nullptr,gid=nullptr

umount-usb:
	sudo umount /mnt/usb

mount-ssh:
	sshfs srv.remote:/home/nullptr /mnt/srv
umount-ssh:
	sudo umount /mnt/srv

mount-cdrom:
	sudo mount -o loop -t iso9660 /dev/sr0 /mnt/cdrom

mount-win:
	sudo mount /dev/sda4 /mnt/win
umount-win:
	sudo umount /dev/sda4

# --- Updates ---
update:
	sudo apt-get update
	sudo apt-get upgrade


# --- Power ---
off:
	-systemctl poweroff 
lock:
	-i3lock -i ~/img/lock.png
sleep:
	-systemctl suspend
reboot:
	-systemctl reboot

# --- Wallpapers ---
img-prepare:
	sudo mkdir -p /usr/share/images/desktop-base/

change-background:
	sudo update-alternatives --config desktop-background
	feh --bg-scale /usr/share/images/desktop-base/desktop-background
add-background: img-prepare
	sudo cp $V /usr/share/images/desktop-base/$V
	sudo update-alternatives --install /usr/share/images/desktop-base/desktop-background desktop-background /usr/share/images/desktop-base/$V 50	
remove-background:
	sudo update-alternatives --remove desktop-background /usr/share/images/desktop-base/$V
	sudo rm /usr/share/images/desktop-base/$V

change-foreground:
	sudo update-alternatives --config desktop-grub
add-foreground: img-prepare
	sudo cp $V /usr/share/images/desktop-base/$V
	sudo update-alternatives --install /usr/share/images/desktop-base/desktop-grub desktop-grub /usr/share/images/desktop-base/$V 50
remove-foreground:
	sudo update-alternatives --remove desktop-grub /usr/share/images/desktop-base/$V
	sudo rm /usr/share/images/desktop-base/$V

change-user-logo:
	sudo update-alternatives --config user-logo
add-user-logo: img-prepare
	sudo cp $V /usr/share/images/desktop-base/$V
	sudo update-alternatives --install /usr/share/images/desktop-base/user-logo user-logo /usr/share/images/desktop-base/$V 50
remove-user-logo:
	sudo update-alternatives --remove user-logo /usr/share/images/desktop-base/$V
	sudo rm /usr/share/images/desktop-base/$V

# --- Monitor ---
#MON=VGA1
MON=HDMI1
monitor-up:
	xrandr --output $(MON) --auto --right-of LVDS1
	feh --bg-scale /usr/share/images/desktop-base/desktop-background
monitor-down:
	xrandr --output $(MON) --off

# --- Backups ---

V=srv.local:/home/nullptr

backup: backup-store
backup-store: backup-store-proj
backup-restore: backup-restore-proj

backup-store-proj:
	$(call _backup_store,proj)
backup-restore-proj:
	$(call _backup_restore,proj)

# makes directory backup store
# usage: $(call _backup_store, directory)
define _backup_store
	rsync -av --delete-during -e "ssh -o Compression=no" --exclude-from=.rsync-ignore.list $1/ $V/$1/
endef

# makes directory backup restore
# usage: $(call _backup_restore, directory)
define _backup_restore
	rsync -av -e "ssh -o Compression=no" --exclude-from=.rsync-ignore.list $V/$1/ $1/
endef


# --- GCC ---
change-gcc:
	sudo update-alternatives --config cc

# keyring

set-pass:
	@secret-tool store --label "pass" attr val
get-pass:
	@secret-tool lookup attr val | xclip -sel c
show-pass:
	@secret-tool lookup attr val
