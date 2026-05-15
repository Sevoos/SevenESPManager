# SevenESPManager
A script that manages the bootloader of Windows 7 for installing the OS in UEFI mode

[Demonstration on YouTube](https://youtu.be/MCalej6wQoE)

[Description of my iso image](https://github.com/Sevoos/SevenESPManager/blob/main/isoDescription.md), which I recommend to use on modern hardware

## When to use the script:
If a .wim image of Windows 7 has been deployed on a volume that belongs to a GPT-allocated drive, it may be unable to boot successfully, potentially resulting in a 0x7B BSoD (it may be invisible). Typically, it happens only if CSM is disabled (or not available at all), but sometimes, mostly on laptops, even enabled CSM can't ensure that this issue won't appear. In safe mode the last loaded file is usually disk.sys. The script replaces the stock bootloader with the Flashboot one (which requires CSM to be disabled), making it possible for Windows 7 to boot in pure UEFI mode.  

## How to use the script:
The script can be run both in a regular installed Windows environment and in Windows Preinstallation Environment. However, running it on installed Windows requires TrustedInstaller permissions - some of the possible solutions are [Winaero Tweaker](https://winaerotweaker.com) and [PowerRun](https://www.sordum.org/downloads/?power-run). 

Once the script prints the list of volumes and requests the user to type the id of the EFI System Partition (ESP), find the FAT32 volume where the Windows Boot Manager is located. Its typical size is 100 MiB. After the script calculates the checksums of 2 .efi files (one of them is **bootmgfw.flashboot-_version_.efi**, which is included in the .zip file), it'll request for the confirmation of replacing the original bootloader with the Flashboot one. Type "Y" if you want to continue. Once the process is complete, you'll be prompted to press any key to exit. _If the Windows Boot Manager links to other installations of Windows (other than Windows 7) directly, they **won't** boot as long as the efi file is replaced._ Once the Flashboot bootloader is applied, you have to disable CSM if it was enabled prior.

If CSM is available but a replacement of the bootloader is necessary for Windows 7 to boot, once the 2nd stage of installation is complete (windeploy.exe has completed its job and the next stage is OOBE), or if you want to revert the bootloader for another reason, it can be done by running the script **again**. The steps are the same. Once the efi file has been reverted, CSM can be turned on.
