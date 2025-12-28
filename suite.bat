@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: ADMIN KONTROLU
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo #######################################################
    echo # LUTFEN SAG TIKLAYIP YONETICI OLARAK CALISTIRIN!     #
    echo #######################################################
    pause & exit
)

:: --- AYARLAR (Kendi Raw Linkini Buraya Koy) ---
SET "https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"
SET "VERSION=9.4"

:: PENCERE BOYUTUNU ZORLA AYARLA
mode con: cols=115 lines=50
title Professional IT Suite v%VERSION% - Code Emre Bilgin
color 0A

:: --- GUNCELLEME KONTROLU ---
echo [+] Sistem Guncellemeleri Kontrol Ediliyor... v%VERSION%
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\update.bat')" >nul 2>&1
if exist "%temp%\update.bat" (
    fc /b "%~f0" "%temp%\update.bat" >nul
    if %errorLevel% neq 0 (
        move /y "%temp%\update.bat" "%~f0" >nul
        echo [+] Yeni gorunum yukleniyor...
        timeout /t 1 >nul
        start "" "%~f0"
        exit
    )
)

:MENU
cls
echo.
echo  ==================================================================================================
echo     USB YONETIM VE SISTEM BAKIM KONSOLU (V%VERSION%) - CODE EMRE BILGIN
echo  ==================================================================================================
echo     SURUM: %VERSION%                             DURUM: AKTIF / GUNCEL
echo  --------------------------------------------------------------------------------------------------
echo.
echo    [1] Mevcut Diskleri Goruntule           [16] Sistem Dosyalarini Onar (SFC)
echo    [2] Akilli Format (NTFS/FAT32/exFAT)    [17] Sabit Diski Tarama (CHKDSK)
echo    [3] Yazma Korumasini ETKINLESTIR        [18] Disk Temizligi (Cleanmgr)
echo    [4] Yazma Korumasini KALDIR             [19] Grup Politikalarini Guncelle
echo    [5] Disk ve Bolum Detaylarini Gor       [20] Windows Guncelleme Durumu
echo.
echo    --------------------------------------------------------------------------------------------------
echo.
echo    [6] Seri No, Marka ve Model             [21] Tum Programlari Guncelle (Winget)
echo    [7] IP Adresini Goruntule               [22] Windows Store Uygulama Guncelle
echo    [8] Windows Lisans Durumu               [23] Gereksiz Dosyalari Temizle (Temp)
echo    [9] Sistem Bilgileri (Detayli)          [24] RAM Optimizasyonu Yap
echo    [10] CPU Bilgilerini Goster             [25] Guvenlik Duvarini AC/KAPAT
echo.
echo    --------------------------------------------------------------------------------------------------
echo.
echo    [26] DNS Onbellegini Temizle            [36] Windows Update Servislerini SIFIRLA
echo    [34] WI-FI SIFRESINI GOSTER             [37] Tum Suruculeri (Drivers) YEDEKLE
echo    [41] Explorer ve Gorev Cubugu ONAR      [38] Guc Plani: NIHAI PERFORMANS
echo    [43] Pil Saglik Raporu (Laptop)         [44] Windows Telemetriyi KAPAT
echo    [35] CIKIS (EXIT)                       [42] BIOS / Anakart Bilgisi
echo.
echo  ==================================================================================================
set /p choice=" >> Seciminizi Girin: "

:: --- YONLENDIRMELER ---
if "%choice%"=="1" goto LIST
if "%choice%"=="2" goto FORMAT_SELECTION
if "%choice%"=="3" goto PROTECT
if "%choice%"=="4" goto UNPROTECT
if "%choice%"=="5" goto DETAIL
if "%choice%"=="6" goto COMPUTER_INFO
if "%choice%"=="7" goto IP
if "%choice%"=="8" goto LICENSE
if "%choice%"=="9" goto SYSINFO
if "%choice%"=="10" goto CPUINFO
if "%choice%"=="16" goto SFC
if "%choice%"=="17" goto CHKDSK
if "%choice%"=="18" goto CLEANUP
if "%choice%"=="19" goto GPUPDATE
if "%choice%"=="21" goto UPDATE_PROGRAMS
if "%choice%"=="22" goto UPDATE_STORE_APPS
if "%choice%"=="23" goto CLEAN_TEMP_FILES
if "%choice%"=="24" goto OPTIMIZE_RAM
if "%choice%"=="26" goto CLEAR_DNS
if "%choice%"=="34" goto WIFI_PASSWORD
if "%choice%"=="36" goto RESET_UPDATE
if "%choice%"=="37" goto BACKUP_DRIVERS
if "%choice%"=="38" goto ULTRA_PERFORMANCE
if "%choice%"=="41" goto RESTART_EXPLORER
if "%choice%"=="42" goto BIOS_INFO
if "%choice%"=="43" goto BATTERY_REPORT
if "%choice%"=="44" goto DISABLE_TELEMETRY
if "%choice%"=="35" exit
goto MENU

:: --- FONKSIYONLAR ---

:IP
cls
echo [+] Yerel IP Bilgileriniz:
echo -----------------------------------
ipconfig | findstr /R /C:"IPv4" /C:"IP Adresi"
echo -----------------------------------
pause & goto MENU

:OPTIMIZE_RAM
cls
echo [+] RAM Temizleme Komutlari Calistiriliyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(128000000) > "%temp%\ram.vbs"
cscript //nologo "%temp%\ram.vbs" & del "%temp%\ram.vbs"
echo [OK] Bellek optimize edildi.
pause & goto MENU

:RESTART_EXPLORER
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo [+] Masaustu bilesenleri yenilendi.
timeout /t 2 >nul
goto MENU

:LIST
cls
(echo list disk) > "%temp%\ds.txt"
diskpart /s "%temp%\ds.txt"
pause & goto MENU

:WIFI_PASSWORD
cls
set /p wifi="Ag Adi (SSID) Girin: "
netsh wlan show profile name="%wifi%" key=clear | findstr /i "Key Content"
if %errorlevel% neq 0 echo [!] Ag bulunamadi.
pause & goto MENU

:: Diğer fonksiyonları buraya eksiksiz ekleyebilirsin...
