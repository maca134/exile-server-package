/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_lootLifetime","_lootDespawnRadius","_building"];
_lootLifetime = ((getNumber(configFile >> "CfgSettings" >> "LootSettings" >>  "lifeTime") max 300) min 600);
_lootDespawnRadius = ((getNumber(configFile >> "CfgSettings" >> "LootSettings" >>  "despawnRadius") max 10) min 200);
{
	_building = objectFromNetId _x;
	if (time - (_building getVariable ["ExileLootSpawnedAt", _lootLifetime]) >= _lootLifetime) then
	{
		if !([getPosATL _building, _lootDespawnRadius] call ExileServer_util_position_isPlayerNearby) then
		{
			_building setVariable ["ExileLootSpawnedAt", nil];
			_building setVariable ["ExileHasLoot", false];
			ExileServerBuildingNetIdsWithLoot deleteAt _forEachIndex;
		};
	};
}
forEach ExileServerBuildingNetIdsWithLoot;
true