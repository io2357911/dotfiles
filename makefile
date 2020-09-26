all: cfg-keyboard
	@stow -v \
		idea \
		make \
		nvim \
		scripts \
		termite \
		tmux \
		vifm \
		zathura

cfg-keyboard:
	$(call cfg,keyboard)

define cfg
	sudo rsync -avb --suffix=.orig $1/ /
endef

install-pkglist:
	sudo pacman -Syu - < pkglist.txt
