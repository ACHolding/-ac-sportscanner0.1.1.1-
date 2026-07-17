@echo off
setlocal enabledelayedexpansion
title ACSCANNER 0.1 - CatSeek Port Scanner
color 0A
mode con cols=100 lines=40

cls
echo.
echo.   ================================================================
echo.            A C S C A N N E R   v 0 . 1
echo.                  CatSeek Edition
echo.        "Scan like a cat, strike like a tiger."
echo.   ================================================================
echo.
echo.   [1] Ping Sweep        [2] Port Scan
echo.   [3] Quick Scan        [4] Full Scan
echo.   [5] Custom Ports      [6] Help
echo.   [7] Exit
echo.
set /p "menu=Select option: "

if "%menu%"=="1" goto ping_sweep
if "%menu%"=="2" goto port_scan
if "%menu%"=="3" goto quick_scan
if "%menu%"=="4" goto full_scan
if "%menu%"=="5" goto custom_ports
if "%menu%"=="6" goto help
if "%menu%"=="7" goto exit_script
goto menu

:ping_sweep
cls
echo.
echo.   ================================================================
echo.   PING SWEEP - ACSCANNER 0.1
echo.   "Meow, are you alive?"
echo.   ================================================================
echo.
set /p "network=Enter network (e.g., 192.168.1): "
echo.
echo.   Scanning 1-254 on %network%.*
echo.
for /l %%i in (1,1,254) do (
    ping -n 1 -w 200 %network%.%%i | find "Reply" >nul 2>&1
    if !errorlevel! equ 0 (
        echo.   [FOUND] %network%.%%i is alive
    )
)
echo.
echo.   Scan complete.
pause
goto menu

:port_scan
cls
echo.
echo.   ================================================================
echo.   PORT SCAN - ACSCANNER 0.1
echo.   "Knock knock... who's there?"
echo.   ================================================================
echo.
set /p "target=Enter target IP: "
set /p "ports=Enter ports (comma-separated, e.g., 21,22,80,443): "
echo.
echo.   Scanning %target% on ports: %ports%
echo.
for %%p in (%ports%) do (
    powershell -nop -c "$t=New-Object System.Net.Sockets.TcpClient; try { $t.Connect('%target%',%%p); Write-Host '[OPEN]' %%p; $t.Close() } catch {}" 2>nul
)
echo.
echo.   Scan complete.
pause
goto menu

:quick_scan
cls
echo.
echo.   ================================================================
echo.   QUICK SCAN - ACSCANNER 0.1
echo.   "Common ports, common vibes"
echo.   ================================================================
echo.
set /p "target=Enter target IP: "
echo.
echo.   Scanning %target% for common ports...
echo.
for %%p in (21 22 23 25 53 80 110 135 139 143 443 445 993 995 1723 3306 3389 5432 5900 8080) do (
    powershell -nop -c "$t=New-Object System.Net.Sockets.TcpClient; try { $t.Connect('%target%',%%p); Write-Host '[OPEN]' %%p; $t.Close() } catch {}" 2>nul
)
echo.
echo.   Scan complete.
pause
goto menu

:full_scan
cls
echo.
echo.   ================================================================
echo.   FULL SCAN - ACSCANNER 0.1
echo.   "Every port, every vibe"
echo.   ================================================================
echo.
set /p "target=Enter target IP: "
echo.
echo.   Scanning %target% on ports 1-65535...
echo.   This will take a while. Grab Popeyes.
echo.
for /l %%p in (1,1,1024) do (
    powershell -nop -c "$t=New-Object System.Net.Sockets.TcpClient; try { $t.Connect('%target%',%%p); Write-Host '[OPEN]' %%p; $t.Close() } catch {}" 2>nul
)
echo.
echo.   Scan complete.
pause
goto menu

:custom_ports
cls
echo.
echo.   ================================================================
echo.   CUSTOM PORTS - ACSCANNER 0.1
echo.   "Your ports, your rules"
echo.   ================================================================
echo.
set /p "target=Enter target IP: "
set /p "range_start=Enter starting port: "
set /p "range_end=Enter ending port: "
echo.
echo.   Scanning %target% on ports %range_start%-%range_end%
echo.
for /l %%p in (%range_start%,1,%range_end%) do (
    powershell -nop -c "$t=New-Object System.Net.Sockets.TcpClient; try { $t.Connect('%target%',%%p); Write-Host '[OPEN]' %%p; $t.Close() } catch {}" 2>nul
)
echo.
echo.   Scan complete.
pause
goto menu

:help
cls
echo.
echo.   ================================================================
echo.   HELP - ACSCANNER 0.1
echo.   "Read me, human"
echo.   ================================================================
echo.
echo.   [1] Ping Sweep - Find live hosts on a network
echo.   [2] Port Scan - Scan specific ports on a target
echo.   [3] Quick Scan - Scan common ports (21, 22, 80, etc.)
echo.   [4] Full Scan - Scan ports 1-65535
echo.   [5] Custom Ports - Scan a range of ports
echo.   [6] Help - This screen
echo.   [7] Exit - Leave the matrix
echo.
echo.   Powered by Popeyes and CatSeek vibes.
pause
goto menu

:exit_script
cls
echo.
echo.   ================================================================
echo.   "Goodbye, human. Vibe on."
echo.   - CatSeek CEO
echo.   ================================================================
echo.
timeout /t 2 >nul
exit
