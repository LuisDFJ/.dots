# Arch Linux Installation Guide

This casual guide serves as an archive to my future me who will unevitably install arch linux again and might need some guidance from the past on how to have a working LUKS encrypted root partition with an external drive keyfile up and running.

First you will need a live USB with the Arch Linux ISO installed. I decided to have a 64G USB drive partitioned into two, the first part will contain the ISO, which can be copied using:

> dd if=arch-linux.iso of=/dev/sda1 bs=4M status=progress conv=fsync oflag=direct

the second partition can be formated as an EXT4 or FAT32:

> mkfs.ext4 /dev/sda2

Next mount it and create keyfile:

> mount /dev/sda2 /mnt/key/ --mkdir
> dd if=/dev/urandom of=/mnt/key/root.key bs=512 count=8
> chmod 000 /mnt/key/root.key
> chown root:root /mnt/key/root.key

Now you can follow the arch linux installation guide (obviously). Here are some important considerations.

Securely whipe the SSD drive, in my case is probably an NVME drive so I can use the nvme-cli contained in the arch-linux.iso:

> nvme format /dev/nvme0n1 --ses=<1,2>

Depending on the the device it can support User data erase (1) or Cryptographic Erase (2).

The partitions to create are as follow:
/boot  /dev/nvme0n1p1 1G    mkfs.fat -F 32
/      /dev/nvme0n1p2 461G  
[SWAP] /dev/nvme0n1p3 15G   mkswap

For root (/) we do a cryptographic format and logical mapping:

> cryptsetup -v luksFormat /dev/nvme0n1p2
> cryptsetup open /dev/nvme0n1p2 root
> mkfs.ext4 /dev/mapper/root

Assuming you mounted the /dev/sda2 in /mnt and already _arch-chroot_edadd the keyfile, and maybe some other passphrase backup.

> cryptsetup luksAddKey /dev/nvme0n1p2 /mnt/key/root.key

Proceed with the rest of the installation, as for the bootloader, I used grub on UEFI:

> pacman -S grub efibootmgr
> grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH

You can then execute the grub-mkconfig command but first we need to add some kernel parameters in _/etc/default/grub_. Add the following to line:

> GRUB_CMDLINE_LINUX="rd.luks.name=<root-UUID(encrypted)>=root root=/dev/mapper/root rd.retry=10" 

Now you can run _grub-mkconfig_:

> grub-mkconfig -o /boot/grub/grub.cfg

We must also setup some things in _/etc/mkinitcpio.conf_:

MODULES=(... vfat ext4 usb_storage uas xhci_pci ehci_pci)
...
HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)

Also, we can configure _/etc/crypttab.initramfs_:

root UUID=<root-UUID(encrypted)> root.key:UUID=<usb-UUID> keyfile-timeout=10s

and now we can run:

> mkinitcpio -P

Now we can have an encrypted root file that will try to load the root.key on the USB or fallback to a passphrase if not founded.

# Other Configurations

Add user:

> useradd -mG wheel <user>

remember to add wheel group to the sudoers list in _/etc/sudoers_

Microcode package: intel-ucode
Power management: tlp (configure it in _/etc/tlp.conf_ and run tlp start)
Audio: alsa-utils pipewire pipewire-alsa pipewire-pulse wireplumber
Audio-firmware: sof-firmware alsa-firmware alsa-ucm-conf (reboot and try alsamixer and speaker-test).
Font: terminus-font (set at _/etc/vconsole.conf_)
Bluetooth: bluez bluez-utils
Hyprland: hyprland kitty hyprlauncher firefox
Yazi: ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick yazi
Nvidia: nvidia-dkms nvidia-utils egl-wayland

Services:
NetworkManager
tlp
alsa-state.service
alsa-restore.service
--user pipewire.service
--user pipewire-pulse.service
--user wireplumber.service
bluetooth.service

Nvidia mkinitcpio modules:
MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm ...)
> mkinitcpio -P
