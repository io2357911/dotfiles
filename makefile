
cfg-de: cfg-dm cfg-awesome

cfg-dm: cfg-img
	sudo mkdir -p /etc/lightdm
	sudo cp -v lightdm/* /etc/lightdm

cfg-awesome: cfg-scripts cfg-img cfg-gtk
	mkdir -p ~/.config/awesome
	cp -v awesome/rc.lua ~/.config/awesome
	cp -v awesome/.xprofile ~/

cfg-img:
	sudo cp img/* /usr/share/pixmaps
	
cfg-scripts:
	mkdir -p ~/.local/bin
	cp scripts/* ~/.local/bin

cfg-gtk:
	cp gtk/.gtkrc-2.0 ~/	

cfg-term: cfg-bash cfg-tmux cfg-vim cfg-mc cfg-root

cfg-bash:
	cp bash/.bashrc ~/
	sudo cp bash/.bashrc /root	

cfg-tmux:
	cp tmux/.tmux.conf ~/

cfg-vim:
	cp vim/.vimrc ~/
	sudo cp vim/.vimrc /root

cfg-mc:
	mkdir -p ~/.config/mc
	cp -v mc/* ~/.config/mc
	sudo mkdir /root/.config/mc
	cp -v mc/* /root/.config/mc

cfg-root:
	sudo cp root/makefile /root
