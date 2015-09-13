@echo off
call prestart.bat
start "%INSTANCEID%" /D "%ARMA3%" /realtime /wait "%ARMASERVEREXE%.exe" %PARAMS%