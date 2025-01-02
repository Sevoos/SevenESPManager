# Windows 7 build 7601.24545
## Version v24.12-a
windows_7_build.7601.24545_v24.12-a.iso

This is an iso image of Windows 7, based on [this vanilla one](https://archive.org/details/en_windows_7_ultimate_with_sp1_x64_dvd_u_677332_202006). Of course, it's Ultimate, x64, en_US.
## The list of changes:
### Updates:
The install.wim file has been processed with [UpdatePack7R2](https://blog.simplix.info/updatepack7r2/), which is developed by **Simplix**🇺🇦. The exact version of that utility was **v20.1.17**. 

As the official website doesn't provide older releases, here's a magnet link to the version that was used:

magnet:?xt=urn:btih:d4b46e47e673c5fcd31c00045397b0f2d49c81f2&dn=UpdatePack7R2-20.1.17.exe

I used that specific version in order for the iso image to have 2020-01 updates, therefore having build number 7601.24545 - not higher - which is required for compatibility with [DotExe](https://dotexe.cf)'s Windows 7 Extended Kernel (the latest version can be found in their Discord server).

### Drivers:
The drivers that have been slipstreamed into both install.wim and boot.wim files were selectively taken from [7Updater](https://www.sevenforums.com/installation-setup/415754-update-your-win-7-installation-media.html), 7UPv64R to be exact, which is developed by SIW2. Here's the list of directories with the drivers that were used (DRIVERS.7z):
1. AMD
2. i225v-7MOD
3. Intel LAN
4. IntelStorage
5. msnvmex64
6. REALTEK_12222021x64
7. XHCI-UASPx64
     
The list of the directories that were excluded:
1. ACPITIME-sha2
2. Bluetooth
3. e1c62x64.inf_amd64
4. emmc-7x64-BH778
5. samsung-nvme3-mod

For some unknown reason, provided that all the directories are used, the iso doesn't work, getting stuck on disk.sys without a BSoD.
Additionally, acpi.sys was replaced in order to avoid 0xA5 BSoD.

### Tweaks:
My goal was to balance between originality and convenience. Anyway, here's the list of other modifications:
* The default UAC mode has been set to "Notify me only when apps try to make changes to my computer _(do not dim my desktop)_";
* The Disk Defragmenter service, Prefetch and Superfetch have been disabled to take care of the TBW resource of SSDs;
* Microsoft XPS Document Writer, Tablet PC Components and XPS Viewer have been disabled;
* Explorer tweaks:
  * All the icons in the tray are now shown by default;
  * AutoPlay has been disabled;
  * "Show extensions for known file types" is now enabled by default;
  * "Show hidden files, folders and drives" is now enabled by deault;
  * The hibernation item has been removed from the shutdown submenu;
* The initial size of pagefile.sys is 16 MiB, the max value is 1024;
* The initial size of hiberfil.sys has been reduced to 50% of RAM from 75%, subsequently deleted before first logon;
* Registry tweaks:
  * BIOS time is now synchronized with UTC time not depending on the timezone: **[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation] "RealTimeIsUniversal"=dword:00000001**

## Download the iso
The Internet Archive: _not implemented yet_

FebBox: https://febbox.com/share/MQFS5nMY

## Contribute to downloading
_not implemented yet_
