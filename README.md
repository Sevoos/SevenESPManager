# SevenESPManager
A script that manages the bootloader of Windows 7 for installing the OS in UEFI mode

[Demonstration on YouTube](https://youtu.be/MCalej6wQoE)

[Description of my iso image](https://github.com/Sevoos/SevenESPManager/blob/main/isoDescription.md), which I recommend to use on modern hardware

## When to use the script:
If a .wim image of Windows 7 has been deployed on a volume that belongs to a GPT-allocated drive, it may be unable to boot. Most often it happens when CSM is disabled, but sometimes, mostly on laptops, even CSM being enabled can't fix that issue. In safe mode the last loaded file is usually disk.sys. The script replaces the stock bootloader with the Flashboot one (which requires CSM to be disabled), allowing Windows 7 to boot on pure UEFI.  

## How to use the script:
The script can be run both in a regular installed Windows environment and in Windows Preinstallation Environment. However, running it on installed Windows requires TrustedInstaller permissions - one of the possible solutions is [PowerRun](https://www.sordum.org/downloads/?power-run). 

Once the script prints the list of volumes and requests for the id of the EFI System Partition, find the FAT32 volume where Windows Boot Manager is located - type its id. Usually its size is 100 MiB. After the script calculates the checksums of 2 .efi files (one of them is **bootmgfw.flashboot.efi**, which is included in the .zip file), it'll request for the confirmation of replacing the original bootloader with the Flashboot one. Type "Y" if you want to continue. Once the process is complete, you'll be prompted to press any key to exit. *If the WinBootMgr contains multiple installations of Windows* (in other words, you dualnoot Windows), you'll likely have to type **bcdboot C:\Windows** for each install, using the appropriate drive letter each time. _Once the Flashboot bootloader is applied, you have to disable CSM if it was enabled prior._

If CSM being enabled can't get Windows 7 booting, which usually happens on laptops as I mentioned, once the 2nd stage of installation is complete (windeploy.exe has completed its job and the next stage os OOBE), the bootloader can be reverted back to the original one, and CSM can be turned on back. The steps are the same, except for the **bcdboot** command isn't needed anymore.
