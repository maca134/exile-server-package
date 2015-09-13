/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_flag","_size","_constructionObjects","_owner","_flagID","_postion","_construction","_constructionID"];
_flag = _this;
_size = _flag getVariable ["ExileTerritorySize",0];
_constructionObjects = _flag nearObjects ["Exile_Construction_Abstract_Static", _size];
_owner = _flag getVariable ["ExileOwnerUID",""];
_flagID = _flag getVariable ["ExileDatabaseID",0];
_postion = getPosATL _flag;
{
	_construction = _x;
	_constructionID = _construction getVariable ["ExileDatabaseID",0];
	if!(_constructionID isEqualTo 0)then
	{
		format ["deleteConstruction:%1", _constructionID] call ExileServer_system_database_query_fireAndForget;
		deleteVehicle _x;
	}	
	else
	{
		format ["CantFindDbID for object %1",_x] call ExileServer_util_log;
	};
} 
forEach _constructionObjects;
format ["deleteTerritory:%1", _flagID] call ExileServer_system_database_query_fireAndForget;
deleteVehicle _flag;
format 
[
	"Teritory at: %1 with previous owner(UID): %2 was deleted due to protection money not being payed.",
	_postion,
	_owner
]
call ExileServer_util_log;
true