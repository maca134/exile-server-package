# Exile Server Package - [Download](https://github.com/maca134/exile-server-package/releases)
A collection of batch file to make deploying an Exile server.

You need SteamCMD, you can get it from here: [Download](https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip) [Info](https://developer.valvesoftware.com/wiki/SteamCMD)

## Install
1. Download the files & Exile client mod
2. Create a database and execute the sql
3. TURN OF SQL STRICT MODE
4. Edit config.bat to your needs
5. Run download_arma.bat to download ARMA 3 from Steam
6. Run start.bat and your server should run

## Folders
- config: This contains all the various config files needed. Battleye filters live in here.
- dump: Used to copy src files and run find/replace
- run: This is were all the live files get compiled to. Editing stuff in here is pointless. You may need to view RPT/Be logs in here while the server is running.
- source: This is were all the exile files are stored.

## Credits
- [Exile Mod](http://exilemod.com/)
- [Mikero Tools](https://forums.bistudio.com/topic/113852-mikeros-dos-tools/)
