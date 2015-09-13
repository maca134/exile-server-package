/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_playerObject","_spawnRadius","_spawnChance","_visualThreshold","_playerPosition","_lastKnownPlayerPosition","_buildings","_spawnedLoot","_building","_buildingType","_buildingConfig","_lootTableName","_localPositions","_spawnedItemClassNames","_lootGroundWeaponHolderNetIDs","_spawnedLootInThisBuilding","_lootPosition","_itemClassName","_cargoType","_lootHolder","_magazineClassNames","_magazineClassName","_numberOfMagazines"];
_playerObject = _this;
_spawnRadius = getNumber (configFile >> "CfgSettings" >> "LootSettings" >> "spawnRadius");
_spawnChance = (getNumber (configFile >> "CfgSettings" >> "LootSettings" >> "spawnChance") max 0) min 99; 
_visualThreshold = getNumber (configFile >> "CfgSettings" >> "LootSettings" >>  "visualThreshold");
try 
{
	if !(alive _playerObject) then 
	{
		throw false;
	};
	if !(vehicle _playerObject isEqualTo _playerObject) then
	{
		throw false;
	};
	_playerPosition = getPosATL _playerObject;
	_lastKnownPlayerPosition = _playerObject getVariable["ExilePositionAtLastLootSpawnCircle", [0,0,0]]; 
	if (_lastKnownPlayerPosition distance2D _playerPosition < 11) then
	{
		throw false;
	};
	_playerObject setVariable["ExilePositionAtLastLootSpawnCircle", _playerPosition];	
	if (_playerPosition call ExileClient_util_world_isTraderZoneNearby) then
	{
		throw false;
	};
	if (_playerPosition call ExileClient_util_world_isTerritoryNearby) then
	{
		throw false;
	};
	_buildings = _playerPosition nearObjects ["House", _spawnRadius];
	_spawnedLoot = false;
	{
		_building = _x;
		_buildingType = typeOf _building;
		if (isClass(configFile >> "CfgBuildings" >> _buildingType)) then
		{
			if !(_building getVariable ["ExileHasLoot", false]) then
			{
				if !([getPosATL _building, _visualThreshold] call ExileServer_util_position_isPlayerNearby) then
				{
					_buildingConfig = configFile >> "CfgBuildings" >> _buildingType;
					_lootTableName = getText(_buildingConfig >> "table");
					_localPositions = getArray(_buildingConfig >> "positions");
					_spawnedItemClassNames = [];
					_lootGroundWeaponHolderNetIDs = [];
					_spawnedLootInThisBuilding = false;
					{					
						if ((floor (random 100)) <= _spawnChance) then
						{
							_lootPosition = ASLToATL (AGLToASL (_building modelToWorld _x));
							if (_lootPosition select 2 < 0.05) then
							{
								_lootPosition set [2, 0.05];
							};
							_itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
							if !(_itemClassName in _spawnedItemClassNames) then
							{
								_cargoType = _itemClassName call ExileClient_util_cargo_getType;
								_lootHolder = createVehicle ["GroundWeaponHolder", _lootPosition, [], 0, "CAN_COLLIDE"];
								_lootHolder setDir (random 360);
								_lootHolder setPosATL _lootPosition;
								_lootHolder setVariable ["ExileSpawnedAt", time];
								_lootHolder setVariable ["ExileIsLoot", true]; 
								switch (_cargoType) do
								{
									case 1: 	
									{ 
										if (_itemClassName isEqualTo "Exile_Item_MountainDupe") then
										{
											_lootHolder addMagazineCargoGlobal [_itemClassName, 2]; 
										}
										else 
										{
											_lootHolder addMagazineCargoGlobal [_itemClassName, 1]; 
										};
									};
									case 3: 	
									{ 
										_lootHolder addBackpackCargoGlobal [_itemClassName, 1]; 
									};
									case 2: 	
									{ 
										_lootHolder addWeaponCargoGlobal [_itemClassName, 1]; 
										if (_itemClassName != "Exile_Melee_Axe") then
										{
											_magazineClassNames = getArray(configFile >> "CfgWeapons" >> _itemClassName >> "magazines");
											if (count(_magazineClassNames) > 0) then
											{
												_magazineClassName = _magazineClassNames select (floor(random (count _magazineClassNames)));
												_numberOfMagazines = 2 + floor(random 3); 
												_lootHolder addMagazineCargoGlobal [_magazineClassName, _numberOfMagazines];
											};
										};
									};
									default { _lootHolder addItemCargoGlobal [_itemClassName,1]; };
								};
								ExileServerOwnershipSwapQueue pushBack [_lootHolder, _playerObject];
								_spawnedItemClassNames pushBack _itemClassName;
								_lootGroundWeaponHolderNetIDs pushBack (netId _lootHolder);
								_spawnedLoot = true;
								_spawnedLootInThisBuilding = true;
							};
						};
					}
					forEach _localPositions;
					if (_spawnedLootInThisBuilding) then
					{
						ExileServerBuildingNetIdsWithLoot pushBack (netId _building);
						_building setVariable ["ExileLootSpawnedAt", time];
						_building setVariable ["ExileHasLoot", true];
						_building setVariable ["ExileLootGroundWeaponHolderNetIDs", _lootGroundWeaponHolderNetIDs];
					};
				};
			};
		};
	}
	forEach _buildings;
}
catch 
{
};
_spawnedLoot