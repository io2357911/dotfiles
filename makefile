
cfg: cfg-term cfg-de cfg-soft


# --- desktop environment configs ---


cfg-de: cfg-dm cfg-awesome

cfg-dm: cfg-img
	- sudo mkdir -p /etc/lightdm
	
	- sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.orig
	- sudo cp -v lightdm/lightdm.conf /etc/lightdm
	
	- sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.orig	
	- sudo cp -v lightdm/lightdm-gtk-greeter.conf /etc/lightdm

cfg-awesome: cfg-scripts cfg-img cfg-gtk
	- mkdir -p ~/.config/awesome
	
	sudo cp -vr awesome/snow /usr/share/awesome/themes/
		
	cp -vr awesome/debian ~/.config/awesome
	
	- cp -v ~/.xsessionrc ~/.xsessionrc.orig        
	cp -v awesome/.xsessionrc ~/
	
	- cp -v ~/.config/awesome/rc.lua ~/.config/awesome/rc.lua.orig
	cp -v awesome/rc.lua ~/.config/awesome

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


# --- terminal tweaks configs ---


cfg-term: cfg-terminator cfg-bash cfg-tmux cfg-vim cfg-mc cfg-root

cfg-terminator:
	- mkdir -p ~/.config/terminator
	- cp ~/.config/terminator ~/.config/terminator.orig
	cp -v terminator/config ~/.config/terminator

cfg-bash:
	- cp ~/.bashrc ~/.bashrc.orig
	cp bash/.bashrc ~/
	sudo cp bash/.bashrc /root	

cfg-tmux:
	cp tmux/.tmux.conf ~/

cfg-vim:
	- cp ~/.vimrc ~/.vimrc.orig
	cp vim/.vimrc ~/
	sudo cp vim/.vimrc /root

cfg-mc:
	- mkdir -p ~/.config/mc
	cp -v mc/* ~/.config/mc
	- sudo mkdir /root/.config/mc
	sudo cp -v mc/* /root/.config/mc

cfg-root:
	sudo cp root/makefile /root
	
	sudo cp -vr root/*.service /etc/systemd/system/
	
	sudo mkdir -p /etc/iptables
	sudo cp root/iptables.rules /etc/iptables
	sudo systemctl enable iptables


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

