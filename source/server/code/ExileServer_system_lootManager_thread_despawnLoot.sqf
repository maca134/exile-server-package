/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_minimumLootLifeTime","_maximumLootLifeTime","_visualThreshold","_building","_lootSpawnTime","_despawnLoot","_lootAliveTime","_groundWeaponHolderNetIDs","_groundWeaponHolder"];
_minimumLootLifeTime = getNumber (configFile >> "CfgSettings" >> "LootSettings" >>  "minimumLifeTime");
_maximumLootLifeTime = getNumber (configFile >> "CfgSettings" >> "LootSettings" >>  "maximumLifeTime");
_visualThreshold = getNumber (configFile >> "CfgSettings" >> "LootSettings" >>  "visualThreshold");
{
	_building = objectFromNetId _x;
	_lootSpawnTime = _building getVariable ["ExileLootSpawnedAt", 0];
	_despawnLoot = false;
	_lootAliveTime = time - _lootSpawnTime;
	if (_lootAliveTime > _maximumLootLifeTime) then
	{
		_despawnLoot = true;	
	}
	else 
	{
		if (_lootAliveTime > _minimumLootLifeTime) then
		{
			if !([getPosATL _building, _visualThreshold] call ExileServer_util_position_isPlayerNearby) then
			{
				_despawnLoot = true;
			};
		};
	};
	if (_despawnLoot) then
	{
		_groundWeaponHolderNetIDs = _building getVariable ["ExileLootGroundWeaponHolderNetIDs", []];
		{
			_groundWeaponHolder = objectFromNetId _x;
			if !(isNull _groundWeaponHolder) then
			{
				deleteVehicle _groundWeaponHolder;
			};
		}
		forEach _groundWeaponHolderNetIDs;
		_building setVariable ["ExileLootSpawnedAt", nil];
		_building setVariable ["ExileHasLoot", false];
		_building setVariable ["ExileLootGroundWeaponHolderNetIDs", []];
		ExileServerBuildingNetIdsWithLoot deleteAt _forEachIndex;
	};
}
forEach ExileServerBuildingNetIdsWithLoot;