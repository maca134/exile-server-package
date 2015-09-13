/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionId","_parameters","_treeNetId","_player","_tree","_treeHeight","_newDamage","_treePosition","_spawnRadius","_weaponHolders","_weaponHolder","_weaponHolderPosition"];
_sessionId = _this select 0;
_parameters = _this select 1;
_treeNetId = _parameters select 0;
_player = _sessionId call ExileServer_system_session_getPlayerObject;
_tree = objectFromNetId _treeNetId;
if (!isNull _tree) then
{
	if (alive _tree) then
	{
		_treeHeight = _tree call ExileClient_util_model_getHeight;
		_treeHeight = _treeHeight max 1; 
		_newDamage = ((damage _tree) + (1 / (floor _treeHeight) )) min 1;
		_tree setDamage _newDamage; 
		if (_newDamage isEqualTo 1) then
		{
			_tree setDamage 999; 
		};
		_treePosition = getPosATL _tree;
		_treePosition set[2, 0];
		_spawnRadius = 3;
		_weaponHolders = nearestObjects[_treePosition, ["groundWeaponHolder"], _spawnRadius];
		_weaponHolder = objNull;
		if ( count _weaponHolders == 0 ) then
		{
			_weaponHolderPosition = [_treePosition, _spawnRadius] call ExileClient_util_math_getRandomPositionInCircle;
			_weaponHolderPosition set [2, 0];
			_weaponHolder = createVehicle ["groundWeaponHolder", _weaponHolderPosition, [], 0, "CAN_COLLIDE"];
			_weaponHolder setPosATL _weaponHolderPosition;
		}
		else 
		{
			_weaponHolder = _weaponHolders select 0;
		};
		_weaponHolder addMagazineCargoGlobal["Exile_Item_WoodLog", 1];
	};
};
true