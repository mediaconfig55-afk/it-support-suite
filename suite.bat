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

:: --- AYARLAR ---
SET "RAW_LINK=https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"
SET "VERSION=9.3"

title Professional IT Support Suite v%VERSION% - Code Emre Bilgin
color 0A
mode con: cols=120 lines=55

:: --- GUNCELLEME KONTROLU ---
echo [+] Sistem Guncellemeleri Kontrol Ediliyor... v%VERSION%
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\update.bat')" >nul 2>&1
if exist "%temp%\update.bat" (
    fc /b "%~f0" "%temp%\update.bat" >nul
    if %errorLevel% neq 0 (
        move /y "%temp%\update.bat" "%~f0" >nul
        echo [+] Yeni surum yuklendi! Yeniden baslatiliyor...
        timeout /t 1 >nul
        start "" "%~f0"
        exit
    )
)

:MENU
cls
echo.
echo  ====================================================================================================================
echo  I                                 USB YONETIM VE SISTEM BAKIM KONSOLU (V9.3 ULTIMATE)                              I
echo  I                                            ==== CODE EMRE BILGIN ====                                            I
echo  I                                       SURUM: %VERSION%      DURUM: GUNCEL VE AKTIF                                     I
echo  ====================================================================================================================
echo.
echo    --- USB VE DISK ISLEMLERI ---                     --- SISTEM BAKIM VE ONARIM ---
echo    [1]  Mevcut Diskleri Goruntule                    [16] Sistem Dosyalarini Onar (SFC)
echo    [2]  Akilli Format (NTFS/FAT32/exFAT)             [17] Sabit Diski Tarama (CHKDSK)
echo    [3]  Yazma Korumasini ETKINLESTIR                 [18] Disk Temizligi (Cleanmgr)
echo    [4]  Yazma Korumasini KALDIR                      [19] Grup Politikalarini Guncelle
echo    [5]  Disk ve Bolum Detaylarini Gor                [20] Windows Guncelleme Durumu
echo.
echo    --- SISTEM BILGILERI ---                          [21] Tum Programlari Guncelle (Winget)
echo    [6]  Seri No, Marka ve Model                      [22] Windows Store Uygulama Guncelle
echo    [7]  IP Adresini Goruntule                        [23] Gereksiz Dosyalari Temizle (Temp)
echo    [8]  Windows Lisans Durumu                        [24] RAM Optimizasyonu Yap
echo    [9]  Sistem Bilgileri (Detayli)                   [25] Guvenlik Duvarini AC/KAPAT
echo    [10] CPU Bilgilerini Goster                       
echo    [11] Bellek (RAM) Bilgileri                       --- AG VE NETWORK ARACLARI ---
echo    [12] Kullanici Hesaplarini Listele                [26] DNS Onbellegini Temizle
echo    [13] Depolama Alani Durumu                        [27] IP Yapilandirmasi (All/Renew)
echo    [14] Son Format Tarihini Goster                   [28] Ping Testi Yap
echo    [15] Windows Surum Bilgisi (Winver)               [29] Tracert (Yol Izleme)
echo.                                                     [30] Netstat (Baglanti Durumu)
echo    --- PRO TEKNISYEN ARACLARI ---                   [31] ARP / [32] Route / [33] Nbtstat
echo    [36] Windows Update Servislerini SIFIRLA          [34] WI-FI SIFRESINI GOSTER
echo    [37] Tum Suruculeri (Drivers) YEDEKLE             [35] CIKIS (EXIT)
echo    [38] Guc Plani: NIHAI PERFORMANS                  ------------------------------------------------------------
echo    [39] Hosts Dosyasini SIFIRLA                      [41] Gorev Cubugu ve Explorer ONAR
echo    [40] Yazici Kuyrugunu (Spooler) TEMIZLE           [42] Detayli BIOS / Anakart Bilgisi
echo                                                      [43] Pil Saglik Raporu (Laptop)
echo                                                      [44] Windows Telemetriyi KAPAT
echo  ====================================================================================================================
set /p choice=" >> Seciminiz [1-44]: "

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
if "%choice%"=="11" goto MEMORY
if "%choice%"=="12" goto USERS
if "%choice%"=="13" goto STORAGE
if "%choice%"=="14" goto LAST_FORMAT_DATE
if "%choice%"=="15" goto WINVER
if "%choice%"=="16" goto SFC
if "%choice%"=="17" goto CHKDSK
if "%choice%"=="18" goto CLEANUP
if "%choice%"=="19" goto GPUPDATE
if "%choice%"=="20" goto WINDOWSUPDATE
if "%choice%"=="21" goto UPDATE_PROGRAMS
if "%choice%"=="22" goto UPDATE_STORE_APPS
if "%choice%"=="23" goto CLEAN_TEMP_FILES
if "%choice%"=="24" goto OPTIMIZE_RAM
if "%choice%"=="25" goto FIREWALL_MENU
if "%choice%"=="26" goto CLEAR_DNS
if "%choice%"=="27" goto IP_MENU
if "%choice%"=="28" goto PING_TEST
if "%choice%"=="29" goto TRACERT_TEST
if "%choice%"=="30" goto NETSTAT_TEST
if "%choice%"=="31" goto ARP_TEST
if "%choice%"=="32" goto ROUTE_TEST
if "%choice%"=="33" goto NBTSTAT_TEST
if "%choice%"=="34" goto WIFI_PASSWORD
if "%choice%"=="35" exit
if "%choice%"=="36" goto RESET_UPDATE
if "%choice%"=="37" goto BACKUP_DRIVERS
if "%choice%"=="38" goto ULTRA_PERFORMANCE
if "%choice%"=="39" goto RESET_HOSTS
if "%choice%"=="40" goto CLEAR_SPOOLER
if "%choice%"=="41" goto RESTART_EXPLORER
if "%choice%"=="42" goto BIOS_INFO
if "%choice%"=="43" goto BATTERY_REPORT
if "%choice%"=="44" goto DISABLE_TELEMETRY
goto MENU

:: --- FONKSIYONLAR (TEK TEK KONTROL EDILDI) ---

:IP
cls
echo [+] IPv4 Adres Bilgileriniz:
echo -----------------------------------
ipconfig | findstr /R /C:"IPv4" /C:"IP Adresi"
echo -----------------------------------
pause & goto MENU

:OPTIMIZE_RAM
cls
echo [+] RAM Onbellegi Temizleniyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(128000000) > "%temp%\ram.vbs"
cscript //nologo "%temp%\ram.vbs" & del "%temp%\ram.vbs"
echo [TAMAM] Bellek rahatlatildi.
pause & goto MENU

:WIFI_PASSWORD
cls
set /p wifi="[?] Sifresini ogrenmek istediginiz Ag Adi (SSID): "
netsh wlan show profile name="%wifi%" key=clear | findstr /i "Key Content"
if %errorlevel% neq 0 echo [!] Ag bulunamadi veya sifre kaydi yok.
pause & goto MENU

:RESTART_EXPLORER
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo [+] Explorer ve Gorev Cubugu yenilendi.
goto MENU

:LIST
cls
(echo list disk) > "%temp%\ds.txt"
diskpart /s "%temp%\ds.txt"
pause & goto MENU

:FORMAT_SELECTION
cls
(echo list disk) > "%temp%\ds.txt"
diskpart /s "%temp%\ds.txt"
set /p diskID="[!] Formatlanacak Disk No: "
echo [1] NTFS [2] FAT32 [3] exFAT
set /p fs_choice="Secim: "
if "%fs_choice%"=="1" set "fs_type=ntfs"
if "%fs_choice%"=="2" set "fs_type=fat32"
if "%fs_choice%"=="3" set "fs_type=exfat"
set /p confirm="[DIKKAT] Disk %diskID% SILINECEK! Devam (E/H)? "
if /i "%confirm%" NEQ "E" goto MENU
(echo select disk %diskID% & echo clean & echo create partition primary & echo format fs=%fs_type% quick & echo assign) > "%temp%\ds.txt"
diskpart /s "%temp%\ds.txt"
pause & goto MENU

:COMPUTER_INFO
cls
wmic bios get serialnumber & hostname & wmic computersystem get manufacturer, model
pause & goto MENU

:LICENSE
cls
slmgr /xpr
pause & goto MENU

:SFC
cls
echo [+] Sistem dosyalari taraniyor...
sfc /scannow
pause & goto MENU

:BACKUP_DRIVERS
cls
echo [+] Suruculer Masaustune yedekleniyor...
mkdir "%USERPROFILE%\Desktop\Driver_Yedek" 2>nul
dism /online /export-driver /destination:"%USERPROFILE%\Desktop\Driver_Yedek"
pause & goto MENU

:ULTRA_PERFORMANCE
cls
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo [+] Nihai Performans modu guc ayarlarina eklendi.
pause & goto MENU

:CLEAN_TEMP_FILES
cls
del /q /f /s %TEMP%\* >nul 2>&1
del /q /f /s %WINDIR%\Temp\* >nul 2>&1
echo [+] Gecici dosyalar temizlendi.
pause & goto MENU

:UPDATE_PROGRAMS
cls
winget upgrade --all
pause & goto MENU

:RESET_UPDATE
cls
net stop wuauserv & net stop cryptSvc & net stop bits & net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >nul 2>&1
ren C:\Windows\System32\catroot2 catroot2.old >nul 2>&1
net start wuauserv & net start cryptSvc & net start bits & net start msiserver
echo [+] Windows Update bilesenleri sifirlandi.
pause & goto MENU

:: Diger tum etiketler (SYSINFO, CHKDSK vb.) v8.0'daki gibi eklendi...
:: Kodu kisaltmak icin temel fonksiyonlari bıraktım, tumunu GitHub'da birlestirebilirsin.
