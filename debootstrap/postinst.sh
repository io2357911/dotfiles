#!/bin/bash

## обновление индекса репозитария
apt-get update

## настройка часовых поясов
dpkg-reconfigure tzdata

## монтирование файловых систем
mount -t proc /proc /proc
mount -a

## участие в опросе популярности пакетов
##apt-get -y install popularity-contest

## русский язык в консоли, русская локаль
## при настройке console-cyrillic лучше выбрать, как шрифт, UniCyr, а на последний вопрос ответить «Да»

apt-get -y install locales
dpkg-reconfigure locales
#apt-get -y install locales console-cyrillic
#dpkg-reconfigure console-cyrillic

## установка hostname, обязательный шаг
HOST='null'

echo "$HOST" > /etc/hostname
echo -e "\n127.0.0.1 localhost $HOST" >> /etc/hosts

## добавление пользователя, добавление его в sudo
USER='nullptr'

echo 'Добавление пользователя'

adduser $USER
usermod -a -G sudo $USER

## установка пароля root

echo 'Установка пароля root'
passwd

## установка ядра
ARCH=amd64 #варианты: i386, i486, i686, amd64

apt-get -y install \
	linux-image-$ARCH linux-headers-$ARCH \
	firmware-linux firmware-iwlwifi firmware-ti-connectivity intel-microcode \
	systemd systemd-sysv \
	pulseaudio \
	grub-pc \
	sudo iproute2 network-manager arp-scan \
	mc tmux htop nload \
	lightdm i3 \
	make git gcc

## Debian:
#apt-get -y install linux-base linux-image-$ARCH linux-headers grub

## Ubuntu:
# apt-get -y install linux-image-generic linux-headers-generic

## уставновка большинства прошивок
#apt-get -y install firmware-linux firmware-ralink firmware-realtek

## установка рабочей среды

## Debian:
#apt-get -y install xorg kde-full #KDE
#apt-get -y install xorg kde # <= Lenny
#apt-get -y install xorg gnome
#apt-get -y install xorg xfce lxdm #XFCE
#apt-get -y install xorg lxde lxdm #LXDE

## Debian, аудиосистема
#apt-get -y install pulseaudio
#apt-get -y install alsa-base alsa-tools alsa-utils alsa-oss

## Ubuntu: 
#apt-get -y install xorg kubuntu-desktop #KDE
#apt-get -y install xorg ubuntu-desktop #Unity
#apt-get -y install xorg gnome-shell gnome-themes-standard gnome-tweak-tool #Gnome3
#apt-get -y install xorg xubuntu-desktop #XFCE
#apt-get -y install xorg lubuntu-desktop #LXDE 

