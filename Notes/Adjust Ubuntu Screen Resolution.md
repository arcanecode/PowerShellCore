1. Open a terminal window
2. sudio vim /etc/default/grub
3. Find the line starting with GRUB_CMDLINE_LINUX_DEFAULT
4. Append video=hyperv_fb:1280x720 (or 1920x1080) so it looks like:

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"

5. Write changes with ESC :wq
6. Run sudo update-grub to update grub.
7. Reboot ( sudo /sbin/shutdown -r now )

Boom, enjoy the new resolution.

Source: https://metinsaylan.com/8991/how-to-change-screen-resolution-on-ubuntu-18-04-in-hyper-v/
