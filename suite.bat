@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: ADMIN KONTROLU
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Lutfen Sag Tiklayip Yonetici Olarak Calistirin.
    pause & exit
)

:: GITHUB LINKINI BURAYA YAPIŞTIR
SET "RAW_LINK=BURAYA_GITHUB_RAW_LINKINI_YAPISTIR"
SET "VERSION=9.2"

title Professional IT Suite v%VERSION%
color 0A

echo [+] Sistem Guncellemeleri Kontrol Ediliyor...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%RAW_LINK%', '%temp%\update.bat')" >nul 2>&1

if exist "%temp%\update.bat" (
    move /y "%temp%\update.bat" "%~f0" >nul
    echo [+] Guncelleme Tamamlandi!
    timeout /t 1 >nul
)

:: --- ANA MENU ---
:MENU
cls
echo.
echo  ##########################################################################################################
echo  #                        USB YONETIM VE SISTEM BAKIM KONSOLU (V9.2 REMOTE)                               #
echo  #                                   SURUM: %VERSION% - DURUM: GUNCEL                                     #
echo  ##########################################################################################################
echo.
echo  [1] Diskleri Listele          [7] IP Adresini Gor          [16] Sistem Onar (SFC)
echo  [2] Akilli Format             [24] RAM Optimizasyonu       [41] Explorer Onar
echo  [34] WiFi Sifrelerini Gor     [37] Suruculeri Yedekle      [35] CIKIS
echo.
echo  ##########################################################################################################
set /p choice="Secim: "

if "%choice%"=="1" goto LIST
if "%choice%"=="7" goto IP
if "%choice%"=="24" goto RAM
if "%choice%"=="34" goto WIFI
if "%choice%"=="41" goto EXPLORER
if "%choice%"=="35" exit
goto MENU

:LIST
cls
echo list disk > ds.txt & diskpart /s ds.txt & del ds.txt
pause & goto MENU

:IP
cls
ipconfig | findstr /R /C:"IPv4" /C:"IP Adresi"
pause & goto MENU

:RAM
cls
echo RAM Temizleniyor...
start /wait rundll32.exe advapi32.dll,ProcessIdleTasks
echo FreeMem = Space(100000000) > "%temp%\r.vbs" & cscript //nologo "%temp%\r.vbs" & del "%temp%\r.vbs"
echo [OK] Bitti.
pause & goto MENU

:WIFI
cls
set /p w="Ag Adi: "
netsh wlan show profile name="%w%" key=clear | findstr /i "Key Content"
pause & goto MENU

:EXPLORER
taskkill /f /im explorer.exe & start explorer.exe & goto MENU
