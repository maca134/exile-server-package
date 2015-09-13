/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_playerObject","_spawnRadius","_spawnChance","_notifyPlayer","_playerPosition","_lastKnownPlayerPosition","_radius","_flags","_buildings","_spawnedLootForThisPlayer","_building","_flag","_flagRadius","_buildingConfig","_lootTableName","_localPositions","_spawnedItemClassNames","_lootPosition","_itemClassName","_cargoType","_lootHolder","_magazineClassNames","_magazineClassName","_numberOfMagazines"];
_playerObject = _this;
_spawnRadius = (getNumber(configFile >> "CfgSettings" >> "LootSettings" >> "spawnRadius") max 50) min 200; 
_spawnChance = (getNumber(configFile >> "CfgSettings" >> "LootSettings" >> "spawnChance") max 0) min 99; 
_notifyPlayer = getNumber(configFile >> "CfgSettings" >> "LootSettings" >> "notifyPlayer");
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
	if (_lastKnownPlayerPosition distance _playerPosition < 11) then
	{
		throw false;
	};
	_radius = getArray(missionConfigFile >> "CfgTerritories" >> "prices");
	_radius = (_radius select ((count _radius) -1)) select 1;
	_flags = _playerPosition nearObjects ["Exile_Construction_Flag_Static", _radius * 2];
	_buildings = _playerPosition nearObjects ["House", _spawnRadius];
	_spawnedLootForThisPlayer = false;
	{
		_building = _x;
		if!(_flags isEqualTo [])then
		{
			{
				_flag = _x;
				_flagRadius = _flag getVariable ["ExileTerritorySize",0];
				if((_building distance _flag) < _flagRadius)then
				{
					throw false;
				}; 
			} 
			forEach _flags;
		};
		if (isClass(configFile >> "CfgBuildings" >> (typeOf _building))) then
		{
			if !([getPosATL _building, 10] call ExileServer_util_position_isPlayerNearby) then
			{
				if !(_building getVariable ["ExileHasLoot", false]) then
				{
					_buildingConfig = configFile >> "CfgBuildings" >> (typeOf _building);
					_lootTableName = getText(_buildingConfig >> "table");
					_localPositions = getArray(_buildingConfig >> "positions");
					_spawnedItemClassNames = [];
					{					
						if ((floor (random 100)) <= _spawnChance) then
						{
							_lootPosition = _building modelToWorld _x;
							if (_lootPosition select 2 < 0.05) then
							{
								_lootPosition set[2, 0.05];
							};
							_itemClassName = _lootTableName call ExileServer_system_lootManager_dropItem;
							if !(_itemClassName in _spawnedItemClassNames) then
							{
								_cargoType = _itemClassName call ExileClient_util_cargo_getType;
								_lootHolder = createVehicle ["GroundWeaponHolder",_lootPosition,[],0,"CAN_COLLIDE"];
								_lootHolder setDir (random 360);
								_lootHolder setPosATL _lootPosition;
								_lootHolder setVariable ["ExileSpawnedAt", time];
								switch (_cargoType) do
								{
									case 1: 	{ _lootHolder addMagazineCargoGlobal [_itemClassName, 1]; };
									case 3: 	{ _lootHolder addBackpackCargoGlobal [_itemClassName, 1]; };
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
								ExileServerOwnershipSwapQueue pushBack [_lootHolder,_playerObject];
								_spawnedItemClassNames pushBack _itemClassName;
								_spawnedLootForThisPlayer = true;
							};
						};
					}
					forEach _localPositions;
					ExileServerBuildingNetIdsWithLoot pushBack (netId _building);
					_building setVariable ["ExileLootSpawnedAt", time];
					_building setVariable ["ExileHasLoot", true];
				};
			};
		};
	}
	forEach _buildings;
	if (_notifyPlayer == 1) then
	{
		if (_spawnedLootForThisPlayer) then
		{
			[_playerObject, "notificationRequest",["Success",["Loot spawned for you!"]]] call ExileServer_system_network_send_to;
		};
	};
	_playerObject setVariable["ExilePositionAtLastLootSpawnCircle", _playerPosition];	
	_playerObject setVariable["ExileLastLootSpawnTime", time];
}
catch 
{
};
true