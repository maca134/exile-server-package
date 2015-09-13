/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_return","_temp"];
_return = objNull;
if!(ExileSessions isEqualTo [])then
{
	_temp = [];
	{
		_temp pushBack (_x select 1);
	} forEach ExileSessions;
	if!(_temp isEqualTo [])then
	{
		_return = _temp call BIS_fnc_selectRandom;
	};
};
_return