@echo off
setlocal enabledelayedexpansion

set "version=24.12-a"
set "exlamation=!"
echo Welcome to SevenESPManager v!version! by Sevoos^!
echo GitHub: https://www.github.com/Sevoos/SevenESPManager

:: Defining of initial variables
set "main=%~dp0"
set "findstr=%main%bin\findstr.exe"
set "sevenzip=%main%bin\7z.exe"
set "flashFile=%main%bootmgfw.flashboot.efi"

:: The temporary directory: X: for WinPE and C: for a regular installation
if exist "X:\Windows\Temp" (
    set "tempPath=X:\Windows\Temp"
) else (
    set "tempPath=C:\Windows\Temp"
)

:: Checking if bootmgfw.flashboot.efi exists


if not exist "%flashFile%" (
    echo ERROR: bootmgfw.flashboot.efi not found in the main directory.
    pause
    exit /b
)

:: Displaying volumes information using diskpart
echo Listing volumes...
:SelectVolume
echo list vol | diskpart > "%tempPath%\diskpart_output.txt"

:: Exiting if there are no volumes to display
"%findstr%" /i "Volume" "%tempPath%\diskpart_output.txt" > nul
if %errorlevel% neq 0 (
    echo ERROR: Failed to get volume information.
    pause
    exit /b
)

:: Printing the output after "list vol"
type "%tempPath%\diskpart_output.txt"
echo ------------------------------------------------------------

:: Selecting of the ESP by the ID
set /p "volID=Please select the ID of the ESP (type 'e' to exit): "
if /i "!volID!"=="e" exit /b

:: Checking if the selected volume has a drive letter
set "driveLetter="
for /f "tokens=1,2,3,*" %%a in ('type "%tempPath%\diskpart_output.txt"') do (
	if "%%a"=="Volume" (
		if "%%b"=="!volID!" (
			set "c=%%c"
			set "length=0"
			for /l %%i in (0,1,255) do (
				set "char=!c:~%%i,1!"
				if not "!char!"=="" (
					set /a length+=1
				) else (
					goto done
				)
			)
			:done
			:: Fixme: if there's no drive letter, while the volume label consists of 1 character, the script sets the %driveLetter% variable to the label
			if "%length%"=="1" (
				set "driveLetter=%c%"
			)
		)
	)
)

:: If the selected volume doesn't have a drive letter, assigning Z:
if not defined driveLetter (
    echo No drive letter assigned. Assigning automatically...
    echo select vol !volID! > "%tempPath%\diskpart_script.txt"
    echo assign letter Z >> "%tempPath%\diskpart_script.txt"
    echo exit >> "%tempPath%\diskpart_script.txt"
    diskpart /s "%tempPath%\diskpart_script.txt"
    set "driveLetter=Z:"
) 

:: If the drive letter doesn't have a colon at the end, adding one ("U" -> "U:")
if not "!driveLetter!"=="" if "!driveLetter:~-1!" neq ":" set "driveLetter=!driveLetter!:"

:: Checking if bootmgfw.efi exists on the selected volume
set "bootFile=!driveLetter!\EFI\Microsoft\Boot\bootmgfw.efi"
if not exist "!bootFile!" (
    echo ERROR: bootmgfw.efi not found at !bootFile!
    goto :SelectVolume
)

:: Calculating SHA-256 checksums of bootmgfw.efi and bootmgfw.flashboot.efi

set "certutil=%main%bin\certutil.exe"
for /f "skip=1 tokens=*" %%a in ('%certutil% -hashfile "%bootFile%" SHA256') do (
    set bootmgfwChecksum=%%a
    goto :break
)
:break
for /f "skip=1 tokens=*" %%a in ('%certutil% -hashfile "%flashFile%" SHA256') do (
    set flashbootChecksum=%%a
    goto :break
)
:break

echo The SHA-256 checksum of !bootFile! is:
echo !bootmgfwChecksum!
echo The SHA-256 checksum of !flashFile! is:
echo !flashbootChecksum!


:: Comparing the checksums
if "!bootmgfwChecksum!"=="!flashbootChecksum!" (
    echo The checksums match. The current bootloader is the Flashboot one.
	:: Checking if bootmgfw.original.efi exists before continuing
    set "originalFile=!driveLetter!\EFI\Microsoft\Boot\bootmgfw.original.efi"
    if not exist "!originalFile!" (
        echo ERROR: !originalFile! not found
        goto :SelectVolume
    )
	:: Asking for approval before reverting the bootloader
    set /p "userInput=Do you want to revert the bootloader to the original one? (Y/N): "
    if /i "!userInput!"=="Y" (
        del "!bootFile!"
        rename "!originalFile!" bootmgfw.efi
        echo Done
        pause
        exit /b
    ) else (
        goto :SelectVolume
    )
) else (
    echo The checksums don't match. The current bootloader is the original one.
	:: Asking for approval before replacing the bootloader
    set /p "userInput=Do you want to replace the bootloader with the Flashboot one? (Y/N): "
    if /i "!userInput!"=="Y" (
        rename "!bootFile!" bootmgfw.original.efi
        copy "%main%\bootmgfw.flashboot.efi" "!bootFile!"
        echo Done
        pause
        exit /b
    ) else (
        goto :SelectVolume
    )
)
