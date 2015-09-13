/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionId","_newPlayerObject"];
_sessionId = _this select 0;
_newPlayerObject = _this select 1;
{
	if (_x select 0 == _sessionId) exitWith
	{
		ExileSessions set [_forEachIndex, [_sessionId, _newPlayerObject]];
	};
}
forEach ExileSessions;