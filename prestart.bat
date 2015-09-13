@echo off
call config.bat

%ZIP% a -tzip "%DIR%\logs\log%BACKUPTIME%.zip" "%DIR%\run\instance\*.log" "%DIR%\run\instance\*.RPT" "%DIR%\run\instance\server_console.log" "%DIR%\run\instance\BattlEye\*.log"
del "%DIR%\run\instance\*.RPT"
del "%DIR%\run\instance\*.BIDMP"
del "%DIR%\run\instance\*.mdmp"
del "%DIR%\run\instance\*.log"
del "%DIR%\run\instance\server_console.log"
del "%DIR%\run\instance\BattlEye\*.log"

timeout 5
taskkill /f /im %ARMASERVEREXE%.exe
del %ARMA3%\%ARMASERVEREXE%.exe
copy %ARMA3%\%ARMASERVERORIGEXE% %ARMA3%\%ARMASERVEREXE%.exe

rd /S /Q "%DIR%\run\@exile_server"
mkdir "%DIR%\run\@exile_server"
xcopy %DIR%\config\@exile_server\* %DIR%\run\@exile_server\ /E /Y /EXCLUDE:%DIR%\bin\exclude.txt

rd /S /Q "%DIR%\dump\mission"
mkdir "%DIR%\dump\mission"
xcopy "%DIR%\source\mission\*"  "%DIR%\dump\mission\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
%PBO% -p -$ -N "%DIR%\dump\mission" "%MPMISSION%\%MISSIONNAME%.pbo"

rd /S /Q "%DIR%\dump\server"
mkdir "%DIR%\dump\server"
xcopy "%DIR%\source\server\*"  "%DIR%\dump\server\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
%PBO% -p -@=exile_server "%DIR%\dump\server" "%DIR%\run\@exile_server\addons\a3_exile_server.pbo"

rd /S /Q "%DIR%\dump\server_config"
mkdir "%DIR%\dump\server_config"
xcopy "%DIR%\source\server_config\*"  "%DIR%\dump\server_config\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
%SAR% --cl --dir "%DIR%\dump\server_config" --fileMask "config.cpp" --find "!ADMINPASSWORD" --replace "%ADMINPASSWORD%"
%PBO% -p -@=exile_server_config "%DIR%\dump\server_config" "%DIR%\run\@exile_server\addons\a3_exile_server_config.pbo"

del "%DIR%\run\instance\BattlEye\BEServer_active_*.cfg"
xcopy "%DIR%\config\BattlEye\*" "%DIR%\run\instance\BattlEye\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
xcopy "%DIR%\config\Server\*" "%DIR%\run\instance\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt

%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!SERVERNAME" --replace "%SERVERNAME%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!SERVERPASSWORD" --replace "%SERVERPASSWORD%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!ADMINPASSWORD" --replace "%ADMINPASSWORD%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!INSTANCEID" --replace "%INSTANCEID%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!MAXPLAYERS" --replace "%MAXPLAYERS%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!MISSIONNAME" --replace "%MISSIONNAME%"

%SAR% --cl --dir "%DIR%\run\@exile_server" --fileMask "extdb-conf.ini" --find "!MYSQLDB" --replace "%MYSQLDB%"
%SAR% --cl --dir "%DIR%\run\@exile_server" --fileMask "extdb-conf.ini" --find "!MYSQLUSER" --replace "%MYSQLUSER%"
%SAR% --cl --dir "%DIR%\run\@exile_server" --fileMask "extdb-conf.ini" --find "!MYSQLPASS" --replace "%MYSQLPASS%"
%SAR% --cl --dir "%DIR%\run\@exile_server" --fileMask "extdb-conf.ini" --find "!MYSQLHOST" --replace "%MYSQLHOST%"

%SAR% --cl --dir "%DIR%\run\instance\BattlEye" --fileMask "BEServer.cfg" --find "!RCONPASSWORD" --replace "%RCONPASSWORD%"
%SAR% --cl --dir "%DIR%\run\instance\BattlEye" --fileMask "BEServer.cfg" --find "!MAXPING" --replace "%MAXPING%"

echo =============================================
echo Exe: %ARMA3%\%ARMASERVEREXE%.exe
echo ---------------------------------------------
echo Params: %PARAMS%
echo =============================================