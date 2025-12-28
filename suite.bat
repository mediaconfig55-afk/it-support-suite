@echo off
:: Karakter kodlamasını UTF-8 yap (Türkçe karakter ve kutu çizimleri için)
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: ADMIN KONTROLÜ
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] LÜTFEN SAĞ TIKLAYIP YÖNETİCİ OLARAK ÇALIŞTIRIN!
    pause & exit
)

:: PENCERE BOYUTUNU ZORLA AYARLA (PowerShell ile en kesin yöntem)
powershell -command "&{$H=get-host;$W=$H.ui.rawui;$B=$W.buffersize;$B.width=100;$B.height=500;$W.buffersize=$B;$S=$W.windowsize;$S.width=100;$S.height=45;$W.windowsize=$S;}" >nul 2>&1

:: --- AYARLAR ---
SET "https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"
SET "VERSION=9.5"
title IT Support Suite v%VERSION% - Code Emre Bilgin
color 0A

:: --- GÜNCELLEME KONTROLÜ ---
echo [+] Sistem Kontrol Ediliyor... v%VERSION%
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\update.bat')" >nul 2>&1
if exist "%temp%\update.bat" (
    fc /b "%~f0" "%temp%\update.bat" >nul
    if %errorLevel% neq 0 (
        move /y "%temp%\update.bat" "%~f0" >nul
        echo [+] Görünüm ve Kodlar Güncellendi! Yeniden başlatılıyor...
        timeout /t 1 >nul
        start "" "%~f0"
        exit
    )
    del "%temp%\update.bat" >nul 2>&1
)

:MENU
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                     USB YÖNETİM VE SİSTEM BAKIM KONSOLU (V%VERSION%)                     ║
echo  ║                              ==== CODE EMRE BİLGİN ====                                  ║
echo  ╠══════════════════════════════════════════════════════════════════════════════════════════╣
echo  ║ SURUM: %VERSION%                                            DURUM: AKTİF VE GÜNCEL       ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo    [1] Mevcut Diskleri Gör           [16] Sistem Dosyalarını Onar (SFC)
echo    [2] Akıllı Format                 [17] Sabit Diski Tarama (CHKDSK)
echo    [3] Yazma Korumasını AÇ           [18] Disk Temizliği (Cleanmgr)
echo    [4] Yazma Korumasını KAPAT        [19] Grup Politikalarını Güncelle
echo    [5] Disk Detaylarını Gör          [20] Windows Güncelleme Durumu
echo.   
echo    --------------------------------------------------------------------------------------
echo.
echo    [6] Seri No, Marka ve Model       [21] Tüm Programları Güncelle (Winget)
echo    [7] IP Adresini Görüntüle         [22] Windows Store Uygulama Güncelle
echo    [8] Windows Lisans Durumu         [23] Gereksiz Dosyaları Temizle (Temp)
echo    [9] Sistem Bilgileri (Detaylı)    [24] RAM Optimizasyonu Yap
echo    [10] CPU Bilgilerini Göster       [25] Güvenlik Duvarını AÇ/KAPAT
echo.   
echo    --------------------------------------------------------------------------------------
echo.
echo    [26] DNS Önbelleğini Temizle      [36] Windows Update Servislerini SIFIRLA
echo    [34] WI-FI ŞİFRESİNİ GÖSTER       [37] Tüm Sürücüleri (Drivers) YEDEKLE
echo    [41] Explorer ve Görev Çubuğu     [38] Güç Planı: NİHAİ PERFORMANS
echo    [43] Pil Sağlık Raporu (Laptop)   [44] Windows Telemetriyi KAPAT
echo    [35] ÇIKIŞ (EXIT)                 [42] BIOS / Anakart Bilgisi
echo.
echo  ══════════════════════════════════════════════════════════════════════════════════════════
set /p choice=" >> Seçiminizi Girin: "

:: --- YÖNLENDİRMELER ---
if "%choice%"=="1" goto LIST
if "%choice%"=="7" goto IP
if "%choice%"=="24" goto OPTIMIZE_RAM
if "%choice%"=="34" goto WIFI_PASSWORD
if "%choice%"=="41" goto RESTART_EXPLORER
if "%choice%"=="35" exit
:: (Diger yönlendirmeler buraya gelecek...)

:IP
cls
echo [+] IP Adres Bilgileriniz:
ipconfig | findstr /R /C:"IPv4" /C:"IP Adresi"
pause & goto MENU

:OPTIMIZE_RAM
cls
echo [+] RAM Temizleniyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(100000000) > "%temp%\ram.vbs"
cscript //nologo "%temp%\ram.vbs" & del "%temp%\ram.vbs"
echo [OK] Bellek optimize edildi.
pause & goto MENU

:RESTART_EXPLORER
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
goto MENU

:LIST
cls
(echo list disk) > "%temp%\ds.txt"
diskpart /s "%temp%\ds.txt"
pause & goto MENU

:WIFI_PASSWORD
cls
set /p wifi="Ag Adi (SSID): "
netsh wlan show profile name="%wifi%" key=clear | findstr /i "Key Content"
pause & goto MENU
