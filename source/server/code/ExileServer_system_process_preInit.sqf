/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_i","_MySql"];
if((getNumber(configFile >> "CfgSettings" >> "IReadAndModifiedThisByMyWishes")) isEqualTo 0)exitWith
{
	for "_i" from 0 to 99 do 
	{
		"MODIFY THE SERVER CONFIG LOCATED IN 'exile_server_config.pbo >> confing.bin' OR SERVER WONT START" call ExileServer_util_log;
	};
	"extDB2" callExtension "9:SHUTDOWN";
};
"Server is loading..." call ExileServer_util_log;
call ExileServer_system_rcon_initialize;
finishMissionInit;
ExileSessions = []; 
ExileGraveyardGroup = createGroup independent;
Independent setFriend [sideEnemy, 1];
_MySql_connection = [] call ExileServer_system_database_connect;
if!(_MySql_connection)exitWith
{
	false
};
addMissionEventHandler ["HandleDisconnect", { _this call ExileServer_system_network_event_onHandleDisconnect; }];
onPlayerConnected {[_uid, _name] call ExileServer_system_network_event_onPlayerConnected};
onPlayerDisconnected {[_uid, _name] call ExileServer_system_network_event_onPlayerDisconnected};
"PublicMessage" addPublicVariableEventHandler compileFinal " (_this select 1) call ExileServer_system_network_dispatchIncomingMessage; ";
PublicServerFPS = 0;
PublicHiveIsLoaded = false; 
PublicHiveVersion = getText(configFile >> "CfgMods" >> "Exile" >> "version");
publicVariable "PublicHiveVersion";