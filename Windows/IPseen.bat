@echo off
setlocal enabledelayedexpansion
REM IPseen v0.1.0

REM Get current WiFi's name
for /f "tokens=2 delims=: " %%i in ('netsh WLAN show interfaces ^| findstr /r /c:"^    SSID"') do (
    set "networkName=%%i"
    goto :doneNetworkName
)
:doneNetworkName

REM Get the Public IP
for /f "delims=" %%i in ('curl -s https://ifconfig.me') do set "publicIP=%%i"

REM Check command line argument
if "%1"=="--mac" (
    echo Mac Address:
    for /f "tokens=1 delims=," %%a in ('getmac /fo csv /nh ^| findstr /r /c:"[0-9A-Fa-f]"') do (
        set "mac=%%~a"
        goto :doneMac
    )
    :doneMac
    echo    !mac!
    goto :eof
) else if "%1"=="--private" (
    echo Private IP Address:
    ipconfig | findstr IPv4
    goto :eof
) else if "%1"=="--public" (
    echo Public IP Address:
    REM Get the Public IPv4
    for /f %%A in ('curl -s https://ipinfo.io/ip') do set "public_ipv4=%%A"
    REM Get the Public IPv6
    for /f %%A in ('curl -s https://ifconfig.co/ip') do set "public_ipv6=%%A"
    echo    Public IPv4 Address: !public_ipv4!
    echo    Public IPv6 Address: !public_ipv6!
    goto :eof
) else if "%1"=="--help" (
    echo IPseen        Show Private, Public and MAC Addresses
    echo IPseen --help    Show this help command
    echo IPseen --version    Show the current IPseen version
    echo IPseen --public    Show your Public IP Address
    echo IPseen --private    Show your Private IP Address
    echo IPseen --mac        Show your MAC Address
    goto :eof
) else if "%1"=="--version" (
    echo IPseen v0.1.0
    goto :eof
) else (
    echo Private IP Address:
    ipconfig | findstr IPv4
    echo.
    echo Public IP Address:
    REM Get the Public IPv4
    for /f %%A in ('curl -s https://ipinfo.io/ip') do set "public_ipv4=%%A"
    REM Get the Public IPv6
    for /f %%A in ('curl -s https://ifconfig.co/ip') do set "public_ipv6=%%A"
    echo    Public IPv4 Address: !public_ipv4!
    echo    Public IPv6 Address: !public_ipv6!
    echo.
    echo Mac Address:
    for /f "tokens=1 delims=," %%a in ('getmac /fo csv /nh ^| findstr /r /c:"[0-9A-Fa-f]"') do (
        set "mac=%%~a"
        goto :doneMac2
    )
    :doneMac2
    echo    !mac!
    goto :eof
)
