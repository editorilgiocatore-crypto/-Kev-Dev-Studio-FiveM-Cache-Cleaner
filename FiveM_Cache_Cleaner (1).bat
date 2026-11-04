@echo off
title Kev Dev Studio - Pulizia cache FiveM
mode con cols=64 lines=26

:: codici colore (funzionano su Windows 10 e 11)
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C=%ESC%[96m"
set "M=%ESC%[95m"
set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "R=%ESC%[91m"
set "D=%ESC%[90m"
set "W=%ESC%[0m"

set "FIVEM=%LOCALAPPDATA%\FiveM\FiveM.app"

if not exist "%FIVEM%" (
    echo %R%Cartella di FiveM non trovata.%W%
    pause
    exit /b
)

:menu
cls
echo.
echo %C%    #  #   ####   #   #%W%
echo %C%    # #    #      #   #%W%
echo %C%    ##     ###    #   #%W%
echo %C%    # #    #       # #%W%
echo %C%    #  #   ####     #%W%
echo.
echo %M%    D E V   S T U D I O%W%
echo %D%    ------------------------------------------%W%
echo.
echo       %Y%[1]%W%  Pulizia normale
echo       %Y%[2]%W%  Pulizia normale + crash
echo       %Y%[3]%W%  Pulizia totale
echo       %Y%[0]%W%  Esci
echo.
echo %D%    ------------------------------------------%W%
echo %D%    cache FiveM - tool gratuito%W%
echo.
set /p "scelta=    > "

if "%scelta%"=="0" exit /b
if "%scelta%"=="1" goto check
if "%scelta%"=="2" goto check
if "%scelta%"=="3" goto check
goto menu

:check
tasklist /FI "IMAGENAME eq FiveM.exe" 2>nul | find /I "FiveM.exe" >nul
if %errorlevel%==0 (
    echo.
    echo %R%    Chiudi FiveM prima di continuare.%W%
    pause >nul
    goto menu
)

echo.
call :del "data\cache"
call :del "data\server-cache"
call :del "data\server-cache-priv"
call :del "data\nui-storage"
call :del "logs"

if "%scelta%"=="1" goto fine
call :del "crashes"

if "%scelta%"=="2" goto fine
call :del "data\game-storage"

:fine
echo.
echo %G%    Finito.%W%
echo.
pause
exit /b

:del
if exist "%FIVEM%\%~1" (
    rd /s /q "%FIVEM%\%~1"
    echo %G%    [ok]%W% %~1
) else (
    echo %D%    [--] %~1%W%
)
goto :eof
