# Exile Server Package - [Download](https://github.com/maca134/exile-server-package/releases)
A collection of batch file to make deploying an Exile server.

You need SteamCMD, you can get it from here: 
[Download](https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip)
[Info](https://developer.valvesoftware.com/wiki/SteamCMD)

## Install
1. Download the latest release of this repo [here](https://github.com/maca134/exile-server-package/releases) & Exile client mod [here](http://www.exilemod.com/)
2. Extract the folder to the location were you want the server.
3. Create a database and execute the sql
4. TURN OF SQL STRICT MODE [Info](https://dev.mysql.com/doc/refman/5.1/en/sql-mode.html#sql-mode-strict)
5. Edit config.bat to your needs
6. Run download_arma.bat to download ARMA 3 from Steam
7. Run start.bat and your server should run

## Batch Files
- config.bat - Contains the servers settings
- download_arma.bat - Download ARMA 3 via SteamCMD
- prestart.bat - Sets up the servers configs etc (use this in firedeamon)
- start.bat - Runs the prestart.bat and starts the server exe

## Folders
- config: This contains all the various config files needed. Battleye filters live in here.
- dump: Used to copy src files and run find/replace
- run: This is were all the live files get compiled to. Editing stuff in here is pointless. You may need to view RPT/Be logs in here while the server is running.
- source: This is were all the exile servers (mission, exile_server, exile_server_config) files are stored.

## Credits
- [Exile Mod](http://exilemod.com/)
- [Mikero Tools](https://forums.bistudio.com/topic/113852-mikeros-dos-tools/)
