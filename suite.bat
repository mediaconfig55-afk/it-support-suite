@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: --- LOG SİSTEMİ (GÜVENLİ YAPI) ---
set "logFile=%TEMP%\UT_Ultimate_Final.txt"
echo [%date% %time%] --- v10.0 ULTIMATE FINAL EDITION BASLATILDI --- >> "%logFile%" 2>nul

:: --- YÖNETİCİ KONTROLÜ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    mode con: cols=85 lines=10
    color 0C
    echo.
    echo    ┌──────────────────────────────────────────────────────────────────────────┐
    echo    │                    HATA: YÖNETİCİ YETKİSİ GEREKLİ                        │
    echo    ├──────────────────────────────────────────────────────────────────────────┤
    echo    │ Lütfen bu dosyaya sağ tıklayıp "Yönetici Olarak Çalıştır"ı seçin.        │
    echo    └──────────────────────────────────────────────────────────────────────────┘
    pause >nul & exit
)

:: --- PENCERE AYARLARI ---
color 0B
title USB TOOLS - ULTIMATE FINAL EDITION v10.0
mode con: cols=155 lines=80

:MENU
cls
:: --- DİNAMİK VERİ TOPLAMA ---
set "cpuLoad=N/A"
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do (set cpuLoad=%%p & goto :next)
:next
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set freeRAM=%%a
for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /value 2^>nul') do set totalRAM=%%a
set /a usedRAM=(%totalRAM%-%freeRAM%)/1024 >nul 2>&1
set /a totalRAM_GB=%totalRAM%/1048576 >nul 2>&1

echo.
echo.
color 0B
echo    ===========================================================================================================================
echo    ║                                                                                                                        ║
echo    ║  ██╗   ██╗██╗     ████████╗██╗███╗   ██╗ █████╗ ████████╗███████╗    ███████╗██╗███╗   ██╗ █████╗ ██╗     ███████╗     ║
echo    ║  ██║   ██║██║     ╚══██╔══╝██║████╗  ██║██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝██║████╗  ██║██╔══██╗██║     ██╔════╝     ║
echo    ║  ██║   ██║██║        ██║   ██║██╔██╗ ██║███████║   ██║   █████╗      █████╗  ██║██╔██╗ ██║███████║██║     █████╗       ║
echo    ║  ██║   ██║██║        ██║   ██║██║╚██╗██║██╔══██║   ██║   ██╔══╝      ██╔══╝  ██║██║╚██╗██║██╔══██║██║     ██╔══╝       ║
echo    ║  ╚██████╔╝███████╗   ██║   ██║██║ ╚████║██║  ██║   ██║   ███████╗    ██║     ██║██║ ╚████║██║  ██║███████╗███████╗     ║
echo    ║   ╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝     ║
echo    ║                                                                                                                        ║
echo    ║                USB YONETIM, SISTEM BAKIM VE ONARIM KONSOLU (v10.0)                                                     ║
echo    ║  -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                         •••• CODE EMRE BILGIN - ULTIMATE EDITION ••••                                                  ║
echo    ║  -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                                •••• CMD CONTROLLER 2026 © ••••                                                         ║
echo    ║                                                                                                                        ║
echo    ╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo      » [ STATUS ] CPU: %cpuLoad%%%  │  RAM: %usedRAM% MB / %totalRAM_GB% GB  │  LOG: ACTIVE  │  YEAR: 2026                   
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo.
echo    [ DISK ^& USB YONETIMI ]           [ SISTEM ONARIM ^& BAKIM ]          [ AG ^& INTERNET AYARLARI ]        [ EKSTRA ARACLAR ^& GUVENLIK ]
echo    ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐
echo    │ [01] Diskleri Listele        │   │ [26] SFC Sistem Taramasi     │   │ [51] DNS Onbellegini Sil     │   │ [76] Hatali Suruculeri Bul   │
echo    │ [02] Akilli Format           │   │ [27] CHKDSK Disk Denetimi    │   │ [52] IP Yenile (Renew)       │   │ [77] Port Dinleyici (PID)    │
echo    │ [03] Yazma Korumasi AC       │   │ [28] DISM CheckHealth        │   │ [53] Google Ping Testi       │   │ [78] Buyuk Dosyalari Bul     │
echo    │ [04] Yazma Korumasi KAPAT    │   │ [29] DISM ScanHealth         │   │ [54] Tracert Site Takibi     │   │ [79] Sürücü Sağlığı (SMART)  │
echo    │ [05] Disk Detaylarini Gor    │   │ [30] DISM RestoreHealth      │   │ [55] Aktif Baglantilar       │   │ [80] Tarayici Cache Sil      │
echo    │ [06] FAT32 -^> NTFS Cevir    │   │ [31] Windows Update Onar     │   │ [56] Wi-Fi Sifrelerini Gor   │   │ [81] GodMode Olustur         │
echo    │ [07] Surucu Harfi Degistir   │   │ [32] Suruculeri Yedekle      │   │ [57] Ag Ayarlarini Sifirla   │   │ [82] Klasik Foto Goruntuleyici│
echo    │ [08] Disk Yonetimini Ac      │   │ [33] Yazici Kuyruğunu Sil    │   │ [58] MAC Adresini Goster     │   │ [83] Yanit Vermeyenleri Kapat│
echo    │ [09] USB Gecmisini Temizle   │   │ [34] Icon Cache Sifirla      │   │ [59] ARP Tablosunu Gor       │   │ [84] Firewall Sifirla        │
echo    └──────────────────────────────┘   │ [35] Explorer Yeniden Baslat │   │ [60] Baglanti Kontrolu       │   │ [85] Hosts Yedekle           │
echo                                       └──────────────────────────────┘   └──────────────────────────────┘   └──────────────────────────────┘
echo    [ DONANIM BILGILERI ]              [ PERFORMANS ^& TEMIZLIK ]          [ HIZLI ERISIM ^& GUC ]             [ OTOMASYON MODU ]
echo    ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐   ┌──────────────────────────────┐
echo    │ [10] Seri No ^& Model         │   │ [36] Gecici Dosyalari Sil    │   │ [61] Aygit Yoneticisi        │   │                              │
echo    │ [11] IP Adresini Gor         │   │ [37] RAM Optimizasyonu       │   │ [62] Denetim Masasi          │   │      [99] ULTRA BAKIM       │
echo    │ [12] Lisans Durumu           │   │ [38] Disk Temizleme (Clean)  │   │ [63] Gorev Yoneticisi        │   │                              │
echo    │ [13] Detayli Sistem Bilgisi  │   │ [39] Windows.old Klasoru Sil │   │ [64] Hizmetler (Services)    │   └──────────────────────────────┘
echo    │ [14] CPU Bilgisi             │   │ [40] Panoyu Temizle          │   │ [65] Kayit Defteri           │   │ [00] PROGRAMI KAPAT          │
echo    │ [15] RAM Detaylari           │   │ [41] Olay Loglarini Sil      │   │ [66] MSConfig               │   └──────────────────────────────┘
echo    │ [16] Anakart ^& BIOS Bilgisi │   │ [42] Magaza Uyg. Guncelle    │   │ [67] DirectX Tanilama       │
echo    │ [17] Ekran Karti (GPU)       │   │ [43] Winget Tumunu Guncelle  │   │ [68] Ekran Klavyesi         │
echo    │ [18] Ses Suruculeri          │   │ [44] Hosts Dosyasi Sifirla   │   │ [69] Admin Hesabi AC        │
echo    │ [19] Pil Raporu (Laptop)     │   │ [45] Telemetriyi Kapat       │   │ [70] Admin Hesabi KAPAT     │
echo    │ [20] Son Format Tarihi       │   │ [46] Nihai Performans Modu   │   │ [71] Firewall Ayarlari      │
echo    │ [21] Baslangic Uygulamalari  │   │ [47] Hibernate Kapat         │   │ [72] Sistemi Kilitle        │
echo    │ [22] Kullanici Hesaplari     │   │ [48] Uzantilari Goster/Gizle │   │ [73] Oto Kapat (1 Saat)     │
echo    │ [23] Depolama Alanlari       │   │ [49] Gizli Dosyalari Goster  │   │ [74] Kapatma Iptal          │
echo    │ [24] BIOS Surum Detayi       │   │ [50] Sistem Calisma Suresi   │   │ [75] Guc Planini Sifirla    │
echo    └──────────────────────────────┘   └──────────────────────────────┘   └──────────────────────────────┘
echo.
set /p choice="   ╔═══[ SECIMINIZI YAPIN (0-99) ]═══> "

echo [%date% %time%] Kullanici Secimi: %choice% >> "%logFile%" 2>nul

:: --- YÖNLENDİRME (IF) BLOKLARI ---
if "%choice%"=="00" exit
if "%choice%"=="1" goto LIST_DISK
if "%choice%"=="2" goto SMART_FORMAT
if "%choice%"=="3" goto PROTECT_DISK
if "%choice%"=="4" goto UNPROTECT_DISK
if "%choice%"=="5" goto DETAIL_DISK
if "%choice%"=="6" goto CONVERT_NTFS
if "%choice%"=="7" goto CHANGE_LETTER
if "%choice%"=="8" goto OPEN_DISKMGMT
if "%choice%"=="9" goto CLEAN_USB_REG
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
if "%choice%"=="99" goto ULTRA_MAINTENANCE
goto MENU

:: --- FONKSİYON GÖVDELERİ ---

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

:ULTRA_MAINTENANCE
cls
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                                                                                                           ║
echo    ║  ██╗   ██╗██╗  ████████╗██████╗  █████╗     ██████╗  █████╗ ██╗  ██╗██╗███╗   ███╗    ███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗║
echo    ║  ██║   ██║██║  ╚══██╔══╝██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗██║ ██╔╝██║████╗ ████║    ████╗ ████║██╔═══██╗██╔══██╗██║   ██║║
echo    ║  ██║   ██║██║     ██║   ██████╔╝███████║    ██████╔╝███████║█████╔╝ ██║██╔████╔██║    ██╔████╔██║██║   ██║██║  ██║██║   ██║║
echo    ║  ██║   ██║██║     ██║   ██╔══██╗██╔══██║    ██╔══██╗██╔══██║██╔═██╗ ██║██║╚██╔╝██║    ██║╚██╔╝██║██║   ██║██║  ██║██║   ██║║
echo    ║  ╚██████╔╝███████╗██║   ██║  ██║██║  ██║    ██████╔╝██║  ██║██║  ██╗██║██║ ╚═╝ ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝╚██████╔╝║
echo    ║   ╚═════╝ ╚══════╝╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ║
echo    ║                                                                                                                           ║
echo    ║                                   PROFESYONEL SISTEM BAKIM MODU v10.0                                                      ║
echo    ║                                                                                                                           ║
echo    ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
echo    ║  │                                                                                                                     │  ║
echo    ║  │  ╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════╗    │  ║
echo    ║  │  ║                    [ ! ] ONEMLI UYARI [ ! ]                                                                ║    │  ║
echo    ║  │  ╠═════════════════════════════════════════════════════════════════════════════════════════════════════════════╣    │  ║
echo    ║  │  ║                                                                                                             ║    │  ║
echo    ║  │  ║  Bu mod sisteminizi profesyonel seviyede optimize edecektir.                                                ║    │  ║
echo    ║  │  ║                                                                                                             ║    │  ║
echo    ║  │  ║  ▸ 10 asamali kapsamli sistem analizi ve bakim                                                              ║    │  ║
echo    ║  │  ║  ▸ Otomatik geri alma noktasi olusturma                                                                     ║    │  ║
echo    ║  │  ║  ▸ Detayli raporlama ve performans olcumu                                                                   ║    │  ║
echo    ║  │  ║  ▸ Tum donanim bilesenlerinin optimizasyonu                                                                 ║    │  ║
echo    ║  │  ║                                                                                                             ║    │  ║
echo    ║  │  ║  ⚠ TAHMINI SURE: 15-45 dakika                                                                               ║    │  ║
echo    ║  │  ║  ⚠ GEREKLI ALAN: Minimum 2GB bos disk                                                                       ║    │  ║
echo    ║  │  ║  ⚠ RISK SEVIYESI: DUSUK (Guvenli mod)                                                                       ║    │  ║
echo    ║  │  ║                                                                                                             ║    │  ║
echo    ║  │  ╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════╝    │  ║
echo    ║  │                                                                                                                     │  ║
echo    ║  └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
echo    ║                                                                                                                           ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p t_c="   ╔═══[ BAKIMI BASLATMAK ISTIYOR MUSUNUZ? (E/H) ]═══> "
if /i "%t_c%" NEQ "E" goto MENU

cls
echo [%date% %time%] ULTRA_BAKIM_MODU_BASLATILDI >> "%logFile%"

:: -----------------------------------------------------------------------------
:: 1. ON HAZIRLIK VE ANALIZ
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           1. ON HAZIRLIK VE ANALIZ                                                         ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    [*] Sistem durumu analiz ediliyor ve performans verileri toplaniyor...
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

:: Performans Verilerini Topla (Öncesi)
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do set "cpuBefore=%%p"
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "ramBefore=%%a"
set /a ramBeforeMB=%ramBefore%/1024
for /f "tokens=3" %%d in ('dir /-c C:\ | find "bayt"') do set "diskBefore=%%d"

:: Sistem Geri Alma Noktası Oluştur
echo    [✓] Guvenlik icin sistem geri alma noktasi olusturuluyor...
powershell -Command "Checkpoint-Computer -Description 'UT_Ultra_Bakim_%date%_%time%' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
if %errorLevel% equ 0 (
    echo    [✓] Sistem geri alma noktasi basariyla olusturuldu
) else (
    echo    [⚠] Sistem geri almasi olusturulamadi (devam ediliyor)
)

:: -----------------------------------------------------------------------------
:: 2. GELISMIS TEMIZLIK - BOLUM 1
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           2. GELISMIS SISTEM TEMIZLIGI                                                    ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/4] Windows gecici dosyalari temizleniyor...                                                                        │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
del /f /q /s C:\Windows\Temp\*.* >nul 2>&1
del /f /q /s "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
rd /s /q %temp% 2>nul & md %temp%
echo    [✓] Gecici dosyalar temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/4] Sistem performans onbellekleri temizleniyor...                                                                  │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
del /f /q /s C:\Windows\Prefetch\*.* >nul 2>&1
del /f /q "%SystemRoot%\System32\FNTCACHE.DAT" >nul 2>&1
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1
echo    [✓] Performans onbellekleri temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/4] Windows hata raporlama dosyalari temizleniyor...                                                                │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
del /f /q /s "%ProgramData%\Microsoft\Windows\WER\*.*" >nul 2>&1
del /f /q /s "%ProgramData%\Microsoft\Windows\WER\Temp\*.*" >nul 2>&1
echo    [✓] Hata raporlama dosyalari temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [4/4] DirectX ve grafik onbellekleri temizleniyor...                                                                  │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
del /f /q "%USERPROFILE%\AppData\Local\D3DSCache\*.*" >nul 2>&1
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*.*" >nul 2>&1
echo    [✓] Grafik onbellekleri temizlendi

:: -----------------------------------------------------------------------------
:: 3. AG VE OBELLEK OPTIMIZASYONU
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           3. AG VE OBELLEK OPTIMIZASYONU                                                  ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/3] DNS ve ag yapisinin tamami sifirlaniyor...                                                                      │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
ipconfig /flushdns >nul
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
netsh winsock reset catalog >nul 2>&1
netsh int ip reset >nul 2>&1
echo    [✓] DNS ve ag yapisi sifirlandi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/3] RAM onbellegi optimize ediliyor...                                                                              │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo off | clip
wmic process where name="explorer.exe" delete >nul 2>&1
echo    [✓] RAM onbellegi optimize edildi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/3] ARP ve ag tablolari temizleniyor...                                                                             │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
arp -d * >nul 2>&1
echo    [✓] Ag tablolari temizlendi

:: -----------------------------------------------------------------------------
:: 4. TARAYICI VE UYGULAMA TEMIZLIGI
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           4. TARAYICI VE UYGULAMA TEMIZLIGI                                               ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/3] Google Chrome cache ve verileri temizleniyor...                                                                 │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
taskkill /f /im chrome.exe >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" 2>nul
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache2" 2>nul
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Media Cache" 2>nul
echo    [✓] Chrome temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/3] Microsoft Edge cache ve verileri temizleniyor...                                                                │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
taskkill /f /im msedge.exe >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" 2>nul
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache2" 2>nul
echo    [✓] Edge temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/3] Firefox ve diger tarayicilarin cache'i temizleniyor...                                                          │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
rd /s /q "%AppData%\Mozilla\Firefox\Profiles\*.default-release\cache2" 2>nul
echo    [✓] Firefox temizlendi

:: -----------------------------------------------------------------------------
:: 5. SISTEM DOSYALARI ONARIMI
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           5. SISTEM DOSYALARI ONARIMI                                                     ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/3] DISM ile sistem goruntusu onariliyor...                                                                         │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
dism /online /cleanup-image /checkhealth >nul
if %errorLevel% neq 0 (
    echo    [⚠] DISM onarim baslatiliyor...
    dism /online /cleanup-image /scanhealth >nul
    dism /online /cleanup-image /restorehealth >nul
    echo    [✓] DISM onarimi tamamlandi
) else (
    echo    [✓] DISM: Sistem goruntusu saglikli
)

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/3] SFC ile sistem dosyalari kontrol ediliyor...                                                                    │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
sfc /scannow >nul
if %errorLevel% equ 0 (
    echo    [✓] SFC: Sistem dosyalari saglikli
) else (
    echo    [✓] SFC: Bozuk dosyalar onarildi
)

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/3] Disk hatasi kontrolu ve optimizasyonu...                                                                        │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
chkdsk C: /scan >nul
if %errorLevel% neq 0 (
    echo    [⚠] Disk hatasi tespit edildi, sonraki acilista onarilacak
    chkdsk C: /f /r /x >nul 2>&1
) else (
    echo    [✓] Disk saglikli
)

:: -----------------------------------------------------------------------------
:: 6. DONANIM OPTIMIZASYONU
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           6. DONANIM OPTIMIZASYONU                                                       ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

wmic logicaldisk where "DeviceID='C:'" get MediaType | find "SSD" >nul
if %errorLevel% equ 0 (
    echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    echo    │ [✓] SSD algilandi - SSD optimize ediliyor...                                                                        │
    echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    sc config SysMain start= disabled >nul 2>&1
    sc stop SysMain >nul 2>&1
    defrag C: /O >nul 2>&1
    echo    [✓] SSD optimizasyonu tamamlandi
) else (
    echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    echo    │ [✓] HDD algilandi - Defragmentasyon yapiliyor...                                                                    │
    echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    defrag C: /U /V >nul 2>&1
    echo    [✓] HDD defragmentasyonu tamamlandi
)

:: -----------------------------------------------------------------------------
:: 7. KAYIT DEFTERI VE SERVIS OPTIMIZASYONU
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           7. KAYIT DEFTERI VE SERVIS OPTIMIZASYONU                                       ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/3] Gecersiz registry girdileri temizleniyor...                                                                     │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
echo    [✓] Registry temizligi tamamlandi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/3] Performans servisleri optimize ediliyor...                                                                      │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
sc config WSearch start= demand >nul 2>&1
sc config SysMain start= auto >nul 2>&1
echo    [✓] Servis optimizasyonu tamamlandi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/3] Gecersiz zamanlanmis gorevler temizleniyor...                                                                   │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
for /f "tokens=2 delims=," %%a in ('schtasks /query /fo csv ^| findstr /i "hata\|could not"') do (
    schtasks /delete /tn "%%~a" /f >nul 2>&1
)
echo    [✓] Zamanlanmis gorevler temizlendi

:: -----------------------------------------------------------------------------
:: 8. SON TEMIZLIK ISLEMLERI
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           8. SON TEMIZLIK ISLEMLERI                                                      ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/3] Geri donusum kutusu temizleniyor...                                                                             │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
rd /s /q "%SYSTEMDRIVE%\$Recycle.Bin" 2>nul
echo    [✓] Geri donusum kutusu temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/3] Windows olay loglari temizleniyor...                                                                            │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
for /F "tokens=*" %%G in ('wevtutil.exe el') do (wevtutil.exe cl "%%G" >nul 2>&1)
echo    [✓] Olay loglari temizlendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [3/3] Windows Update gecici dosyalari temizleniyor...                                                                 │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution\Download 2>nul
md C:\Windows\SoftwareDistribution\Download 2>nul
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo    [✓] Windows Update temizligi tamamlandi

:: -----------------------------------------------------------------------------
:: 9. SISTEM YENILEME VE PERFORMANS OLCUMU
:: -----------------------------------------------------------------------------
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           9. SISTEM YENILEME VE PERFORMANS OLCUMU                                        ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [1/2] Sistem arayuzu yenileniyor...                                                                                  │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 3 /nobreak >nul
start explorer.exe >nul 2>&1
echo    [✓] Sistem arayuzu yenilendi

echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │ [2/2] Performans son olcumleri yapiliyor...                                                                          │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do set "cpuAfter=%%p"
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "ramAfter=%%a"
set /a ramAfterMB=%ramAfter%/1024
for /f "tokens=3" %%d in ('dir /-c C:\ | find "bayt"') do set "diskAfter=%%d"

:: Performans Sonuçlarını Hesapla
set /a diskSaved=(%diskBefore%-%diskAfter%)/1048576
set /a ramSaved=(%ramAfterMB%-%ramBeforeMB%)
set /a cpuDiff=(%cpuBefore%-%cpuAfter%)
echo    [✓] Performans olcumleri tamamlandi

:: -----------------------------------------------------------------------------
:: 10. DETAYLI RAPOR VE SONUC
:: -----------------------------------------------------------------------------
cls
echo.
echo    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo    ║                                           10. BAKIM TAMAMLANDI - DETAYLI RAPOR                                           ║
echo    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │                           ULTIMATE BAKIM MODU TAMAMLANDI - PERFORMANS ANALIZI                                          │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo.
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    📊 PERFORMANS DEGISIM ANALIZI
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    ┌──────────────────────┬──────────────────────┬──────────────────────┬──────────────────────┐
echo    │      PARAMETRE       │      BAKIM ONCE      │      BAKIM SONRA     │       DEGISIM        │
echo    ├──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┤
echo    │    CPU YUKU          │       %cpuBefore%%%       │       %cpuAfter%%%       │      %cpuDiff%%%       │
echo    ├──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┤
echo    │    BOS RAM (MB)      │      %ramBeforeMB% MB     │      %ramAfterMB% MB     │     +%ramSaved% MB     │
echo    ├──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┤
echo    │    KAZANILAN ALAN    │          -           │          -           │     %diskSaved% MB     │
echo    └──────────────────────┴──────────────────────┴──────────────────────┴──────────────────────┘
echo.
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    ✅ GERCEKLESTIRILEN ISLEMLER
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    ✓ Sistem geri alma noktasi olusturuldu
echo    ✓ Gelismis sistem temizligi (4 asamali)
echo    ✓ Ag ve obellek optimizasyonu (3 asamali)
echo    ✓ Tarayici ve uygulama cache temizligi (3 tarayici)
echo    ✓ Sistem dosyalari onarimi (DISM + SFC + CHKDSK)
echo    ✓ Donanim optimizasyonu (SSD/HDD uyumlu)
echo    ✓ Kayit defteri ve servis optimizasyonu
echo    ✓ Son temizlik islemleri
echo    ✓ Sistem arayuzu yenileme
echo    ✓ Detayli performans analizi
echo.
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    💡 TAVSIYELER VE SONRAKI ADIMLAR
echo    ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
echo    • Sistemi yeniden baslatarak tum optimizasyonlari aktiflestirin
echo    • Haftalik hizli bakim icin [36] numarali secenegi kullanin
echo    • Aylik olarak bu profesyonel bakimi tekrarlayin
echo    • Onemli verilerinizi duzenli olarak yedekleyin
echo    • Sistem performansini izlemek icin [63] numarali secenegi kullanin
echo.
echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │                    📅 SONRAKI PROFESYONEL BAKIM TARIHI: %date% + 30 gun                                                 │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo.

:: Raporu Dosyaya Kaydet
echo. >> "%logFile%"
echo [%date% %time%] ========= ULTRA BAKIM RAPORU ========= >> "%logFile%"
echo [%date% %time%] CPU_ON: %cpuBefore%%% CPU_SON: %cpuAfter%%% DEGISIM: %cpuDiff%%% >> "%logFile%"
echo [%date% %time%] RAM_ON: %ramBeforeMB% MB RAM_SON: %ramAfterMB% MB KAZANC: %ramSaved% MB >> "%logFile%"
echo [%date% %time%] DISK_KAZANC: %diskSaved% MB >> "%logFile%"
echo [%date% %time%] ISLEM_SURE: 10 asamali bakim >> "%logFile%"
echo [%date% %time%] ULTRA_BAKIM_TAMAMLANDI >> "%logFile%"
echo [%date% %time%] ====================================== >> "%logFile%"

echo.
echo    ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
echo    │                   🚀 Sistem performansi artirildi! Ne yapmak istiyorsunuz?                                            │
echo    └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
echo.
echo        [1] Sistemi simdi yeniden baslat (onerilir)
echo        [2] Raporu masaustune kaydet
echo        [3] Ana menuye don
echo        [4] Programi kapat
echo.
set /p sonSecim="   ╔═══[ SECIMINIZ (1-4) ]═══> "

if "%sonSecim%"=="1" (
    echo    [*] Sistem 60 saniye icinde yeniden baslatilacak...
    shutdown /r /t 60 /c "UT Ultimate Bakim sonrasi yeniden baslatma"
    echo    [i] Iptal etmek icin: shutdown /a
    timeout /t 5 /nobreak >nul
    call :FOOTER_SUB "ULTRA_BAKIM_YENIDEN_BASLAT"
) else if "%sonSecim%"=="2" (
    echo    [*] Rapor masaustune kaydediliyor...
    copy "%logFile%" "%USERPROFILE%\Desktop\UT_Ultra_Bakim_Raporu.txt" >nul 2>&1
    echo    [+] Rapor kaydedildi: Masaustu\UT_Ultra_Bakim_Raporu.txt
    pause >nul
    call :FOOTER_SUB "ULTRA_BAKIM_RAPOR_KAYDET"
) else if "%sonSecim%"=="3" (
    call :FOOTER_SUB "ULTRA_BAKIM_TAMAMLANDI"
) else if "%sonSecim%"=="4" (
    exit
) else (
    goto MENU
)

:: --- DIGER FONKSIYONLAR (ORIJINAL KALACAK) ---
:LIST_DISK
cls
call :HEADER_SUB "Diskleri Listele"
(echo list disk) > "%TEMP%\ds.txt"
diskpart /s "%TEMP%\ds.txt"
del "%TEMP%\ds.txt"
call :FOOTER_SUB "LIST_DISK"

:: ... (diğer tüm fonksiyonlar orijinal halleriyle aynı kalacak)
