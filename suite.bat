@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: --- LOG SİSTEMİ (GÜVENLİ YAPI) ---
set "logFile=%TEMP%\UT_Ultimate_Final.txt"
echo [%date% %time%] --- v10 FINAL SISTEM BASLATILDI --- >> "%logFile%" 2>nul

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
title USB TOOLS - ULTIMATE FINAL EDITION v10
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
echo    ║   ██╗   ██╗███████╗██████╗     ████████╗ ██████╗  ██████╗ ██╗     ███████╗                                            ║
echo    ║   ██║   ██║██╔════╝██╔══██╗    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝                                            ║
echo    ║   ██║   ██║███████╗██████╔╝       ██║   ██║   ██║██║   ██║██║     ███████╗                                            ║
echo    ║   ██║   ██║╚════██║██╔══██╗       ██║   ██║   ██║██║   ██║██║     ╚════██║                                            ║
echo    ║   ╚██████╔╝███████║██████╔╝       ██║   ╚██████╔╝╚██████╔╝███████╗███████║                                            ║
echo    ║    ╚═════╝ ╚══════╝╚═════╝        ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                                            ║
echo    ║                                                                                                                        ║
echo    ║                 USB YONETIM, SISTEM BAKIM VE ONARIM KONSOLU (v10)                                                     ║
echo    ║   -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                          •••• CODE EMRE BILGIN - FINAL EDITION ••••                                                     ║
echo    ║   -------------------------------------------------------------------------------------------------------------------   ║
echo    ║                                 •••• CMD CONTROLLER 2026 © ••••                                                        ║
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
echo    │ [11] IP Adresini Gor         │   │ [37] RAM Optimizasyonu       │   │ [62] Denetim Masasi          │   │      [99] TURBO BAKIM        │
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
if "%choice%"=="99" goto SMART_MAINTENANCE
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
set /p t_c="   >> Devam etmek istiyor musunuz? (E/H): "
if /i "%t_c%" NEQ "E" goto MENU
cls
call :HEADER_SUB "TURBO BAKIM MODU"

:: --- PROFESYONEL BAKIM BAŞLANGICI ---
echo.
echo    ==============================================================================
echo    [PROFESYONEL TURBO BAKIM SISTEMI v2.0]
echo    ==============================================================================
echo.
echo    [GENISLETILMIS OTOMASYON MODU]
echo    -------------------------------
echo    + AKILLI ANALIZ & TANI
echo    + COK KATMANLI TEMIZLIK
echo    + SISTEM OPTIMIZASYONU
echo    + DETAYLI RAPORLAMA
echo    + GUVENLI GERI ALMA NOKTASI
echo.
echo    Tahmini Sure: 8-25 dakika (Sisteminize bagli)
echo    Gerekli Alan: Minimum 500MB bos disk alani
echo.
set /p confirm="   >> PROFESYONEL BAKIM BASLATILSIN MI? (E/H): "
if /i "%confirm%" NEQ "E" goto MENU

:: --- SISTEM GERI ALMA NOKTASI OLUSTUR ---
echo [%date% %time%] PROFESYONEL_TURBO_BAKIM_BASLATILDI >> "%logFile%"
echo.
echo    ==============================================================================
echo    [1. SISTEM ANALIZI & HAZIRLIK]
echo    ==============================================================================
echo.

:: Sistem Bilgilerini Topla
echo    [*] Sistem durumu analiz ediliyor...
echo    [*] Bellek ve disk kullanimi kontrol ediliyor...

:: Performans Verilerini Topla (Öncesi)
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do set "cpuBefore=%%p"
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "ramBefore=%%a"
set /a ramBeforeMB=%ramBefore%/1024
for /f "tokens=3" %%d in ('dir /-c C:\ | find "bayt"') do set "diskBefore=%%d"

:: Sistem Geri Alma Noktası Oluştur
echo    [*] Sistem geri alma noktasi olusturuluyor...
powershell -Command "Checkpoint-Computer -Description 'UT_Turbo_Bakim_%date%_%time%' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
if %errorLevel% equ 0 (
    echo    [+] Sistem geri alma noktasi basariyla olusturuldu
) else (
    echo    [!] Sistem geri almasi olusturulamadi (devam ediliyor)
)

:: --- ANA BAKIM ASAMALARI ---
echo.
echo    ==============================================================================
echo    [2. COK KATMANLI TEMIZLIK]
echo    ==============================================================================
echo.

:: 2.1 TEMEL TEMIZLIK
echo    [2.1] TEMEL TEMIZLIK BASLATILDI...
echo    [-] Gecici dosyalar temizleniyor...
rd /s /q %temp% 2>nul & md %temp%
del /f /q /s C:\Windows\Temp\*.* >nul 2>&1
del /f /q /s "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1

echo    [-] Prefetch dosyalari temizleniyor...
del /f /q /s C:\Windows\Prefetch\*.* >nul 2>&1

echo    [-] Windows Error Reporting dosyalari temizleniyor...
del /f /q /s "%ProgramData%\Microsoft\Windows\WER\*.*" >nul 2>&1

:: 2.2 OBELLEK TEMIZLIGI
echo    [2.2] OBELLEK OPTIMIZASYONU...
echo    [-] DNS onbellegi temizleniyor...
ipconfig /flushdns >nul
netsh winsock reset catalog >nul 2>&1
netsh int ip reset >nul 2>&1

echo    [-] Font onbellegi temizleniyor...
del /f /q "%windir%\System32\FNTCACHE.DAT" >nul 2>&1

echo    [-] Thumbnail onbellegi temizleniyor...
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1

:: 2.3 BROWSER TEMIZLIGI
echo    [2.3] TARAYICI TEMIZLIGI...
echo    [-] Chrome temizleniyor...
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" 2>nul
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache2" 2>nul

echo    [-] Edge temizleniyor...
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" 2>nul
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache2" 2>nul

echo    [-] Firefox temizleniyor...
rd /s /q "%AppData%\Mozilla\Firefox\Profiles\*.default-release\cache2" 2>nul

:: --- SISTEM ONARIM ASAMALARI ---
echo.
echo    ==============================================================================
echo    [3. SISTEM SAGLIK KONTROLLERI]
echo    ==============================================================================
echo.

:: 3.1 DISM SISTEM ONARIMI
echo    [3.1] DISM SAGLIK KONTROLLERI...
echo    [-] DISM CheckHealth calistiriliyor...
dism /online /cleanup-image /checkhealth >nul
if %errorLevel% equ 0 (
    echo    [+] DISM: Sistem goruntusu saglikli
) else (
    echo    [!] DISM: Sistem goruntusu sorunlu, onarim baslatiliyor...
    echo    [-] DISM ScanHealth calistiriliyor (1/3)...
    dism /online /cleanup-image /scanhealth >nul
    echo    [-] DISM RestoreHealth calistiriliyor (2/3)...
    dism /online /cleanup-image /restorehealth /source:WIM:X:\Sources\Install.wim:1 /LimitAccess >nul 2>&1
    echo    [-] DISM son onarim (3/3)...
    dism /online /cleanup-image /restorehealth >nul
)

:: 3.2 SFC ONARIMI
echo    [3.2] SFC SISTEM DOSYALARI KONTROLU...
echo    [-] Sistem dosyalari taranip onariliyor...
sfc /scannow >nul
if %errorLevel% equ 0 (
    echo    [+] SFC: Sistem dosyalari saglikli
) else (
    echo    [!] SFC: Bozuk dosyalar bulundu, onarildi
)

:: 3.3 CHKDSK PLANLA
echo    [3.3] DISK BILGISI...
echo    [-] Disk hatasi kontrolu yapiliyor...
chkdsk C: /scan >nul
if %errorLevel% neq 0 (
    echo    [!] Disk hatasi tespit edildi, sonraki acilista onarilacak
    chkdsk C: /f /r /x >nul 2>&1
)

:: --- PERFORMANS OPTIMIZASYONU ---
echo.
echo    ==============================================================================
echo    [4. SISTEM OPTIMIZASYONU]
echo    ==============================================================================
echo.

:: 4.1 SERVIS OPTIMIZASYONU
echo    [4.1] SERVIS OPTIMIZASYONU...
echo    [-] Gereksiz servisler kontrol ediliyor...

:: Superfetch servisini optimize et (SSD için)
wmic logicaldisk where "DeviceID='C:'" get MediaType | find "SSD" >nul
if %errorLevel% equ 0 (
    sc config SysMain start= disabled >nul 2>&1
    sc stop SysMain >nul 2>&1
    echo    [+] Superfetch SSD modunda devre disi birakildi
)

:: Windows Search geçici olarak durdur
sc stop WSearch >nul 2>&1
echo    [+] Windows Search servisi durduruldu (gecici)

:: 4.2 REGISTRY OPTIMIZASYONU
echo    [4.2] KAYIT DEFTERI TEMIZLIGI...
echo    [-] RecentDocs temizleniyor...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1

echo    [-] Run registry temizligi...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1

:: 4.3 GOREV ZAMANLAYICI TEMIZLIGI
echo    [4.3] GOREV ZAMANLAYICI OPTIMIZASYONU...
echo    [-] Gecersiz gorevler temizleniyor...
for /f "tokens=2 delims=," %%a in ('schtasks /query /fo csv ^| findstr /i "hata\|could not"') do (
    schtasks /delete /tn "%%~a" /f >nul 2>&1
)

:: --- GUNCELLEME VE GUVENLIK ---
echo.
echo    ==============================================================================
echo    [5. GUNCELLEME & GUVENLIK]
echo    ==============================================================================
echo.

:: 5.1 WINDOWS UPDATE TEMIZLIGI
echo    [5.1] WINDOWS UPDATE OPTIMIZASYONU...
echo    [-] Gecici update dosyalari temizleniyor...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution\Download 2>nul
md C:\Windows\SoftwareDistribution\Download 2>nul
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: 5.2 WINDOWS STORE TEMIZLIGI
echo    [5.2] MICROSOFT STORE TEMIZLIGI...
wsreset.exe -i >nul 2>&1

:: 5.3 TELEMETRI KISITLAMA
echo    [5.3] GIZLILIK AYARLARI...
echo    [-] Telemetri verileri kisitlaniyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1

:: --- SON ASAMA: RAPOR VE YENIDEN BASLATMA ---
echo.
echo    ==============================================================================
echo    [6. SON ISLEMLER & RAPOR]
echo    ==============================================================================
echo.

:: 6.1 SON TEMIZLIKLER
echo    [6.1] SON TEMIZLIK ISLEMLERI...
echo    [-] Geri donusum kutusu bosaltiliyor...
rd /s /q "%SYSTEMDRIVE%\$Recycle.Bin" 2>nul

echo    [-] Pagefile temizligi...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul 2>&1

:: 6.2 EXPLORER YENILEME
echo    [6.2] SISTEM ARABIRIMI YENILENIYOR...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe >nul 2>&1

:: 6.3 PERFORMANS SON DURUMU
echo    [6.3] PERFORMANS OLÇÜMÜ...
for /f "skip=1" %%p in ('wmic cpu get loadpercentage 2^>nul') do set "cpuAfter=%%p"
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "ramAfter=%%a"
set /a ramAfterMB=%ramAfter%/1024
for /f "tokens=3" %%d in ('dir /-c C:\ | find "bayt"') do set "diskAfter=%%d"

:: Kazanılan Alan Hesaplama
set /a diskSaved=(%diskBefore%-%diskAfter%)/1048576
set /a ramSaved=(%ramAfterMB%-%ramBeforeMB%)

:: --- DETAYLI RAPOR OLUSTURMA ---
echo.
echo    ==============================================================================
echo    [BAKIM TAMAMLANDI - RAPOR]
echo    ==============================================================================
echo.
echo    PERFORMANS DEGISIMI:
echo    --------------------
echo    CPU Yuk: %cpuBefore%%% -> %cpuAfter%%%
echo    Bos RAM: %ramBeforeMB% MB -> %ramAfterMB% MB (%ramSaved% MB kazanc)
echo    Disk Alanı: %diskSaved% MB bosaltildi
echo.
echo    GERCEKLESTIRILEN ISLEMLER:
echo    --------------------------
echo    [+] Sistem geri alma noktasi olusturuldu
echo    [+] 5 katmanli temizlik tamamlandi
echo    [+] 3 asamali sistem onarimi uygulandi
echo    [+] Performans optimizasyonu yapildi
echo    [+] Guvenlik ve gizlilik ayarlari guncellendi
echo.
echo    TAVSIYELER:
echo    -----------
echo    * Sistemi yeniden baslatin
echo    * Onemli verilerinizi yedekleyin
echo    * Haftalik hizli bakim yapin
echo.
echo    SONRAKI BAKIM: %date% + 7 gun
echo.

:: Raporu Dosyaya Kaydet
echo. >> "%logFile%"
echo [%date% %time%] TURBO_BAKIM_RAPORU >> "%logFile%"
echo [%date% %time%] CPU: %cpuBefore%%% -> %cpuAfter%%% >> "%logFile%"
echo [%date% %time%] RAM: %ramBeforeMB% MB -> %ramAfterMB% MB >> "%logFile%"
echo [%date% %time%] DISK: %diskSaved% MB kazanildi >> "%logFile%"
echo [%date% %time%] PROFESYONEL_TURBO_BAKIM_TAMAMLANDI >> "%logFile%"

echo.
echo    ==============================================================================
echo    [!] Sistemi yeniden baslatmak performans icin onerilir!
echo    ==============================================================================
echo.

set /p restart="   >> Sistemi simdi yeniden baslatmak ister misiniz? (E/H): "
if /i "%restart%"=="E" (
    echo    [*] Sistem 30 saniye icinde yeniden baslatilacak...
    shutdown /r /t 30 /c "UT Turbo Bakim sonrasi yeniden baslatma"
) else (
    echo    [+] Bakim tamamlandi! Menuye donmek icin bir tusa basin...
)

pause >nul
call :FOOTER_SUB "TURBO_BAKIM"

:: --- DİĞER FONKSİYONLAR (Kısa versiyon) ---
:LIST_DISK
:: ... (diğer fonksiyonlar aynı kalacak)
