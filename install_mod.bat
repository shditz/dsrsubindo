@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set "SRC="
if exist "%~dp0msg\ENGLISH\item.msgbnd.dcx" (
    set "SRC=%~dp0msg\ENGLISH"
)
if not defined SRC (
    if exist "%~dp0DSRSubindo\msg\ENGLISH\item.msgbnd.dcx" (
        set "SRC=%~dp0DSRSubindo\msg\ENGLISH"
    )
)
if not defined SRC (
    if exist "%~dp0dist\DARK SOULS REMASTERED\msg\ENGLISH\item.msgbnd.dcx" (
        set "SRC=%~dp0dist\DARK SOULS REMASTERED\msg\ENGLISH"
    )
)

if not defined SRC (
    echo Error: File mod item.msgbnd.dcx tidak ditemukan.
    echo Pastikan install_mod.bat berada di dalam folder DSRSubindo ^(sejajar dengan folder msg^).
    pause
    exit /b 1
)

set "SRC_TEX="
if exist "%~dp0menu\ENGLISH\menu_local.tpf.dcx" (
    set "SRC_TEX=%~dp0menu\ENGLISH\menu_local.tpf.dcx"
) else if exist "%~dp0DSRSubindo\menu\ENGLISH\menu_local.tpf.dcx" (
    set "SRC_TEX=%~dp0DSRSubindo\menu\ENGLISH\menu_local.tpf.dcx"
) else if exist "%~dp0dist\DARK SOULS REMASTERED\menu\ENGLISH\menu_local.tpf.dcx" (
    set "SRC_TEX=%~dp0dist\DARK SOULS REMASTERED\menu\ENGLISH\menu_local.tpf.dcx"
)

set "TARGET="

if exist "%~dp0DarkSoulsRemastered.exe" (
    set "TARGET=%~dp0"
)

if not defined TARGET (
    if exist "%~dp0..\DarkSoulsRemastered.exe" (
        pushd "%~dp0.."
        set "TARGET=!CD!"
        popd
    )
)

if not defined TARGET (
    if exist "%~dp0..\..\DarkSoulsRemastered.exe" (
        pushd "%~dp0..\.."
        set "TARGET=!CD!"
        popd
    )
)

if not defined TARGET (
    for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if not defined TARGET (
            if exist "%%d:\SteamLibrary\steamapps\common\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
                set "TARGET=%%d:\SteamLibrary\steamapps\common\DARK SOULS REMASTERED"
            )
        )
        if not defined TARGET (
            if exist "%%d:\steamapps\common\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
                set "TARGET=%%d:\steamapps\common\DARK SOULS REMASTERED"
            )
        )
        if not defined TARGET (
            if exist "%%d:\Program Files (x86)\Steam\steamapps\common\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
                set "TARGET=%%d:\Program Files (x86)\Steam\steamapps\common\DARK SOULS REMASTERED"
            )
        )
        if not defined TARGET (
            if exist "%%d:\Games\SteamLibrary\steamapps\common\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
                set "TARGET=%%d:\Games\SteamLibrary\steamapps\common\DARK SOULS REMASTERED"
            )
        )
        if not defined TARGET (
            if exist "%%d:\Games\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
                set "TARGET=%%d:\Games\DARK SOULS REMASTERED"
            )
        )
    )
)

if not defined TARGET (
    for /f "tokens=2* skip=2" %%a in ('reg query "HKCU\Software\Valve\Steam" /v "SteamPath" 2^>nul') do (
        set "SP=%%b"
        set "SP=!SP:/=\!"
        if exist "!SP!\steamapps\common\DARK SOULS REMASTERED\DarkSoulsRemastered.exe" (
            set "TARGET=!SP!\steamapps\common\DARK SOULS REMASTERED"
        )
    )
)

if not defined TARGET (
    echo Direktori game Dark Souls Remastered tidak terdeteksi otomatis.
    set /p "TARGET=Masukkan path folder DARK SOULS REMASTERED Anda: "
    if not defined TARGET (
        echo Error: Input kosong. Instalasi dibatalkan.
        pause
        exit /b 1
    )
    set "TARGET=!TARGET:"=!"
    if "!TARGET:~-1!"=="\" set "TARGET=!TARGET:~0,-1!"
    if not exist "!TARGET!\DarkSoulsRemastered.exe" (
        echo Error: DarkSoulsRemastered.exe tidak ditemukan di direktori tersebut.
        pause
        exit /b 1
    )
)

set "TARGET=%TARGET:"=%"
if "%TARGET:~-1%"=="\" set "TARGET=%TARGET:~0,-1%"

echo Lokasi game terdeteksi: %TARGET%

if not exist "%~dp0original" mkdir "%~dp0original"
if not exist "%~dp0original\item.msgbnd.dcx" (
    if exist "%TARGET%\msg\ENGLISH\item.msgbnd.dcx" (
        copy /y "%TARGET%\msg\ENGLISH\item.msgbnd.dcx" "%~dp0original\" >nul
    )
)
if not exist "%~dp0original\menu.msgbnd.dcx" (
    if exist "%TARGET%\msg\ENGLISH\menu.msgbnd.dcx" (
        copy /y "%TARGET%\msg\ENGLISH\menu.msgbnd.dcx" "%~dp0original\" >nul
    )
)

set "SAME_TEX=0"
if defined SRC_TEX (
    if /i "%SRC_TEX%"=="%TARGET%\menu\ENGLISH\menu_local.tpf.dcx" set "SAME_TEX=1"
    if not "!SAME_TEX!"=="1" (
        if not exist "%~dp0original\menu_local.tpf.dcx" (
            if exist "%TARGET%\menu\ENGLISH\menu_local.tpf.dcx" (
                copy /y "%TARGET%\menu\ENGLISH\menu_local.tpf.dcx" "%~dp0original\" >nul
                if errorlevel 1 (
                    del /f /q "%~dp0original\menu_local.tpf.dcx" 2>nul
                    echo Error: Gagal membuat cadangan menu_local.tpf.dcx di folder original.
                    pause
                    exit /b 1
                )
            )
        )
    )
)

copy /y "%SRC%\*.msgbnd.dcx" "%TARGET%\msg\ENGLISH\" >nul
if errorlevel 1 (
    echo Error: Gagal menyalin file. Pastikan game dalam keadaan tertutup.
    pause
    exit /b 1
)

if defined SRC_TEX (
    if not "!SAME_TEX!"=="1" (
        if not exist "%TARGET%\menu\ENGLISH" mkdir "%TARGET%\menu\ENGLISH"
        copy /y "%SRC_TEX%" "%TARGET%\menu\ENGLISH\" >nul
        if errorlevel 1 (
            echo Error: Gagal menyalin file tekstur banner. Pastikan game dalam keadaan tertutup.
            pause
            exit /b 1
        )
    )
)

if exist "%TARGET%\SeamlessCoop\locale\" (
    if not exist "%~dp0original\english.json" (
        if exist "%TARGET%\SeamlessCoop\locale\english.json" (
            copy /y "%TARGET%\SeamlessCoop\locale\english.json" "%~dp0original\" >nul
        )
    )
    if exist "%~dp0SeamlessCoop\locale\english.json" (
        copy /y "%~dp0SeamlessCoop\locale\english.json" "%TARGET%\SeamlessCoop\locale\" >nul
    ) else if exist "%~dp0DSRSubindo\SeamlessCoop\locale\english.json" (
        copy /y "%~dp0DSRSubindo\SeamlessCoop\locale\english.json" "%TARGET%\SeamlessCoop\locale\" >nul
    ) else if exist "%~dp0dist\SeamlessCoop\locale\english.json" (
        copy /y "%~dp0dist\SeamlessCoop\locale\english.json" "%TARGET%\SeamlessCoop\locale\" >nul
    )
)

if not exist "%TARGET%\SeamlessCoop\ds1sc.dll" goto :after_sc_patch
setlocal disabledelayedexpansion
set "SC_DLL=%TARGET%\SeamlessCoop\ds1sc.dll"
set "SC_BAK=%~dp0original\ds1sc.dll"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=$env:SC_DLL; $bak=$env:SC_BAK; $lf=[string][char]10; $old=[Text.Encoding]::Unicode.GetBytes((@('[Announcement]','','Welcome to Dark Souls Remastered Seamless Co-op!','','[This is a free mod]','','If you have paid any money for this then you have been scammed!') -join $lf)); $new=[Text.Encoding]::Unicode.GetBytes((@('[Pengumuman]','','Dark Souls: Remastered Seamless Co-op','Mod Bahasa Indonesia oleh ShDitz','','[Mod Gratis]','Jika Anda membayar untuk mod ini, Anda tertipu!') -join $lf)); $b=[IO.File]::ReadAllBytes($p); $i=0; $found=-1; while(($i=[Array]::IndexOf($b,$old[0],$i)) -ge 0 -and $i -le ($b.Length-$old.Length)){ $ok=$true; for($j=1;$j -lt $old.Length;$j++){ if($b[$i+$j] -ne $old[$j]){ $ok=$false; break } }; if($ok){ $found=$i; break }; $i++ }; if($found -ge 0){ if(-not (Test-Path $bak)){ [IO.File]::Copy($p,$bak,$false) }; for($j=0;$j -lt $old.Length;$j++){ $b[$found+$j]=if($j -lt $new.Length){$new[$j]}else{0} }; [IO.File]::WriteAllBytes($p,$b) }" >nul 2>&1
endlocal
:after_sc_patch

echo.
echo Mod Bahasa Indonesia berhasil dipasang.
pause
