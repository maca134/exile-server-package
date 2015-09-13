/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionId","_isValid"];
_sessionId = _this;
_isValid = false;
{
	if (_x select 0 == _sessionId) exitWith
	{
		_isValid = true;
	};
}
forEach ExileSessions;
_isValid