-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_Applications_File_Management"] = {
	{"mc", "x-terminal-emulator -e ".."/usr/bin/mc","/usr/share/pixmaps/mc.xpm"},
}
Debian_menu["Debian_Applications_Network_Web_Browsing"] = {
	{"Chromium","chromium","/usr/share/pixmaps/chromium.xpm"},
}
Debian_menu["Debian_Applications_Network"] = {
	{ "Web Browsing", Debian_menu["Debian_Applications_Network_Web_Browsing"] },
}
Debian_menu["Debian_Applications_Programming"] = {
	{"Python (v2.7)", "x-terminal-emulator -e ".."/usr/bin/python2.7","/usr/share/pixmaps/python2.7.xpm"},
	{"Tclsh8.6", "x-terminal-emulator -e ".."/usr/bin/tclsh8.6"},
	{"TkWish8.6","x-terminal-emulator -e /usr/bin/wish8.6"},
}
Debian_menu["Debian_Applications_Shells"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
}
Debian_menu["Debian_Applications_System_Administration"] = {
	{"Editres","editres"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
}
Debian_menu["Debian_Applications_System_Hardware"] = {
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_Applications_System_Monitoring"] = {
	{"htop", "x-terminal-emulator -e ".."/usr/bin/htop"},
	{"Pstree", "x-terminal-emulator -e ".."/usr/bin/pstree.x11","/usr/share/pixmaps/pstree16.xpm"},
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xev","x-terminal-emulator -e xev"},
}
Debian_menu["Debian_Applications_System"] = {
	{ "Administration", Debian_menu["Debian_Applications_System_Administration"] },
	{ "Hardware", Debian_menu["Debian_Applications_System_Hardware"] },
	{ "Monitoring", Debian_menu["Debian_Applications_System_Monitoring"] },
}
Debian_menu["Debian_Applications"] = {
	{ "File Management", Debian_menu["Debian_Applications_File_Management"] },
	{ "Network", Debian_menu["Debian_Applications_Network"] },
	{ "Programming", Debian_menu["Debian_Applications_Programming"] },
	{ "Shells", Debian_menu["Debian_Applications_Shells"] },
	{ "System", Debian_menu["Debian_Applications_System"] },
}
Debian_menu["Debian"] = {
	{ "Applications", Debian_menu["Debian_Applications"] },
}
