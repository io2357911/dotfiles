# Share

SHARE_HOST=192.168.0.1/share
SHARE_PATH=/mnt/share
SHARE_USER=user
SHARE_PASS=pass

mount-share:
	@ sudo mount -t cifs -o username=$(SHARE_USER),password=$(SHARE_PASS) //$(SHARE_HOST) $(SHARE_PATH)

umount-share:
	sudo umount $(SHARE_PATH)

# Second monitor

MONITOR_MAIN=eDP1
MONITOR=HDMI1
monitor-up:
	xrandr --output $(MONITOR) --auto --right-of $(MONITOR_MAIN)
monitor-down:
	xrandr --output $(MONITOR) --off
