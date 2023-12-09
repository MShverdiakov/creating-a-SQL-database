
cls

Del *.exe
Del *.config

@If "%ProgramW6432%" NEQ "" goto 64-bit

@Echo "32-bit"
@SET VBC="C:\Windows\Microsoft.NET\Framework\v4.0.30319\vbc.exe" 
goto compile

:64-bit
@Echo "64-bit"
@SET VBC="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe"

:compile

%VBC% /t:exe /out:SHVERDIAKOV.exe .\VB\SHVERDIAKOV.vb /r:.\DLL\shverdiakov\Interop.ADODB.dll

@copy .\VB\SHVERDIAKOV.config SHVERDIAKOV.exe.config



@pause>nul
