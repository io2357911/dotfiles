export QT_QPA_PLATFORMTHEME=gtk2
feh --bg-scale /usr/share/images/desktop-base/background-image
xcompmgr &
terminator -e tmux & 

exec i3
