export QT_QPA_PLATFORMTHEME=gtk2

feh --bg-scale /home/$USER/img/background
#xrandr --output DVI-0 --auto --left-of HDMI-0
terminator -e tmux & 

redshift &

exec i3
