
cfg-de: cfg-dm cfg-awesome

cfg-dm: cfg-img
	- sudo mkdir -p /etc/lightdm
	- sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.orig
	- sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.orig
	- sudo cp -v lightdm/{lightdm.conf,lightdm-gtk-greeter.conf} /etc/lightdm

cfg-awesome: cfg-scripts cfg-img cfg-gtk
	- mkdir -p ~/.config/awesome
	- cp ~/.config/awesome/rc.lua ~/.config/awesome/rc.lua.orig
	cp -v awesome/rc.lua ~/.config/awesome
	- cp ~/.xprofile ~/.xprofile.orig
	cp -v awesome/.xprofile ~/

cfg-img:
	sudo cp img/* /usr/share/pixmaps
	
cfg-scripts:
	- mkdir -p ~/.local/bin
	cp scripts/* ~/.local/bin

cfg-gtk:
	- cp ~/.gtkrc-2.0 ~/.gtkrc-2.0.orig
	cp gtk/.gtkrc-2.0 ~/	

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
	cp -v mc/* /root/.config/mc

cfg-root:
	sudo cp root/makefile /root
