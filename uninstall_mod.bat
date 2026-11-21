@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set "SRC=%~dp0original"
if not exist "%SRC%\item.msgbnd.dcx" (
    echo Error: File cadangan original tidak ditemukan di folder original.
    echo Jika Anda memasang mod secara manual, gunakan "Verify integrity of game files" di Steam.
    pause
    exit /b 1
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
        echo Error: Input kosong. Pembatalan uninstal.
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

echo Mengembalikan file original ke: %TARGET%

copy /y "%SRC%\*.msgbnd.dcx" "%TARGET%\msg\ENGLISH\" >nul
if errorlevel 1 (
    echo Error: Gagal mengembalikan file original. Pastikan game dalam keadaan tertutup.
    pause
    exit /b 1
)

if exist "%SRC%\menu_local.tpf.dcx" (
    if exist "%TARGET%\menu\ENGLISH\" (
        copy /y "%SRC%\menu_local.tpf.dcx" "%TARGET%\menu\ENGLISH\" >nul
        if errorlevel 1 (
            echo Error: Gagal mengembalikan tekstur menu_local.tpf.dcx original. Pastikan game dalam keadaan tertutup.
            pause
            exit /b 1
        )
    )
)

if exist "%TARGET%\SeamlessCoop\locale\" (
    if exist "%SRC%\english.json" (
        copy /y "%SRC%\english.json" "%TARGET%\SeamlessCoop\locale\" >nul
    )
)

if exist "%TARGET%\SeamlessCoop\" (
    if exist "%SRC%\ds1sc.dll" (
        copy /y "%SRC%\ds1sc.dll" "%TARGET%\SeamlessCoop\" >nul
    )
)

echo.
echo File original bahasa Inggris berhasil dikembalikan.
pause
