@echo off
:: Karakter seti ayarı (Türkçe karakterler için en güvenlisi)
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: 1. ADIM: YÖNETİCİ KONTROLÜ
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] LÜTFEN SAĞ TIKLAYIP YÖNETİCİ OLARAK ÇALIŞTIRIN!
    pause & exit
)

:: 2. ADIM: PENCERE BOYUTUNU ZORLA SABİTLE (Kaymaları önlemek için daraltıldı)
mode con: cols=90 lines=45

:: --- AYARLAR ---
SET "https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"
SET "VERSION=9.6"
title IT Support Suite v%VERSION% - Code Emre Bilgin
color 0A

:: --- GÜNCELLEME KONTROLÜ ---
echo [+] Sistem Kontrol Ediliyor... v%VERSION%
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\update.bat')" >nul 2>&1
if exist "%temp%\update.bat" (
    fc /b "%~f0" "%temp%\update.bat" >nul
    if %errorLevel% neq 0 (
        move /y "%temp%\update.bat" "%~f0" >nul
        echo [+] Yeni Versiyon Yuklendi!
        start "" "%~f0"
        exit
    )
)

:MENU
cls
echo  --------------------------------------------------------------------------
echo    USB YONETIM VE SISTEM BAKIM KONSOLU - v%VERSION%
echo    Gelistirici: Emre Bilgin ^| Durum: Guncel
echo  --------------------------------------------------------------------------
echo.
echo    [ DISK ISLEMLERI ]                  [ SISTEM ONARIM ]
echo    1. Diskleri Listele                 16. Sistem Dosyasi Onar (SFC)
echo    2. Akilli Format                    17. Disk Hata Tarama (CHKDSK)
echo    3. Yazma Korumasi AC                18. Disk Temizligi (Cleanmgr)
echo    4. Yazma Korumasi KAPAT             19. Grup Politikasi Guncelle
echo    5. Disk Detaylarini Gor             24. RAM Optimizasyonu
echo.
echo    [ SISTEM BILGILERI ]                [ AG VE INTERNET ]
echo    6. Seri No / Marka / Model          7.  IP Adresini Gor
echo    8. Windows Lisans Durumu            26. DNS Onbellegini Sil
echo    9. Detayli Sistem Ozeti             34. WI-FI SIFRELERINI GOSTER
echo    10. İşlemci (CPU) Bilgisi           27. IP Yenile (Renew)
echo.
echo    [ EKSTRA ARACLAR ]                  [ SISTEM KONTROL ]
echo    36. Update Servis Sifirla           41. Explorer / Gorev Cubugu Onar
echo    37. Surucu (Driver) Yedekle         43. Laptop Pil Saglik Raporu
echo    38. Nihai Performans Modu           44. Telemetriyi Kapat
echo    40. Yazici Kuyrugu Temizle          35. CIKIS (EXIT)
echo.
echo  --------------------------------------------------------------------------
set /p choice=" >> Secim Yapin ve Enter'a Basin: "

:: --- YÖNLENDİRMELER ---
if "%choice%"=="1" goto LIST
if "%choice%"=="2" goto FORMAT_SELECTION
if "%choice%"=="7" goto IP
if "%choice%"=="24" goto RAM
if "%choice%"=="34" goto WIFI
if "%choice%"=="41" goto EXPLORER
if "%choice%"=="35" exit

:: --- FONKSIYONLAR ---
:IP
cls
echo [+] IP Adresleriniz:
ipconfig | findstr /i "IPv4"
if %errorlevel% neq 0 ipconfig | findstr /i "IP Address"
pause & goto MENU

:RAM
cls
echo [+] RAM Temizleniyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(128000000) > "%temp%\r.vbs"
cscript //nologo "%temp%\r.vbs" & del "%temp%\r.vbs"
echo [OK] Islem tamam.
pause & goto MENU

:WIFI
cls
set /p w="Ag Adi (SSID): "
netsh wlan show profile name="%w%" key=clear | findstr /i "Key Content"
if %errorlevel% neq 0 echo [!] Sifre bulunamadi.
pause & goto MENU

:EXPLORER
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
goto MENU

:LIST
cls
echo list disk > ds.txt & diskpart /s ds.txt & del ds.txt
pause & goto MENU

:FORMAT_SELECTION
cls
echo list disk > ds.txt & diskpart /s ds.txt & del ds.txt
set /p d="Disk No: "
set /p c="Emin misiniz? (E/H): "
if /i "%c%"=="E" (
    (echo select disk %d% & echo clean & echo create partition primary & echo format fs=ntfs quick & echo assign) > ds.txt
    diskpart /s ds.txt & del ds.txt
)
pause & goto MENU
