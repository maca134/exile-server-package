/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_data","_oldPlayerObject","_playerUID","_sessionID","_position","_direction","_player","_clanID","_clanName","_headgear","_goggles","_binocular","_uniform","_vest","_backpack","_uniformContainer","_vestContainer","_backpackContainer","_loadObject","_primaryWeapon","_handgunWeapon","_secondaryWeapon","_currentWeapon","_assigned"];
_data = _this select 0;
_oldPlayerObject = _this select 1;
_playerUID = _this select 2;
_sessionID = _this select 3;
_name = name _oldPlayerObject;
_position = [_data select 16, _data select 17, _data select 18];
_direction = _data select 15;
_group = createGroup independent;
_player = _group createUnit ["Exile_Unit_Player", _position, [], 0, "CAN_COLLIDE"];
_player setVariable ["ExileSessionID",_sessionID];
_player setDir _direction;
_player setPosATL _position;
_player disableAI "FSM";
_player disableAI "MOVE";
_player disableAI "AUTOTARGET";
_player disableAI "TARGET";
_clanID = (_data select 47);
_clanName = (_data select 48);
if !((typeName _clanID) isEqualTo "SCALAR") then
{
	_clanID = -1;
	_clanName = "";
};
_player setDamage (_data select 4);
_player setFatigue (_data select 5);
_player setName _name;
_player setVariable ["ExileMoney", (_data select 43)];
_player setVariable ["ExileScore", (_data select 44)];
_player setVariable ["ExileKills", (_data select 45)];
_player setVariable ["ExileDeaths", (_data select 46)];
_player setVariable ["ExileClanID", _clanID];
_player setVariable ["ExileClanName", _clanName];
_player setVariable ["ExileName", _name]; 
_player setVariable ["ExileOwnerUID", _playerUID]; 
_player setVariable ["ExileDatabaseID", _data select 0];
_player setVariable ["ExileHunger", _data select 6];
_player setVariable ["ExileThirst", _data select 7];
_player setVariable ["ExileAlcohol", _data select 8]; 
_player setVariable ["ExileIsBambi", false];
_player setVariable ["ExileXM8IsOnline", false, true];
_player setOxygenRemaining (_data select 9);
_player setBleedingRemaining (_data select 10);
_player setHitPointDamage ["hitHead", _data select 11];
_player setHitPointDamage ["hitBody", _data select 12];
_player setHitPointDamage ["hitHands", _data select 13];
_player setHitPointDamage ["hitLegs", _data select 14];
_player call ExileClient_util_playerCargo_clear;
_headgear = _data select 28;
if (_headgear != "") then
{
	_player addHeadgear _headgear;
};
_goggles = _data select 25;
if (_goggles != "") then
{
	_player addGoggles _goggles;
};
_binocular = _data select 29;
if (_binocular != "") then
{
	_player addWeaponGlobal _binocular;
};
_uniform = _data select 35;
_vest = _data select 39;
_backpack = _data select 20;
if (_uniform != "") then 
{
	_player addUniform _uniform;
};
if (_vest != "") then
{
	_player addVest _vest;
};
if (_backpack != "") then
{
	_player addBackpack _backpack;
};
_uniformContainer = uniformContainer _player;
if !(isNil "_uniformContainer") then
{
	{ 
		_uniformContainer addWeaponCargoGlobal _x; 
	} 
	forEach (_data select 38);
	{ 
		_uniformContainer addMagazineAmmoCargo [_x select 0, 1, _x select 1]; 
	} 
	forEach (_data select 37);
	{ 
		_uniformContainer addItemCargoGlobal _x; 
	} 
	forEach (_data select 36);
};
_vestContainer = vestContainer _player;
if !(isNil "_vestContainer") then
{
	{ 
		_vestContainer addWeaponCargoGlobal _x; 
	} 
	forEach (_data select 42);
	{ 
		_vestContainer addMagazineAmmoCargo [_x select 0, 1, _x select 1]; 
	} 
	forEach (_data select 41);
	{ 
		_vestContainer addItemCargoGlobal _x; 
	} 
	forEach (_data select 40);
};
_backpackContainer = backpackContainer _player;
if !(isNil "_backpackContainer") then
{
	{ 
		_backpackContainer addWeaponCargoGlobal _x; 
	} 
	forEach (_data select 23);
	{ 
		_backpackContainer addMagazineAmmoCargo [_x select 0, 1, _x select 1]; 
	} 
	forEach (_data select 22);
	{ 
		_backpackContainer addItemCargoGlobal _x; 
	} 
	forEach (_data select 21);
};
_loadObject = nil;
switch (true) do
{
	case (_uniform != ""): 	{ _loadObject = _uniformContainer; };
	case (_vest != ""): 	{ _loadObject = _vestContainer; };
	case (_backpack != ""): { _loadObject = _backpackContainer; };
};
if !(isNil "_loadObject") then
{
	{ 
		_loadObject addMagazineAmmoCargo [_x select 0, 1, _x select 1]; 
	} 
	forEach (_data select 30);
};
_primaryWeapon = _data select 31;
if (_primaryWeapon != "") then 
{
	_player addWeapon _primaryWeapon;
	removeAllPrimaryWeaponItems _player;
	{ 
		if (_x != "") then
		{
			_player addPrimaryWeaponItem _x; 
		};
	} 
	forEach (_data select 32);
};
_handgunWeapon = _data select 27;
if (_handgunWeapon != "") then
{
	_player addWeapon _handgunWeapon;
	removeAllHandgunItems _player;
	{ 
		if (_x != "") then
		{
			_player addHandgunItem _x; 
		};
	} 
	forEach (_data select 26);
};
_secondaryWeapon = _data select 33;
if (_secondaryWeapon != "") then
{
	_player addWeapon _secondaryWeapon;
	{ 
		if (_x != "") then
		{
			_player addSecondaryWeaponItem _x; 
		};
	} 
	forEach (_data select 34);
};
 _currentWeapon = _data select 24;
if (_currentWeapon != "") then
{
	 _player selectWeapon _currentWeapon;
};
_assigned_items = _data select 19;
if !(_assigned_items isEqualTo []) then
{
	{
		_player linkItem _x;
	}
	forEach _assigned_items;
};
_player addMPEventHandler ["MPKilled", {_this call ExileServer_object_player_event_onMpKilled}];
[
	_sessionID, 
	"loadPlayerResponse", 
	[
		(netId _player),
		str (_player getVariable ["ExileMoney", 0]),
		str (_player getVariable ["ExileScore", 0]),
		(_player getVariable ["ExileKills", 0]),
		(_player getVariable ["ExileDeaths", 0]),
		(_player getVariable ["ExileHunger", 100]),
		(_player getVariable ["ExileThirst", 100]),
		(_player getVariable ["ExileAlcohol", 0]),
		(_player getVariable ["ExileClanName", ""])
	]
] 
call ExileServer_system_network_send_to;
[_sessionID, _player] call ExileServer_system_session_updatePlayerObject;
true