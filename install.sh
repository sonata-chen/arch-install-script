#!/bin/sh


ROOT_partition=


timedatectl set-ntp true


echo -e "\e[1;36m\n------ hardrive setup ------\n\e[0m"

mkfs.ext4 ${ROOT_partition} 




mount ${ROOT_partition} /mnt



echo -e "\e[1;36m\n------ mirrorlist setup ------\n\e[0m"
read -p $'\e[1;36mEdit mirrorlist config? [Y\\n] \e[0m' ask_mirrorlist
ask_mirrorlist=${ask_mirrorlist:-y}
if [[ $ask_mirrorlist =~ ^[Yy]$ ]]
then
   vim /etc/pacman.d/mirrorlist 
fi

echo -e "\e[1;36m\n------ install base system ------\n\e[0m"

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo -e "\e[1;36m\n------ base system has been installed ------\n\e[0m"

cp post_install.sh /mnt
arch-chroot /mnt ./post_install.sh


umount -R /mnt
echo -e "\e[1;36m\n------ installation completed! ------\n\e[0m"
