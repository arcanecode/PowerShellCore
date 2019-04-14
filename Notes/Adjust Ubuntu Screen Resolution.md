# Adjust the screen resolution of an Ubuntu VM in Hyper-V

When installing Ubuntu in a Hyper-V VM the resolution doesn't resize automatically, and getting the tools right can be a troublesome endevour. 

If screen resolution is the only thing that needs to be fixed, it's far easier just to edit the default resolution in the Ubuntu configuration. Use the following steps to make your Ubuntu VM just the right size.

1. Open a terminal window
2. sudio vim /etc/default/grub
3. Find the line starting with GRUB_CMDLINE_LINUX_DEFAULT
4. Append video=hyperv_fb:1280x720 (or 1920x1080, or 2560x1440, etc) so it looks like:
```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"
```
5. Write changes with ESC :wq
6. Update grub by running the following command:
```bash
sudo update-grub
```
7. Finally, reboot your VM. You can use the GUI, or issue the following command in the terminal:
```bash
sudo /sbin/shutdown -r now 
```

Boom, enjoy the new resolution.

Source: https://metinsaylan.com/8991/how-to-change-screen-resolution-on-ubuntu-18-04-in-hyper-v/
