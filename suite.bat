@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
set "logFile=%TEMP%\UT_Ultimate_Final.log"

:: --- YÖNETİCİ KONTROLÜ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    mode con: cols=85 lines=10
    color 0C
    echo.
    echo    ┌──────────────────────────────────────────────────────────────────────────┐
    echo    │                 HATA: YÖNETİCİ YETKİSİ GEREKLİ...!!!                     │
    echo    ├──────────────────────────────────────────────────────────────────────────┤
    echo    │ Lütfen bu dosyaya sağ tıklayıp "Yönetici Olarak Çalıştır"ı seçin.        │
    echo    └──────────────────────────────────────────────────────────────────────────┘
    pause >nul & exit /b 1
)

:: --- LOG SİSTEMİ ---
echo [%date% %time%] --- v112 FINAL SISTEM BASLATILDI --- >> "%logFile%" 2>nul

:: --- PENCERE AYARLARI ---
color 0B
title USB TOOLS - ULTIMATE FINAL EDITION v112
mode con: cols=155 lines=80

:: --- FONKSİYON TANIMLARI ---
:HEADER_SUB
echo.
echo    ┌────────────────────────────────────────────────────────┐
echo    │ ISLEM: %~1
echo    └────────────────────────────────────────────────────────┘
echo.
goto :eof

:FOOTER_SUB
echo [%date% %time%] Islem Tamamlandi: %~1 >> "%logFile%" 2>nul
echo.
echo    [OK] Islem Tamamlandi. Menuye donmek icin bir tusa basin...
pause >nul
goto MENU

:: --- DİNAMİK VERİ TOPLAMA FONKSİYONU ---
:GET_SYSTEM_INFO
set "cpuLoad=N/A"
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do if not "%%p"=="" set "cpuLoad=%%p"

set "freeRAM=0"
set "totalRAM=0"
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "freeRAM=%%a"
for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /value 2^>nul') do set "totalRAM=%%a"

if defined totalRAM if defined freeRAM (
    set /a "usedRAM=(totalRAM - freeRAM) / 1024" 2>nul
    set /a "totalRAM_GB=totalRAM / 1048576" 2>nul
) else (
    set "usedRAM=0"
    set "totalRAM_GB=0"
)
goto :eof

:MENU
cls
call :GET_SYSTEM_INFO

echo.
echo.
color 0B
echo    ===========================================================================================================================
echo    ║                                                                                                                         ║
echo    ║   ██╗   ██╗███████╗██████╗     ████████╗ ██████╗  ██████╗ ██╗     ███████╗                                              ║
echo    ║   ██║   ██║██╔════╝██╔══██╗    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝                                              ║
echo    ║   ██║   ██║███████╗██████╔╝       ██║   ██║   ██║██║   ██║██║     ███████╗                                              ║
echo    ║   ██║   ██║╚════██║██╔══██╗       ██║   ██║   ██║██║   ██║██║     ╚════██║                                              ║
echo    ║   ╚██████╔╝███████║██████╔╝       ██║   ╚██████╔╝╚██████╔╝███████╗███████║                                              ║
echo    ║    ╚═════╝ ╚══════╝╚═════╝        ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                                              ║
echo    ║                                                                                                                         ║
echo    ║                     USB YONETIM, SISTEM BAKIM VE ONARIM KONSOLU (v11)                                                   ║
echo    ║   -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                          •••• CODE EMRE BILGIN - FINAL EDITION ••••                                                     ║
echo    ║   -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                                 •••• CMD CONTROLLER 2026 © ••••                                                         ║
echo    ║                                                                                                                         ║
echo    ╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo      » [ STATUS ] CPU: %cpuLoad%%%  │  RAM: %usedRAM% MB / %totalRAM_GB% GB  │  LOG: ACTIVE  │  YEAR: 2026 »                    
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo.
echo    [ DISK ^& USB YONETIMI ]           [ SISTEM ONARIM ^& BAKIM ]          [ AG ^& INTERNET AYARLARI ]        [ EKSTRA ARACLAR ^& GUVENLIK ]
echo    ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐
echo    │ [01] Diskleri Listele        │   │ [26] SFC Sistem Taramasi     │   │ [51] DNS Onbellegini Sil     │   │ [76] Hatali Suruculeri Bul   │
echo    │ [02] Akilli Format           │   │ [27] CHKDSK Disk Denetimi    │   │ [52] IP Yenile (Renew)       │   │ [77] Port Dinleyici (PID)    │
echo    │ [03] Yazma Korumasi AC       │   │ [28] DISM CheckHealth        │   │ [53] Google Ping Testi       │   │ [78] Buyuk Dosyalari Bul     │
echo    │ [04] Yazma Korumasi KAPAT    │   │ [29] DISM ScanHealth         │   │ [54] Tracert Site Takibi     │   │ [79] Sürücü Sağlığı (SMART)  │
echo    │ [05] Disk Detaylarini Gor    │   │ [30] DISM RestoreHealth      │   │ [55] Aktif Baglantilar       │   │ [80] Tarayici Cache Sil      │
echo    │ [06] FAT32 -^> NTFS Cevir     │   │ [31] Windows Update Onar     │   │ [56] Wi-Fi Sifrelerini Gor   │   │ [81] GodMode Olustur         │
echo    │ [07] Surucu Harfi Degistir   │   │ [32] Suruculeri Yedekle      │   │ [57] Ag Ayarlarini Sifirla   │   │ [82] Klasik Foto Goruntuleyici│
echo    │ [08] Disk Yonetimini Ac      │   │ [33] Yazici Kuyruğunu Sil    │   │ [58] MAC Adresini Goster     │   │ [83] Yanit Vermeyenleri Kapat│
echo    │ [09] USB Gecmisini Temizle   │   │ [34] Icon Cache Sifirla      │   │ [59] ARP Tablosunu Gor       │   │ [84] Firewall Sifirla        │
echo    └──────────────────────────────┘   │ [35] Explorer Yeniden Baslat │   │ [60] Baglanti Kontrolu       │   │ [85] Hosts Yedekle           │
echo                                       └──────────────────────────────┘   └──────────────────────────────┘   └──────────────────────────────┘
echo    [ DONANIM BILGILERI ]              [ PERFORMANS ^& TEMIZLIK ]          [ HIZLI ERISIM ^& GUC ]             [ OTOMASYON MODU ]
echo    ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐
echo    │ [10] Seri No ^& Model         │   │ [36] Gecici Dosyalari Sil    │   │ [61] Aygit Yoneticisi        │   │                              │
echo    │ [11] IP Adresini Gor         │   │ [37] RAM Optimizasyonu       │   │ [62] Denetim Masasi          │   │      [99] TURBO BAKIM        │
echo    │ [12] Lisans Durumu           │   │ [38] Disk Temizleme (Clean)  │   │ [63] Gorev Yoneticisi        │   │                              │
echo    │ [13] Detayli Sistem Bilgisi  │   │ [39] Windows.old Klasoru Sil │   │ [64] Hizmetler (Services)    │   └──────────────────────────────┘
echo    │ [14] CPU Bilgisi             │   │ [40] Panoyu Temizle          │   │ [65] Kayit Defteri           │   │ [00] PROGRAMI KAPAT          │
echo    │ [15] RAM Detaylari           │   │ [41] Olay Loglarini Sil      │   │ [66] MSConfig                │   └──────────────────────────────┘
echo    │ [16] Anakart ^& BIOS Bilgisi  │   │ [42] Magaza Uyg. Guncelle    │   │ [67] DirectX Tanilama        │
echo    │ [17] Ekran Karti (GPU)       │   │ [43] Winget Tumunu Guncelle  │   │ [68] Ekran Klavyesi          │
echo    │ [18] Ses Suruculeri          │   │ [44] Hosts Dosyasi Sifirla   │   │ [69] Admin Hesabi AC         │
echo    │ [19] Pil Raporu (Laptop)     │   │ [45] Telemetriyi Kapat       │   │ [70] Admin Hesabi KAPAT      │
echo    │ [20] Son Format Tarihi       │   │ [46] Nihai Performans Modu   │   │ [71] Firewall Ayarlari       │
echo    │ [21] Baslangic Uygulamalari  │   │ [47] Hibernate Kapat         │   │ [72] Sistemi Kilitle         │
echo    │ [22] Kullanici Hesaplari     │   │ [48] Uzantilari Goster/Gizle │   │ [73] Oto Kapat (1 Saat)      │
echo    │ [23] Depolama Alanlari       │   │ [49] Gizli Dosyalari Goster  │   │ [74] Kapatma Iptal           │
echo    │ [24] BIOS Surum Detayi       │   │ [50] Sistem Calisma Suresi   │   │ [75] Guc Planini Sifirla     │
echo    └──────────────────────────────┘   └──────────────────────────────┘   └──────────────────────────────┘
echo.
set /p "choice=   ╔══»═[ SECIMINIZI YAPIN (0-99) ]═══> "

echo [%date% %time%] Kullanici Secimi: %choice% >> "%logFile%" 2>nul

:: --- YÖNLENDİRME (IF) BLOKLARI ---
if "%choice%"=="00" goto :EOF
if "%choice%"=="01" goto LIST_DISK
if "%choice%"=="02" goto SMART_FORMAT
if "%choice%"=="03" goto PROTECT_DISK
if "%choice%"=="04" goto UNPROTECT_DISK
if "%choice%"=="05" goto DETAIL_DISK
if "%choice%"=="06" goto CONVERT_NTFS
if "%choice%"=="07" goto CHANGE_LETTER
if "%choice%"=="08" goto OPEN_DISKMGMT
if "%choice%"=="09" goto CLEAN_USB_REG
if "%choice%"=="10" goto INFO_BASIC
if "%choice%"=="11" goto INFO_IP
if "%choice%"=="12" goto INFO_LICENSE
if "%choice%"=="13" goto INFO_FULL
if "%choice%"=="14" goto INFO_CPU
if "%choice%"=="15" goto INFO_RAM
if "%choice%"=="16" goto INFO_BIOS
if "%choice%"=="17" goto INFO_GPU
if "%choice%"=="18" goto INFO_AUDIO
if "%choice%"=="19" goto REPORT_BATTERY
if "%choice%"=="20" goto INFO_FORMATDATE
if "%choice%"=="21" goto INFO_STARTUP
if "%choice%"=="22" goto INFO_USERS
if "%choice%"=="23" goto INFO_STORAGE
if "%choice%"=="24" goto INFO_BIOS_DETAIL
if "%choice%"=="25" goto INFO_NETWORK
if "%choice%"=="26" goto REPAIR_SFC
if "%choice%"=="27" goto REPAIR_CHKDSK
if "%choice%"=="28" goto DISM_CHECK
if "%choice%"=="29" goto DISM_SCAN
if "%choice%"=="30" goto DISM_RESTORE
if "%choice%"=="31" goto RESET_UPDATE
if "%choice%"=="32" goto BACKUP_DRIVERS
if "%choice%"=="33" goto CLEAR_SPOOLER
if "%choice%"=="34" goto RESET_ICON_CACHE
if "%choice%"=="35" goto RESTART_EXPLORER
if "%choice%"=="36" goto CLEAN_TEMP
if "%choice%"=="37" goto OPTIMIZE_RAM
if "%choice%"=="38" goto DISK_CLEANUP_TOOL
if "%choice%"=="39" goto DEL_WIN_OLD
if "%choice%"=="40" goto CLEAR_CLIPBOARD
if "%choice%"=="41" goto CLEAR_EVENTLOGS
if "%choice%"=="42" goto UPDATE_STORE
if "%choice%"=="43" goto UPDATE_WINGET
if "%choice%"=="44" goto RESET_HOSTS
if "%choice%"=="45" goto DISABLE_TELEMETRY
if "%choice%"=="46" goto ULTRA_PERFORMANCE
if "%choice%"=="47" goto DISABLE_HIBERNATE
if "%choice%"=="48" goto TOGGLE_EXT
if "%choice%"=="49" goto TOGGLE_HIDDEN
if "%choice%"=="50" goto UPTIME
if "%choice%"=="51" goto NET_FLUSHDNS
if "%choice%"=="52" goto NET_IP_RENEW
if "%choice%"=="53" goto NET_PING
if "%choice%"=="54" goto NET_TRACERT
if "%choice%"=="55" goto NET_NETSTAT
if "%choice%"=="56" goto NET_WIFI_PASS
if "%choice%"=="57" goto NET_RESET_STACK
if "%choice%"=="58" goto NET_MAC
if "%choice%"=="59" goto NET_ARP
if "%choice%"=="60" goto NET_CHECK_CONN
if "%choice%"=="61" goto TOOL_DEV
if "%choice%"=="62" goto TOOL_CONTROL
if "%choice%"=="63" goto TOOL_TASK
if "%choice%"=="64" goto TOOL_SERVICE
if "%choice%"=="65" goto TOOL_REG
if "%choice%"=="66" goto TOOL_MSCONFIG
if "%choice%"=="67" goto TOOL_DXDIAG
if "%choice%"=="68" goto TOOL_OSK
if "%choice%"=="69" goto SEC_ADMIN_ON
if "%choice%"=="70" goto SEC_ADMIN_OFF
if "%choice%"=="71" goto SEC_FIREWALL
if "%choice%"=="72" goto SEC_LOCK
if "%choice%"=="73" goto POWER_SHUTDOWN_TIMER
if "%choice%"=="74" goto POWER_ABORT
if "%choice%"=="75" goto RESET_POWER_PLANS
if "%choice%"=="76" goto FIND_BAD_DRIVERS
if "%choice%"=="77" goto PORT_LISTENER
if "%choice%"=="78" goto FIND_BIG_FILES
if "%choice%"=="79" goto DISK_SMART
if "%choice%"=="80" goto CLEAN_BROWSER_CACHE
if "%choice%"=="81" goto CREATE_GODMODE
if "%choice%"=="82" goto ENABLE_OLD_PHOTO
if "%choice%"=="83" goto KILL_NOT_RESPONDING
if "%choice%"=="84" goto RESET_FIREWALL
if "%choice%"=="85" goto HOSTS_BACKUP
if "%choice%"=="86" goto CLEAN_PREFETCH
if "%choice%"=="87" goto RESET_IE_SETTINGS
if "%choice%"=="88" goto SHOW_SYSTEM_UPTIME
if "%choice%"=="89" goto SHOW_PROCESSES
if "%choice%"=="90" goto SHOW_SERVICES
if "%choice%"=="91" goto SHOW_INSTALLED_APPS
if "%choice%"=="92" goto SHOW_HOTFIXES
if "%choice%"=="93" goto SHOW_ENVIRONMENT
if "%choice%"=="94" goto SHOW_TIMEZONE
if "%choice%"=="95" goto SHOW_LOCALE
if "%choice%"=="96" goto SHOW_VIRTUAL_MEMORY
if "%choice%"=="97" goto SHOW_PAGE_FILE
if "%choice%"=="98" goto SHOW_BOOT_CONFIG
if "%choice%"=="99" goto SMART_MAINTENANCE
goto MENU

:: --- EKSİK FONKSİYONLAR EKLENDİ ---

:INFO_NETWORK
cls
call :HEADER_SUB "Ağ Bağlantı Bilgileri"
ipconfig /all | more
call :FOOTER_SUB "INFO_NETWORK"

:CLEAN_PREFETCH
cls
call :HEADER_SUB "Prefetch Temizleme"
del /q /f /s "%systemroot%\Prefetch\*.*" >nul 2>&1
echo Prefetch klasoru temizlendi.
call :FOOTER_SUB "CLEAN_PREFETCH"

:RESET_IE_SETTINGS
cls
call :HEADER_SUB "Internet Explorer Sıfırlama"
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo Internet Explorer ayarlari sifirlandi.
call :FOOTER_SUB "RESET_IE_SETTINGS"

:SHOW_SYSTEM_UPTIME
cls
call :HEADER_SUB "Sistem Çalışma Süresi"
systeminfo | find "System Boot Time"
call :FOOTER_SUB "SHOW_SYSTEM_UPTIME"

:SHOW_PROCESSES
cls
call :HEADER_SUB "Çalışan Prosesler"
tasklist
call :FOOTER_SUB "SHOW_PROCESSES"

:SHOW_SERVICES
cls
call :HEADER_SUB "Sistem Servisleri"
sc query | more
call :FOOTER_SUB "SHOW_SERVICES"

:SHOW_INSTALLED_APPS
cls
call :HEADER_SUB "Kurulu Uygulamalar"
wmic product get name, version | more
call :FOOTER_SUB "SHOW_INSTALLED_APPS"

:SHOW_HOTFIXES
cls
call :HEADER_SUB "Yüklenmiş Güncellemeler"
wmic qfe get hotfixid, installedon | more
call :FOOTER_SUB "SHOW_HOTFIXES"

:SHOW_ENVIRONMENT
cls
call :HEADER_SUB "Sistem Ortam Değişkenleri"
set
call :FOOTER_SUB "SHOW_ENVIRONMENT"

:SHOW_TIMEZONE
cls
call :HEADER_SUB "Saat Dilimi Bilgisi"
systeminfo | find "Time Zone"
call :FOOTER_SUB "SHOW_TIMEZONE"

:SHOW_LOCALE
cls
call :HEADER_SUB "Bölgesel Ayarlar"
systeminfo | find "Locale"
call :FOOTER_SUB "SHOW_LOCALE"

:SHOW_VIRTUAL_MEMORY
cls
call :HEADER_SUB "Sanal Bellek Bilgisi"
systeminfo | find "Virtual Memory"
call :FOOTER_SUB "SHOW_VIRTUAL_MEMORY"

:SHOW_PAGE_FILE
cls
call :HEADER_SUB "Pagefile Bilgisi"
wmic pagefile list brief
call :FOOTER_SUB "SHOW_PAGE_FILE"

:SHOW_BOOT_CONFIG
cls
call :HEADER_SUB "Boot Yapılandırması"
bcdedit
call :FOOTER_SUB "SHOW_BOOT_CONFIG"

:: --- MEVCUT FONKSİYON GÖVDELERİ ---

:SMART_MAINTENANCE
cls
echo.
echo    ┌────────────────────────────────────────────────────────┐
echo    │             [99] TURBO HIZLI BAKIM MODU                │
echo    ├────────────────────────────────────────────────────────┤
echo    │                                                        │
echo    │  DIKKAT: Bu islem sistem dosyalarini tarayacak,        │
echo    │  onbellekleri temizleyecek ve sistemi optimize         │
echo    │  edecektir.                                            │
echo    │                                                        │
echo    │  Surenin uzunlugu sisteminize bagli olarak             │
echo    │  [5-20 DAKIKA] arasinda surebilir.                     │
echo    │                                                        │
echo    └────────────────────────────────────────────────────────┘
echo.
set /p "t_c=   >> Devam etmek istiyor musunuz? (E/H): "
if /i not "%t_c%"=="E" goto MENU
cls
call :HEADER_SUB "TURBO BAKIM CALISIYOR"
echo   [1/5] Temp ve DNS temizleniyor...
del /s /f /q "%temp%\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
ipconfig /flushdns >nul
echo   [2/5] RAM onbellegi bosaltiliyor...
echo off | clip >nul 2>&1
echo   [3/5] SISTEM TARAMASI (SFC) - Lutfen Bekleyin...
sfc /scannow
echo   [4/5] DISM ile sistem bütünlüğü kontrol ediliyor...
dism /online /cleanup-image /restorehealth
echo   [5/5] Explorer yenileniyor...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe >nul 2>&1
call :FOOTER_SUB "TURBO_BAKIM"

:LIST_DISK
cls
call :HEADER_SUB "Diskleri Listele"
echo list disk | diskpart
call :FOOTER_SUB "LIST_DISK"

:SMART_FORMAT
cls
call :HEADER_SUB "Akilli Format"
echo list disk | diskpart
echo.
set /p "d_id=   >> Disk Numarasi: "
echo   [1] NTFS  [2] FAT32  [3] exFAT
set /p "fs_c=   >> Secim: "
if "%fs_c%"=="1" set "fs=ntfs"
if "%fs_c%"=="2" set "fs=fat32"
if "%fs_c%"=="3" set "fs=exfat"
echo.
echo UYARI: Bu işlem diskteki tüm verileri silecektir!
set /p "confirm=   Devam etmek istiyor musunuz? (E/H): "
if /i not "%confirm%"=="E" goto MENU
(
echo select disk %d_id%
echo clean
echo create partition primary
echo format fs=%fs% quick
echo assign
) | diskpart
call :FOOTER_SUB "FORMAT"

:PROTECT_DISK
cls
call :HEADER_SUB "Disk Yazma Korumasi AÇ"
echo list disk | diskpart
set /p "d_id=   >> Disk Numarasi: "
(
echo select disk %d_id%
echo attributes disk set readonly
) | diskpart
call :FOOTER_SUB "WRITE_PROTECT_ON"

:UNPROTECT_DISK
cls
call :HEADER_SUB "Disk Yazma Korumasi KAPAT"
echo list disk | diskpart
set /p "d_id=   >> Disk Numarasi: "
(
echo select disk %d_id%
echo attributes disk clear readonly
) | diskpart
call :FOOTER_SUB "WRITE_PROTECT_OFF"

:DETAIL_DISK
cls
call :HEADER_SUB "Disk Detaylarini Gor"
echo list disk | diskpart
set /p "d_id=   >> Disk Numarasi: "
(
echo select disk %d_id%
echo detail disk
) | diskpart
call :FOOTER_SUB "DISK_DETAIL"

:CONVERT_NTFS
cls
call :HEADER_SUB "FAT32 -> NTFS Donusumu"
wmic logicaldisk get caption
echo.
set /p "vol=   >> Surucu Harfi (E gibi, : olmadan): "
if exist %vol%:\ (
    echo Donusum baslatiliyor...
    convert %vol%: /fs:ntfs
) else (
    echo HATA: %vol%: surucusu bulunamadi!
)
call :FOOTER_SUB "CONVERT_NTFS"

:CHANGE_LETTER
cls
call :HEADER_SUB "Surucu Harfi Degistir"
echo list volume | diskpart
echo.
set /p "vol=   >> Degistirmek istediginiz volume numarasi: "
set /p "new_letter=   >> Yeni harf (tek harf, : olmadan): "
(
echo select volume %vol%
echo assign letter=%new_letter%
) | diskpart
call :FOOTER_SUB "CHANGE_LETTER"

:OPEN_DISKMGMT
start diskmgmt.msc
goto MENU

:CLEAN_USB_REG
cls
call :HEADER_SUB "USB Gecmisini Sil"
echo USB kayit defteri girdileri temizleniyor...
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USB" /f >nul 2>&1
echo Tamamlandi.
call :FOOTER_SUB "USB_REG_CLEAN"

:INFO_BASIC
cls
call :HEADER_SUB "Seri No ve Model"
wmic bios get serialnumber /value
wmic computersystem get manufacturer, model
call :FOOTER_SUB "INFO_BASIC"

:INFO_IP
cls
call :HEADER_SUB "IP Adresleri"
ipconfig | findstr /C:"IPv4" /C:"IP Address"
call :FOOTER_SUB "INFO_IP"

:INFO_LICENSE
cls
call :HEADER_SUB "Windows Lisans Durumu"
cscript //nologo %windir%\system32\slmgr.vbs /xpr
call :FOOTER_SUB "INFO_LICENSE"

:INFO_FULL
cls
call :HEADER_SUB "Detayli Sistem Bilgisi"
systeminfo | more
call :FOOTER_SUB "INFO_FULL"

:INFO_CPU
cls
call :HEADER_SUB "CPU Bilgileri"
wmic cpu get name, numberOfCores, maxClockSpeed
call :FOOTER_SUB "INFO_CPU"

:INFO_RAM
cls
call :HEADER_SUB "RAM Detaylari"
wmic memorychip get capacity, speed, manufacturer, partNumber
call :FOOTER_SUB "INFO_RAM"

:INFO_BIOS
cls
call :HEADER_SUB "Anakart ve BIOS Bilgisi"
wmic baseboard get product, manufacturer, version
wmic bios get name, version
call :FOOTER_SUB "INFO_BIOS"

:INFO_GPU
cls
call :HEADER_SUB "Ekran Karti (GPU) Bilgisi"
wmic path win32_VideoController get name, adapterRAM, driverVersion
call :FOOTER_SUB "INFO_GPU"

:INFO_AUDIO
cls
call :HEADER_SUB "Ses Suruculeri"
wmic sounddev get caption, status
call :FOOTER_SUB "INFO_AUDIO"

:REPORT_BATTERY
cls
call :HEADER_SUB "Pil Raporu Olustur"
powercfg /batteryreport /output "%USERPROFILE%\Desktop\Pil_Raporu.html" 2>nul
if exist "%USERPROFILE%\Desktop\Pil_Raporu.html" (
    echo [OK] Pil raporu masaustune olusturuldu: Pil_Raporu.html
) else (
    echo [UYARI] Pil raporu olusturulamadi (muhtemelen masaustu PC)
)
call :FOOTER_SUB "BATTERY_REPORT"

:INFO_FORMATDATE
cls
call :HEADER_SUB "Son Format Tarihi"
wmic os get installdate
call :FOOTER_SUB "INFO_FORMAT_DATE"

:INFO_STARTUP
cls
call :HEADER_SUB "Baslangic Uygulamalari"
wmic startup get caption, command
call :FOOTER_SUB "INFO_STARTUP"

:INFO_USERS
cls
call :HEADER_SUB "Kullanici Hesaplari"
net user
call :FOOTER_SUB "INFO_USERS"

:INFO_STORAGE
cls
call :HEADER_SUB "Depolama Alanlari"
wmic logicaldisk get caption, size, freespace, drivetype
call :FOOTER_SUB "INFO_STORAGE"

:INFO_BIOS_DETAIL
cls
call :HEADER_SUB "BIOS Surum Detayi"
wmic bios get manufacturer, smbiosbiosversion, releasedate, serialnumber, version
call :FOOTER_SUB "BIOS_DETAIL"

:REPAIR_SFC
cls
call :HEADER_SUB "SFC Sistem Taramasi"
sfc /scannow
call :FOOTER_SUB "REPAIR_SFC"

:REPAIR_CHKDSK
cls
call :HEADER_SUB "CHKDSK Disk Denetimi"
wmic logicaldisk get caption
echo.
set /p "drv=   >> Disk Harfi (: olmadan): "
echo CHKDSK calistiriliyor, lutfen bekleyin...
chkdsk %drv%: /f
echo.
echo Tamamlandi. Bilgisayari yeniden baslattiktan sonra tarama tamamlanacak.
call :FOOTER_SUB "REPAIR_CHKDSK"

:DISM_CHECK
cls
call :HEADER_SUB "DISM CheckHealth"
dism /online /cleanup-image /checkhealth
call :FOOTER_SUB "DISM_CHECK"

:DISM_SCAN
cls
call :HEADER_SUB "DISM ScanHealth"
dism /online /cleanup-image /scanhealth
call :FOOTER_SUB "DISM_SCAN"

:DISM_RESTORE
cls
call :HEADER_SUB "DISM RestoreHealth"
dism /online /cleanup-image /restorehealth
call :FOOTER_SUB "DISM_RESTORE"

:RESET_UPDATE
cls
call :HEADER_SUB "Windows Update Onarimi"
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
ren C:\Windows\SoftwareDistribution SoftwareDistribution.bak >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo Windows Update bilesenleri sifirlandi.
call :FOOTER_SUB "RESET_UPDATE"

:BACKUP_DRIVERS
cls
call :HEADER_SUB "Suruculeri Yedekle"
mkdir "%USERPROFILE%\Desktop\UT_Drivers" >nul 2>&1
dism /online /export-driver /destination:"%USERPROFILE%\Desktop\UT_Drivers"
if exist "%USERPROFILE%\Desktop\UT_Drivers" (
    echo [OK] Suruculer masaustunde 'UT_Drivers' klasorune yedeklendi.
) else (
    echo [HATA] Yedekleme basarisiz oldu.
)
call :FOOTER_SUB "BACKUP_DRIVERS"

:CLEAR_SPOOLER
cls
call :HEADER_SUB "Yazici Kuyrugu Temizleme"
net stop spooler >nul 2>&1
del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*" >nul 2>&1
net start spooler >nul 2>&1
echo Yazici kuyrugu temizlendi.
call :FOOTER_SUB "CLEAR_SPOOLER"

:RESET_ICON_CACHE
cls
call :HEADER_SUB "Icon Cache Sifirlama"
taskkill /f /im explorer.exe >nul 2>&1
del "%localappdata%\IconCache.db" >nul 2>&1
start explorer.exe >nul 2>&1
echo Icon cache temizlendi.
call :FOOTER_SUB "RESET_ICON"

:CLEAN_TEMP
cls
call :HEADER_SUB "Gecici Dosyalari Sil"
echo Temp klasoru temizleniyor...
del /s /f /q "%temp%\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
del /s /f /q "%systemroot%\Prefetch\*.*" >nul 2>&1
echo Tamamlandi.
call :FOOTER_SUB "CLEAN_TEMP"

:OPTIMIZE_RAM
cls
call :HEADER_SUB "RAM Optimizasyonu"
ipconfig /flushdns >nul
echo off | clip >nul 2>&1
echo RAM onbellegi temizlendi.
call :FOOTER_SUB "OPTIMIZE_RAM"

:DEL_WIN_OLD
cls
call :HEADER_SUB "Windows.old Klasoru Silme"
if exist "C:\Windows.old" (
    echo Windows.old klasoru siliniyor...
    takeown /f "C:\Windows.old" /r /d y >nul 2>&1
    icacls "C:\Windows.old" /grant administrators:F /t >nul 2>&1
    rd /s /q "C:\Windows.old" >nul 2>&1
    echo Tamamlandi.
) else (
    echo Windows.old klasoru bulunamadi.
)
call :FOOTER_SUB "DEL_WIN_OLD"

:CLEAR_EVENTLOGS
cls
call :HEADER_SUB "Olay Loglarini Sil"
echo Olay loglari temizleniyor...
for /F "tokens=*" %%G in ('wevtutil.exe el') do (wevtutil.exe cl "%%G" >nul 2>&1)
echo Tamamlandi.
call :FOOTER_SUB "CLEAR_LOGS"

:UPDATE_WINGET
cls
call :HEADER_SUB "Winget Tumunu Guncelle"
winget upgrade --all
call :FOOTER_SUB "UPDATE_WINGET"

:RESET_HOSTS
cls
call :HEADER_SUB "Hosts Dosyasi Sifirlama"
echo 127.0.0.1 localhost > "%systemroot%\system32\drivers\etc\hosts"
echo ::1 localhost >> "%systemroot%\system32\drivers\etc\hosts"
echo Hosts dosyasi sifirlandi.
call :FOOTER_SUB "RESET_HOSTS"

:DISABLE_TELEMETRY
cls
call :HEADER_SUB "Telemetriyi Kapat"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo Telemetri devre disi birakildi.
call :FOOTER_SUB "DISABLE_TELEMETRY"

:ULTRA_PERFORMANCE
cls
call :HEADER_SUB "Nihai Performans Modu"
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
echo Performans plani etkinlestirildi.
call :FOOTER_SUB "ULTRA_PERF"

:UPTIME
cls
call :HEADER_SUB "Sistem Calisma Suresi"
net stats srv | find "since"
call :FOOTER_SUB "UPTIME"

:NET_WIFI_PASS
cls
call :HEADER_SUB "Wi-Fi Sifrelerini Gor"
netsh wlan show profiles
echo.
set /p "wifi=   >> Wi-Fi Adi: "
netsh wlan show profile name="%wifi%" key=clear
call :FOOTER_SUB "WIFI_PASS"

:NET_RESET_STACK
cls
call :HEADER_SUB "Ag Ayarlarini Sifirla"
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
echo Ag yapilari sifirlandi. Yeniden baslatmaniz gerekebilir.
call :FOOTER_SUB "NET_RESET"

:FIND_BAD_DRIVERS
cls
call :HEADER_SUB "Hatali Suruculeri Bul"
driverquery /v | findstr /i "error fail stopped"
call :FOOTER_SUB "BAD_DRIVERS"

:PORT_LISTENER
cls
call :HEADER_SUB "Port Dinleyici (PID)"
netstat -ano | findstr "LISTENING"
call :FOOTER_SUB "PORT_LIST"

:FIND_BIG_FILES
cls
call :HEADER_SUB "Buyuk Dosyalari Bul"
echo Lutfen bekleyin, C: surucusu taraniyor...
echo 1GB'dan buyuk dosyalar:
echo.
forfiles /p C:\ /s /m *.* /c "cmd /c if @fsize geq 1073741824 echo @path - @fsize byte" 2>nul | more
call :FOOTER_SUB "BIG_FILES"

:DISK_SMART
cls
call :HEADER_SUB "Surucu Sagligi (SMART)"
wmic diskdrive get model, status, size, interfaceType
call :FOOTER_SUB "DISK_SMART"

:CLEAN_BROWSER_CACHE
cls
call :HEADER_SUB "Tarayici Cache Sil"
echo Tarayicilar kapatiliyor...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo Cache temizleniyor...
del /q /s /f "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /q /s /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
echo Tamamlandi.
call :FOOTER_SUB "BROWSER_CLEAN"

:CREATE_GODMODE
cls
call :HEADER_SUB "GodMode Olustur"
mkdir "%USERPROFILE%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 2>nul
if exist "%USERPROFILE%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" (
    echo GodMode klasoru masaustunde olusturuldu.
) else (
    echo GodMode zaten mevcut veya olusturulamadi.
)
call :FOOTER_SUB "GODMODE"

:ENABLE_OLD_PHOTO
cls
call :HEADER_SUB "Klasik Foto Goruntuleyici"
reg add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_SZ /d "\"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >nul 2>&1
reg add "HKCR\.jpg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f >nul 2>&1
reg add "HKCR\.jpeg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f >nul 2>&1
reg add "HKCR\.png\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f >nul 2>&1
echo Klasik Foto Goruntuleyici etkinlestirildi.
call :FOOTER_SUB "OLD_PHOTO"

:KILL_NOT_RESPONDING
cls
call :HEADER_SUB "Yanit Vermeyenleri Kapat"
taskkill /f /fi "status eq not responding" >nul 2>&1
echo Yanit vermeyen uygulamalar kapatildi.
call :FOOTER_SUB "KILL_PROCESS"

:RESET_FIREWALL
cls
call :HEADER_SUB "Firewall Sifirla"
netsh advfirewall reset
echo Firewall ayarlari sifirlandi.
call :FOOTER_SUB "FIREWALL_RESET"

:HOSTS_BACKUP
cls
call :HEADER_SUB "Hosts Yedekle"
copy "%systemroot%\system32\drivers\etc\hosts" "%USERPROFILE%\Desktop\hosts_yedek.txt" >nul 2>&1
if exist "%USERPROFILE%\Desktop\hosts_yedek.txt" (
    echo Hosts dosyasi masaustune yedeklendi.
) else (
    echo Yedekleme basarisiz.
)
call :FOOTER_SUB "HOSTS_BACKUP"

:RESET_POWER_PLANS
cls
call :HEADER_SUB "Guc Planini Sifirla"
powercfg -restoredefaultschemes >nul 2>&1
echo Guc planlari varsayilana sifirlandi.
call :FOOTER_SUB "POWER_RESET"

:: --- KISA YOLLAR VE DIREKT ARACLAR ---
:RESTART_EXPLORER
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe >nul 2>&1
goto MENU

:DISK_CLEANUP_TOOL
start cleanmgr
goto MENU

:CLEAR_CLIPBOARD
echo off | clip >nul 2>&1
goto MENU

:UPDATE_STORE
start ms-windows-store:
goto MENU

:DISABLE_HIBERNATE
powercfg -h off >nul 2>&1
goto MENU

:TOGGLE_EXT
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt') do set "current=%%a"
    if "!current!"=="0x1" (set "new=0") else (set "new=1")
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d !new! /f >nul 2>&1
    taskkill /f /im explorer.exe >nul 2>&1
    start explorer.exe >nul 2>&1
)
goto MENU

:TOGGLE_HIDDEN
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden') do set "current=%%a"
    if "!current!"=="0x2" (set "new=1") else (set "new=2")
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d !new! /f >nul 2>&1
    taskkill /f /im explorer.exe >nul 2>&1
    start explorer.exe >nul 2>&1
)
goto MENU

:NET_FLUSHDNS
ipconfig /flushdns
goto MENU

:NET_IP_RENEW
ipconfig /release
ipconfig /renew
goto MENU

:NET_PING
ping 8.8.8.8 -n 4
pause
goto MENU

:NET_TRACERT
set /p "site=   >> Hedef site (ornek: google.com): "
tracert %site%
pause
goto MENU

:NET_NETSTAT
netstat -an | more
pause
goto MENU

:NET_MAC
getmac /v
pause
goto MENU

:NET_ARP
arp -a
pause
goto MENU

:NET_CHECK_CONN
ping www.google.com -n 2
pause
goto MENU

:TOOL_DEV
start devmgmt.msc
goto MENU

:TOOL_CONTROL
start control
goto MENU

:TOOL_TASK
start taskmgr
goto MENU

:TOOL_SERVICE
start services.msc
goto MENU

:TOOL_REG
start regedit
goto MENU

:TOOL_MSCONFIG
start msconfig
goto MENU

:TOOL_DXDIAG
start dxdiag
goto MENU

:TOOL_OSK
start osk
goto MENU

:SEC_ADMIN_ON
cls
call :HEADER_SUB "Admin Hesabi Aktiflestir"
net user administrator /active:yes
echo Administrator hesabi aktiflestirildi.
call :FOOTER_SUB "ADMIN_ON"

:SEC_ADMIN_OFF
cls
call :HEADER_SUB "Admin Hesabi Devre Disi"
net user administrator /active:no
echo Administrator hesabi devre disi birakildi.
call :FOOTER_SUB "ADMIN_OFF"

:SEC_FIREWALL
start firewall.cpl
goto MENU

:SEC_LOCK
rundll32.exe user32.dll,LockWorkStation
goto MENU

:POWER_SHUTDOWN_TIMER
shutdown -s -t 3600
echo Bilgisayar 1 saat sonra kapatilacak.
pause
goto MENU

:POWER_ABORT
shutdown -a
echo Kapatma islemi iptal edildi.
call :FOOTER_SUB "SHUTDOWN_ABORT"
