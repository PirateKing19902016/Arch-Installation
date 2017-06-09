#!/bin/bash
source config
mount $PART /mnt
pacstrap -i /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt  /bin/bash -c "echo $LANG_TMP >>/etc/locale.gen"
arch-chroot /mnt  /bin/bash -c "echo LANG=en_US.UTF-8 > /etc/locale.conf"
arch-chroot /mnt  /bin/bash -c 'export LANG="en_US.UTF-8" '
arch-chroot /mnt  /bin/bash -c "ln -s $ZONE /etc/localtime"
arch-chroot /mnt  /bin/bash -c "hwclock --systohc --utc"
arch-chroot /mnt  /bin/bash -c  'printf "[multilib]\nInclude = /etc/pacman.d/mirrorlist"'
arch-chroot /mnt  /bin/bash -c "pacman -Sy"
arch-chroot /mnt  /bin/bash -c  "passwd"
arch-chroot /mnt  /bin/bash -c "useradd -m -g users -G wheel,storage,power -s /bin/bash $USER_TMP"
arch-chroot /mnt  /bin/bash -c  "passwd $USER_TMP"
arch-chroot /mnt  /bin/bash -c "pacman -S sudo --noconfirm"
arch-chroot /mnt  /bin/bash -c 'echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers'
arch-chroot /mnt  /bin/bash -c 'pacman -S grub-bios --noconfirm'
arch-chroot /mnt  /bin/bash -c 'grub-install --target=i386-pc --recheck ${PART::-1}'
arch-chroot /mnt  /bin/bash -c "cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo"
arch-chroot /mnt  /bin/bash -c  "pacman -S os-prober --noconfirm"
arch-chroot /mnt  /bin/bash -c  "grub-mkconfig -o /boot/grub/grub.cfg"


