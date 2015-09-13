/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_player","_playerID","_playerPos","_data","_extDB2Message"];
_player = _this;
_playerID = _player getVariable["ExileDatabaseID", -1];
_playerPos = getPosATL _player;
if(_playerPos select 2 > 500)then
{
	_playerPos set [2,0];
};
_data = 
[
	name _player,
	if (_player getVariable ["ExileIsDead",false]) then {0} else {1},
	damage _player,
	getFatigue _player,
	_player getVariable ["ExileHunger", 100],
	_player getVariable ["ExileThirst", 100],
	_player getVariable ["ExileAlcohol", 0],
	getOxygenRemaining _player,
	getBleedingRemaining _player,
	_player getHitPointDamage "hitHead",
	_player getHitPointDamage "hitBody",
	_player getHitPointDamage "hitHands",
	_player getHitPointDamage "hitLegs",
	getDir _player,
	_playerPos select 0,
	_playerPos select 1,
	_playerPos select 2,
	assignedItems _player,
	backpack _player,
	(getItemCargo backpackContainer _player) call ExileClient_util_cargo_getMap,
	(backpackContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo backpackContainer _player) call ExileClient_util_cargo_getMap,
	currentWeapon _player,
	goggles _player,
	handgunItems _player,
	handgunWeapon _player,
	headgear _player,
	binocular _player,
	_player call ExileClient_util_inventory_getLoadedMagazinesMap,
	primaryWeapon _player,
	primaryWeaponItems _player,
	secondaryWeapon _player,
	secondaryWeaponItems _player,
	uniform _player,
	(getItemCargo uniformContainer _player) call ExileClient_util_cargo_getMap,
	(uniformContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo uniformContainer _player) call ExileClient_util_cargo_getMap,
	vest _player,
	(getItemCargo vestContainer _player) call ExileClient_util_cargo_getMap,
	(vestContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo vestContainer _player) call ExileClient_util_cargo_getMap,
	_playerID
];
_extDB2Message = ["updatePlayer", _data] call ExileServer_util_extDB2_createMessage;
_extDB2Message call ExileServer_system_database_query_fireAndForget;
true