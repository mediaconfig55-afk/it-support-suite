@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
cd /d "%~dp0"

:: --- YÖNETİCİ KONTROLÜ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] LUTFEN SAG TIKLAYIP YONETICI OLARAK CALISTIRIN.
    pause & exit
)

:: --- PENCERE AYARI ---
mode con: cols=100 lines=45
title Professional IT Suite v9.7 - Final Visual

:: --- AYARLAR ---
SET "https://raw.githubusercontent.com/mediaconfig55-afk/it-support-suite/refs/heads/main/suite.bat"
SET "VERSION=9.7"

:: --- OTOMATİK GÜNCELLEME ---
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\up.bat')" >nul 2>&1
if exist "%temp%\up.bat" (
    fc /b "%~f0" "%temp%\up.bat" >nul
    if %errorLevel% neq 0 (
        move /y "%temp%\up.bat" "%~f0" >nul
        start "" "%~f0"
        exit
    )
)

:MENU
cls
echo.
echo  ##############################################################################################
echo  #                       USB YONETIM VE SISTEM BAKIM KONSOLU (v%VERSION%)                      #
echo  #                                 ==== EMRE BILGIN ====                                      #
echo  ##############################################################################################
echo.
echo    [1]  Diskleri Listele             [16] Sistem Onar (SFC)        [37] Surucu Yedekle
echo    [2]  Akilli Format                [17] Disk Tara (CHKDSK)       [38] Nihai Performans
echo    [7]  IP Adresini Gor              [24] RAM Optimizasyonu        [41] Explorer Onar
echo    [34] WiFi Sifrelerini Gor         [23] Temp Temizle             [35] CIKIS (EXIT)
echo.
echo  ##############################################################################################
echo.
set /p choice=" >> Seciminizi yapip Enter'a basin: "

if "%choice%"=="1" goto LIST
if "%choice%"=="2" goto FORMAT
if "%choice%"=="7" goto IP
if "%choice%"=="24" goto RAM
if "%choice%"=="34" goto WIFI
if "%choice%"=="41" goto EXPLORER
if "%choice%"=="35" exit
goto MENU

:IP
cls
echo [+] Yerel IP Bilgileri:
ipconfig | findstr /i "IPv4 IP"
pause & goto MENU

:RAM
cls
echo [+] RAM Temizleniyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(100000000) > "%temp%\r.vbs"
cscript //nologo "%temp%\r.vbs" & del "%temp%\r.vbs"
echo [OK] Bellek rahatlatildi.
pause & goto MENU

:WIFI
cls
set /p w="Ag Adi (SSID): "
netsh wlan show profile name="%w%" key=clear | findstr /i "Key Content"
pause & goto MENU

:LIST
cls
echo list disk > ds.txt & diskpart /s ds.txt & del ds.txt
pause & goto MENU

:EXPLORER
taskkill /f /im explorer.exe & start explorer.exe
goto MENU

:FORMAT
cls
echo list disk > ds.txt & diskpart /s ds.txt & del ds.txt
set /p d="Disk No: "
echo [!] DIKKAT: Veriler silinecek.
set /p c="Onayliyor musunuz? (E/H): "
if /i "%c%"=="E" (
    (echo select disk %d% & echo clean & echo create partition primary & echo format fs=ntfs quick & echo assign) > ds.txt
    diskpart /s ds.txt & del ds.txt
)
pause & goto MENU
