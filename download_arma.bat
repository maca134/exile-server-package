@echo off
call config.bat

%STEAM% +login %STEAMUSERNAME% %STEAMPASSWORD% +force_install_dir "%ARMA3%" +app_update 233780 validate +quit