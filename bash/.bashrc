#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias mc='EDITOR=vim mc'

#export LANG=en_US.utf8

export PATH=$PATH:~/.local/bin

export QSYS_ROOTDIR="/home/nullptr-deb/soft/altera/quartus/sopc_builder/bin"
export ALTERAOCLSDKROOT="/home/nullptr-deb/soft/altera/hld"

export QUARTUS_ROOTDIR=/home/nullptr-deb/soft/altera/quartus
export SOPC_KIT_NIOS2=/home/nullptr-deb/soft/altera/nios2eds

export PATH=/home/nullptr-deb/soft/altera/nios2eds/bin/:$PATH
export PATH=/home/nullptr-deb/soft/altera/quartus/bin/:$PATH
export PATH=/home/nullptr-deb/soft/altera/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/:$PATH
export PATH=/home/nullptr-deb/soft/altera/quartus/sopc_builder/bin/:$PATH

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

export LANG=en_US.utf8
