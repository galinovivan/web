@echo off

set rdir=n
if exist "%windir%\System32\rserver30\rserver3.exe" set rdir=%windir%\System32\rserver30
if exist "%windir%\SysWOW64\rserver30\rserver3.exe" set rdir=%windir%\SysWOW64\rserver30
if %rdir%==n goto rerror:

echo>"%rdir%\ntstest"
if not exist "%rdir%\ntstest" goto rights:
del /f /q "%rdir%\ntstest"

cls
echo.
echo ===================================================
echo.
echo  NewTrialStop v2.3 for Famatech Radmin Server v3.4
echo.
echo ==================== UNINSTALL ====================
echo.
pause
echo.
net stop rserver3
if exist "%rdir%\newtstop.dll" goto old:
:uninstall
if exist "%rdir%\wsock32.dll" rundll32 "%rdir%\wsock32.dll",ntsclean
if exist "%rdir%\wsock32.dll" del /f "%rdir%\wsock32.dll"
if exist "%rdir%\nts64helper.dll" del /f "%rdir%\nts64helper.dll"
net start rserver3
goto end:

:rerror
echo Cannot find Radmin Server.
goto end:

:old
regsvr32 /s /u "%rdir%\newtstop.dll"
del /f "%rdir%\newtstop.dll"
del /f "%rdir%\newtstop.ini"
goto uninstall:

:rights
cls
echo Administrator rights are required.
goto end:

:end
pause