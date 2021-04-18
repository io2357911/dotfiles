all: cfg-keyboard stow

stow:
	@stow -v \
		idea \
		make \
		nvim \
		termite \
		tmux \
		vifm \
		mpv \
		zathura \
		scripts

cfg-keyboard:
	$(call cfg,keyboard)

define cfg
	sudo rsync -avb --suffix=.orig $1/ /
endef

install-pkglist:
	sudo pacman -Syu --needed - < pkglist.txt
