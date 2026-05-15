# Windows 7 with drivers from 7UPv64R and January 2026 updates
## Version v26-05-b
windows_7_7UPv64R_Jan-2026-updates_v26-05-b.iso

This is an iso image of Windows 7, based on this vanilla one: en_windows_7_ultimate_with_sp1_x64_dvd_u_677332.iso
The base image can be donwloaded from:
- [Internet Archive](https://archive.org/details/en_windows_7_ultimate_with_sp1_x64_dvd_u_677332_202412);
- [Massgrave](https://massgrave.dev/windows_7_links):
  - [Buzzheavier](https://buzzheavier.com/lllag2h2ucql);
  - [ZeroFS](https://zerofs.link/f/cY23XCDMAWMRcTTcHrLopD/).

Obviously, it's x64, Ultimate, en_US.

## The list of changes:
### The Preinstallation Environment:
The whole content of the iso image (except the install.wim file) has been taken from a Windows 10 iso image (to be exact, [this](https://buzzheavier.com/yhggy3l1e5oq) one) for seamless UEFI booting of WinPE.
### Updates:
The install.wim file has been processed with [UpdatePack7R2](https://blog.simplix.info/updatepack7r2), which was developed by **Simplix**. The version of that tool is its latest (and last) version, 26.1.15. Therefore, it includes all the updates for Windows 7 (including Server 2008 R2) released by Microsoft (but all the unwanted changes, including installation of Microsoft Edge, are **excluded**, as UpdatePack7R2 is designed to work like that).

### Drivers:
The drivers that have been slipstreamed into the install.wim file were selectively taken from the [7Updater](https://www.sevenforums.com/installation-setup/415754-update-your-win-7-installation-media.html) tool, version 7UPv64R (the last one), which was developed by **SIW2**. Here's the list of those driver directories that were included (DRIVERS.7z):
1. ACPITIME-sha2
2. AMD
3. Bluetooth
4. e1c62x64.inf_amd64
5. emmc-7x64-BH778
6. i225v-7MOD
7. Intel LAN
8. IntelStorage
9. msnvmex64
10. REALTEK_12222021x64
11. XHCI-UASPx64
     
The only driver directory that was excluded was **samsung-nvme3-mod**, because if it's included, the 2nd stage of installation might freeze on loading disk.sys without an apparent reason.
     
In addition, the acpi.sys file has been replaced to avoid the 0xA5 BSoD.

### Tweaks:

My goal was to balance originality and convenience. Anyway, here's the list of other modifications:

* Registry tweaks:
  * BIOS time is now synchronized with UTC time not depending on the timezone: **[HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation] "RealTimeIsUniversal"=dword:00000001**
* Post-Setup:
  * Before logon:
    * The hibernation file is disabled: cmd.exe /c powercfg -h off
* Explorer tweaks:
  * Enabled by default:
    * Show extensions for known file types;
    * Show hidden files, folders and drives;
    * Taskbar - Always show all icons and notifications on taskbar;
    * Taskbar - Display tray items.
* Disabled services (obviously, they can be enabled in services.msc):
  * Disk Defragmenter - to achieve optimal behavior for using an SSD instead of an HDD.

## Download the iso

* The Internet Archive: _not implemented yet_
* [Google Drive](https://drive.google.com/file/d/1Sxe_Br9p7jgpKxEoavwPbcie9Bv_iBdW/view)

## Contribute to downloading
_Not implemented yet_
