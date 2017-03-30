
# ----- Wireless -----

wlan-up:
	ip link set wlan0 up
	systemctl start wpa_supplicant@wlan0

wlan-down:
	systemctl stop wpa_supplicant@wlan0
	ip link set wlan0 down

wlan-scan:
	ip link set wlan0 up
	iw dev wlan0 scan | grep SSID

wlan-set:
	ln -sf /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

wlan-add:
	wpa_passphrase '$(SSID)' '$(PASS)' > /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf
	$(MAKE) wlan-set

wlan-list:
	cat /etc/wpa_supplicant/wpa_supplicant-*.conf | grep ssid


# --- Share ---

SHARE_HOST=192.168.0.26/share
SHARE_PATH=/mnt/smb-share

mount-smb-share:
	@ mount -t cifs -o username=pi,password=2662 //$(SHARE_HOST) $(SHARE_PATH)

umount-smb-share:
	umount $(SHARE_PATH)

# --- Backups ---

BACKUPS_HOST=192.168.0.3/backups
BACKUPS_PATH=/mnt/smb-backups

mount-smb-backups:
	@ mount -t cifs -o username=nullptr,password=2662 //$(BACKUPS_HOST) $(BACKUPS_PATH)

umount-smb-backups:
	umount $(BACKUPS_PATH)


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
	upower -i $(shell upower -e | grep BAT)
	
power-info:
	upower -i $(shell upower -e | grep BAT) | grep --color=never -E "state|to full|to empty|percentage"

