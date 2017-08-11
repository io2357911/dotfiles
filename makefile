
cfg: cfg-term cfg-de cfg-soft


# --- desktop environment configs ---


cfg-de: cfg-dm cfg-awesome cfg-i3wm

cfg-dm-old: cfg-img
	- sudo mkdir -p /etc/lightdm
	
	- sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.orig
	- sudo cp -v lightdm/lightdm.conf /etc/lightdm
	
	- sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.orig	
	- sudo cp -v lightdm/lightdm-gtk-greeter.conf /etc/lightdm

cfg-dm:
	sudo cp -rv slim/slim.conf /etc/slim.conf
	sudo cp -rv slim/nullptr /usr/share/slim/themes/

cfg-awesome: cfg-scripts cfg-img cfg-gtk
	- mkdir -p ~/.config/awesome
	
	sudo cp -vr awesome/snow /usr/share/awesome/themes/
		
	cp -vr awesome/debian ~/.config/awesome
	
	- cp -v ~/.xsessionrc ~/.xsessionrc.orig        
	cp -v awesome/.xsessionrc ~/
	
	- cp -v ~/.config/awesome/rc.lua ~/.config/awesome/rc.lua.orig
	cp -v awesome/rc.lua ~/.config/awesome
	cp -v awesome/tweaks.lua ~/.config/awesome

#battery  config  .i3blocks.conf  .i3status.conf  kbd
cfg-i3wm:
	mkdir -p ~/.i3 
	cp -v i3wm/config ~/.i3/config
	cp -v i3wm/.i3status.conf ~/.i3status.conf
	
	cp -v i3wm/.i3blocks.conf ~/.i3blocks.conf
	cp -v i3wm/battery ~/.i3/battery
	cp -v i3wm/kbd ~/.i3/kbd
	
	-cp -v ~/.xsessionrc ~/.xsessionrc.orig        
	cp -v i3wm/.xsessionrc ~/
	
	sudo mkdir -pv /etc/X11/xorg.conf.d/
	sudo cp i3wm/10-monitor.conf /etc/X11/xorg.conf.d/
	sudo cp i3wm/xorg.conf /etc/X11/xorg.conf
	
	sudo cp i3wm/i3lock.service /etc/systemd/system/
	sudo systemctl enable i3lock.service

cfg-img:
	mkdir -p ~/img
	cp -Pv img/* ~/img
	
cfg-scripts:
	- mkdir -p ~/.local/bin
	cp scripts/* ~/.local/bin

cfg-gtk:
	- cp ~/.gtkrc-2.0 ~/.gtkrc-2.0.orig
	cp gtk/.gtkrc-2.0 ~/	

cfg-soft:
	sudo cp -vr wps/ms-truetype /usr/share/fonts

cfg-quartus:
	mkdir -p ~/.local/bin
	cp quartus/quartus ~/.local/bin/quartus
	
	sudo cp -v quartus/51-usbblaster.rules /etc/udev/rules.d
	sudo udevadm control --reload-rules


# --- terminal tweaks configs ---


cfg-term: cfg-terminator cfg-bash cfg-tmux cfg-vim cfg-mc cfg-root cfg-rsync

cfg-terminator:
	- mkdir -p ~/.config/terminator
	- cp ~/.config/terminator ~/.config/terminator.orig
	cp -v terminator/config ~/.config/terminator

cfg-bash:
	- cp ~/.bashrc ~/.bashrc.orig
	cp bash/.bashrc ~/
	#sudo cp bash/.bashrc /root	
	cp bash/makefile ~/
	sudo cp bash/keyboard /etc/default/keyboard

cfg-tmux:
	cp tmux/.tmux.conf ~/
	
	mkdir -p ~/.tmux
	git clone https://github.com/tmux-plugins/tmux-resurrect.git ~/.tmux/resurrect
	cd ~/.tmux/resurrect ; git checkout 3a31bfbbb835c3d32f25702182cb5deab2a612ae
	cp -v tmux/fix_first_window_name.patch ~/.tmux/resurrect
	cd ~/.tmux/resurrect ; patch -p1 < fix_first_window_name.patch
	
	cp -Pv tmux/last ~/.tmux/resurrect  
	cp -v tmux/tmux_resurrect_2017-06-10T18:56:23.txt ~/.tmux/resurrect

cfg-vim:
	- cp ~/.vimrc ~/.vimrc.orig
	cp vim/.vimrc ~/
	sudo cp vim/.vimrc /root

cfg-mc:
	-mkdir -p ~/.config/mc
	cp -v mc/* ~/.config/mc
	-sudo mkdir /root/.config/mc
	-sudo cp -v mc/* /root/.config/mc

cfg-root:
	sudo cp -vr root/*.service /etc/systemd/system/
	
	sudo mkdir -p /etc/iptables
	sudo cp root/iptables.rules /etc/iptables
	sudo systemctl enable iptables

cfg-rsync:
	cp -v rsync/.rsync-ignore.list ~/

# --- server configs ---


cfg-srv: cfg-ssh cfg-ddclient cfg-smb cfg-minidlna cfg-trans

cfg-ssh:
	sudo cp -v ssh/sshd_config /etc/ssh

cfg-ddclient:
	sudo cp -v ddclient/ddclient.conf /etc

cfg-smb:
	sudo cp -v smb/smb.conf /etc/samba/smb.conf

cfg-minidlna:
	sudo cp -v minidlna/minidlna.conf /etc

cfg-trans:
	sudo cp -v transmission-daemon/settings.json /etc/transmission-daemon/settings.json

