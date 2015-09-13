/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_MySql"];
"Server is loading..." call ExileServer_util_log;
call ExileServer_system_rcon_initialize;
finishMissionInit;
ExileSessions = []; 
ExileGraveyardGroup = createGroup independent;
Independent setFriend [sideEnemy, 1];
_MySql_connection = [] call ExileServer_system_database_connect;
if !(_MySql_connection) exitWith
{
	"extDB2" callExtension "9:SHUTDOWN";
	false
};
addMissionEventHandler ["HandleDisconnect", { _this call ExileServer_system_network_event_onHandleDisconnect; }];
onPlayerConnected {[_uid, _name] call ExileServer_system_network_event_onPlayerConnected};
onPlayerDisconnected {[_uid, _name] call ExileServer_system_network_event_onPlayerDisconnected};
PublicServerFPS = 0;
PublicHiveIsLoaded = false; 
PublicHiveVersion = getText(configFile >> "CfgMods" >> "Exile" >> "version");
publicVariable "PublicHiveVersion";