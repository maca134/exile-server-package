/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_netID","_player"];
_sessionID = _this select 0;
_parameters = _this select 1;
_netID = _parameters select 0;
try 
{
	_player = objectFromNetId _netID;
	if (isNull _player) then
	{
		throw "Cannot update session for unknown network ID!";
	};
	{
		if ( (_x select 0) == _sessionID ) exitWith
		{
			format["Session ID for '%1' has been updated to '%2'!", (name _player), _sessionID] call ExileServer_util_log;
			ExileSessions set [_forEachIndex, [_sessionID, _player] ];
		};
	}
	forEach ExileSessions;
}
catch
{
	_exception call ExileServer_util_log;
};
true