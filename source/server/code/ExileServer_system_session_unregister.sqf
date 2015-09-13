/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_outcome"];
_outcome = false;
{
	if(getPlayerUID (_x select 1) isEqualTo _this)exitWith
	{
		ExileSessions deleteAt _forEachIndex;
		diag_log str _x;
		_outcome = true;
	};
}
forEach ExileSessions;
_outcome