set DIR=%CD%
set ARMA3=%DIR%\arma3

set STEAM="c:\path\to\steamcmd.exe"
set STEAMUSERNAME=user
set STEAMPASSWORD=password

set MAP=Altis
set INSTANCEID=A3ExileTest
set SERVERNAME=A3ExileTest
set IP=127.0.0.1
set PORT=2302
set MAXPLAYERS=50
set SERVERPASSWORD=
set MAXPING=200
set RCONPASSWORD=changeme
set ADMINPASSWORD=changeme

set MOD=U:\mods\@Exile
set SERVERMOD=%DIR%\run\@exile_server

set MYSQLHOST=localhost
set MYSQLUSER=root
set MYSQLPASS=changeme
set MYSQLDB=exile

set PARAMS=-noSound -autoinit -ip=%IP% -port=%PORT% "-config=%DIR%\run\instance\config.cfg" "-cfg=%DIR%\run\instance\basic.cfg" "-profiles=%DIR%\run\instance" -name=instance "-mod=%MOD%" "-serverMod=%SERVERMOD%"

rem YOU DO NOT NEED TO EDIT BELOW HERE!

set ARMASERVEREXE=arma3server%INSTANCEID%
set ARMASERVERORIGEXE=arma3server.exe
set MISSIONNAME=mission.%MAP%
set MPMISSION=%ARMA3%\mpmissions
set SAR="%DIR%\bin\fnr.exe"
set ZIP="%DIR%\bin\7z.exe"
set PBO="%DIR%\bin\MakePbo.exe"
set BACKUPTIME=%DATE:/=-%@%TIME::=-%
set WGET="%DIR%\bin\wget.exe"
