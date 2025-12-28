@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
cd /d "%~dp0"

:: --- YÖNETİCİ KONTROLÜ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] LUTFEN YONETICI OLARAK CALISTIRIN.
    pause & exit
)

:: --- AYARLAR ---
SET "VERSION=16.0"
:: ÖNEMLİ: Linkin sonuna eklenen %RANDOM% önbelleği (cache) her seferinde kırar!
SET "RAW_LINK=https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"

:: --- PROFESYONEL GÜNCELLEME SİSTEMİ ---
echo [+] Guncellemeler kontrol ediliyor... (v%VERSION%)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\up.bat')" >nul 2>&1

if exist "%temp%\up.bat" (
    :: Mevcut dosya ile inen dosyayı karşılaştır (FC = File Compare)
    fc /b "%~f0" "%temp%\up.bat" >nul
    if %errorLevel% neq 0 (
        echo.
        echo  [+] YENI SURUM VEYA DEGISIKLIK BULUNDU!
        echo  [+] Sistem guncelleniyor...
        move /y "%temp%\up.bat" "%~f0" >nul
        timeout /t 2 >nul
        start "" "%~f0"
        exit
    )
    del "%temp%\up.bat" >nul 2>&1
)

:: --- PENCERE AYARLARI ---
mode con: cols=115 lines=48
title IT Support Suite v%VERSION% - Code Emre Bilgin
color 0B

:MENU
cls
echo.
echo  ==========================================================================================================
echo     USB YÖNETİM VE SİSTEM BAKIM KONSOLU (v%VERSION%) - CODE EMRE BİLGİN
echo  ==========================================================================================================
echo.
echo    --- USB VE DISK ISLEMLERI ---                --- SISTEM BAKIM VE ONARIM ---
echo    [1] Mevcut Diskleri Goruntule                [16] Sistem Dosyalarini Onar (SFC)
echo    [2] Akilli Format (NTFS/FAT32/exFAT)         [17] Sabit Diski Tarama (CHKDSK)
echo    [3] Yazma Korumasini ETKINLESTIR             [18] Disk Temizligi (Cleanmgr)
echo    [4] Yazma Korumasini KALDIR                  [19] Grup Politikalarini Guncelle
echo    [5] Disk ve Bolum Detaylarini Gor            [20] Windows Guncelleme Durumu
echo.
echo    --- SISTEM BILGILERI ---                     [21] Tum Programlari Guncelle (Winget)
echo    [6] Seri No, Marka ve Model                  [22] Store Uygulamalarini Onar
echo    [7] IP Adresini Goruntule                    [23] Gereksiz Dosyalari Temizle (Temp)
echo    [8] Windows Lisans Durumu                    [24] RAM Optimizasyonu Yap
echo    [9] Sistem Bilgileri (Detayli)               [25] Guvenlik Duvarini AC/KAPAT
echo.
echo    --- PRO TEKNISYEN ARACLARI ---               --- AG VE NETWORK ---
echo    [36] Windows Update Servislerini SIFIRLA     [26] DNS Onbellegini Temizle
echo    [37] Tum Suruculeri (Drivers) YEDEKLE        [34] WI-FI SIFRESINI GOSTER
echo    [38] Guc Plani: NIHAI PERFORMANS             [41] Explorer/Gorev Cubugu ONAR
echo    [40] Yazici Kuyrugunu TEMIZLE                [43] Pil Saglik Raporu (Laptop)
echo  ==========================================================================================================
echo    [35] CIKIS (EXIT)
echo  ==========================================================================================================
echo.
set /p choice=" >> Seciminiz: "

:: (Buradan aşağısı v14 ile aynı, yönlendirmeler ve fonksiyonlar gelecek...)
:: NOT: Kodu çok uzatmamak için yönlendirmeleri kopyalamadım, v14'tekileri buraya ekle.

:: --- YÖNLENDİRMELER (EKSİKSİZ LİSTE) ---
if "%choice%"=="1" goto LIST
if "%choice%"=="2" goto FORMAT
if "%choice%"=="3" goto PROTECT
if "%choice%"=="4" goto UNPROTECT
if "%choice%"=="5" goto DETAIL
if "%choice%"=="6" goto COMP_INFO
if "%choice%"=="7" goto IP
if "%choice%"=="8" goto LICENSE
if "%choice%"=="9" goto SYSINFO
if "%choice%"=="16" goto SFC
if "%choice%"=="17" goto CHKDSK
if "%choice%"=="18" goto CLEANMGR
if "%choice%"=="19" goto GPUPDATE
if "%choice%"=="20" goto WU_STATUS
if "%choice%"=="21" goto WINGET_UP
if "%choice%"=="22" goto STORE_FIX
if "%choice%"=="23" goto TEMP
if "%choice%"=="24" goto RAM
if "%choice%"=="25" goto FIREWALL
if "%choice%"=="26" goto DNS
if "%choice%"=="34" goto WIFI
if "%choice%"=="36" goto WU_RESET
if "%choice%"=="37" goto DRIVER
if "%choice%"=="38" goto POWER
if "%choice%"=="40" goto SPOOLER
if "%choice%"=="41" goto EXPLORER
if "%choice%"=="43" goto BATTERY
if "%choice%"=="35" exit
goto MENU

:: --- FONKSİYONLAR ---

:LIST
cls & (echo list disk) > ds.txt & diskpart /s ds.txt & del ds.txt & pause & goto MENU

:FORMAT
cls & (echo list disk) > ds.txt & diskpart /s ds.txt & del ds.txt
set /p d="Disk No: "
set /p f="Format (ntfs/fat32/exfat): "
(echo select disk %d% & echo clean & echo create partition primary & echo format fs=%f% quick & echo assign) > ds.txt
diskpart /s ds.txt & del ds.txt & pause & goto MENU

:PROTECT
cls & (echo select disk 0 & echo attributes disk set readonly) > ds.txt
diskpart /s ds.txt & del ds.txt & echo [OK] Yazma Korumasi Acildi. & pause & goto MENU

:UNPROTECT
cls & (echo select disk 0 & echo attributes disk clear readonly) > ds.txt
diskpart /s ds.txt & del ds.txt & echo [OK] Yazma Korumasi Kaldirildi. & pause & goto MENU

:DETAIL
cls & set /p dID="Disk No: " & (echo select disk %dID% & echo detail disk) > ds.txt
diskpart /s ds.txt & del ds.txt & pause & goto MENU

:COMP_INFO
cls & wmic bios get serialnumber & wmic computersystem get manufacturer, model & pause & goto MENU

:IP
cls & ipconfig | findstr /i "IPv4" & pause & goto MENU

:LICENSE
cls & slmgr /xpr & pause & goto MENU

:SYSINFO
cls & systeminfo & pause & goto MENU

:SFC
cls & sfc /scannow & pause & goto MENU

:CHKDSK
cls & set /p drv="Harf: " & chkdsk %drv%: /f /r & pause & goto MENU

:CLEANMGR
cls & cleanmgr /sagerun:1 & pause & goto MENU

:GPUPDATE
cls & gpupdate /force & pause & goto MENU

:WU_STATUS
cls & wmic qfe list brief /format:table & pause & goto MENU

:WINGET_UP
cls & winget upgrade --all & pause & goto MENU

:STORE_FIX
cls & powershell -Command "Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" & pause & goto MENU

:TEMP
cls & del /s /f /q %temp%\* & del /s /f /q C:\Windows\temp\* & pause & goto MENU

:RAM
cls & start /wait rundll32.exe advapi32.dll,ProcessIdleTasks & echo FreeMem = Space(128000000) > "%temp%\r.vbs" & cscript //nologo "%temp%\r.vbs" & del "%temp%\r.vbs" & pause & goto MENU

:FIREWALL
cls & echo [1] AC [2] KAPAT
set /p fw="Secim: "
if "%fw%"=="1" netsh advfirewall set allprofiles state on
if "%fw%"=="2" netsh advfirewall set allprofiles state off
pause & goto MENU

:DNS
cls & ipconfig /flushdns & pause & goto MENU

:WIFI
cls & set /p w="WiFi SSID: " & netsh wlan show profile name="%w%" key=clear | findstr /i "Key Content" & pause & goto MENU

:WU_RESET
cls & net stop wuauserv & net stop bits & ren C:\Windows\SoftwareDistribution SoftwareDistribution.old & net start wuauserv & net start bits & pause & goto MENU

:DRIVER
cls & mkdir "%USERPROFILE%\Desktop\Driver_Yedek" & dism /online /export-driver /destination:"%USERPROFILE%\Desktop\Driver_Yedek" & pause & goto MENU

:POWER
cls & powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 & pause & goto MENU

:SPOOLER
cls & net stop spooler & del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*" & net start spooler & pause & goto MENU

:EXPLORER
taskkill /f /im explorer.exe & start explorer.exe & goto MENU

:BATTERY
cls & powercfg /batteryreport /output "%USERPROFILE%\Desktop\pil_raporu.html" & echo [OK] Masaustune bakin. & pause & goto MENU
