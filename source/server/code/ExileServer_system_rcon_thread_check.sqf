/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_restartTime","_restartMessages","_useAutoKick","_kickTime","_lockTime","_uptime","_timeTilRestart","_time","_i"];
_restartTime = _this select 0;
_restartMessages = _this select 1;
_useAutoKick = _this select 2;
_kickTime = _this select 3;
_lockTime = _this select 4;
_uptime = call ExileServer_util_time_uptime;
_timeTilRestart = _restartTime - _uptime;
if (typeName _restartMessages isEqualTo "ARRAY") then
{
	if !(_restartMessages isEqualTo []) then
	{
		{
			_time = _x;
			if (_timeTilRestart < _time) then
			{
				if !(ExileSessions isEqualTo []) then
				{
					["notificationRequest",["RestartWarning",[format["Server restart in %1 min!",_time]]]] call ExileServer_system_network_send_broadcast;
				};
				ExileServerRestartMessages deleteAt _forEachIndex;
				format ["Restart Warrnings for %1min sent",_time] call ExileServer_util_log;
			};
		} 
		forEach _restartMessages;
	};
};
if (_timeTilRestart < _lockTime) then
{
	if !(ExileServerIsLocked) then
	{
		"#lock" call ExileServer_system_rcon_event_sendCommand;
		"Server locked for restart" call ExileServer_util_log;
		["notificationRequest",["LockKickWarning",["You will be kicked from the server due to restart."]]] call ExileServer_system_network_send_broadcast;
		ExileServerIsLocked = true;
	};
	if (_timeTilRestart < _kickTime) then
	{
		if !(ExileServerRestartMode) then
		{
			call ExileServer_system_rcon_event_kickAllrestart;
			"Evryone kicked for restart" call ExileServer_util_log;
			call ExileServer_system_rcon_event_clearBuffers;
			"Buffers cleared!" call ExileServer_util_log;
			for "_i" from 0 to 9 do
			{
				"SERVER READY FOR RESTART!!" call ExileServer_util_log;
			};
			ExileServerRestartMode = true;
		};
	};
};
true