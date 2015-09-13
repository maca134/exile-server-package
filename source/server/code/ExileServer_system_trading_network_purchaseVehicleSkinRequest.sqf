/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_vehicleNetID","_skinClassName","_playerObject","_vehicleObject","_vehicleParentClass","_salesPrice","_skinVariations","_availableSkinClassName","_playerMoney","_skinTextures","_skinMaterials","_vehicleID","_responseCode"];
_sessionID = _this select 0;
_parameters = _this select 1;
_vehicleNetID = _parameters select 0;
_skinClassName = _parameters select 1;
try 
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if(_playerObject getVariable ["ExileMutex",false])then
	{
		throw 12;
	};
	_playerObject setVariable ["ExileMutex",true];
	if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
	_vehicleObject = objectFromNetId _vehicleNetID;
	if (isNull _vehicleObject) then
	{
		throw 6;
	};
	_vehicleParentClass = configName (inheritsFrom (configFile >> "CfgVehicles" >> (typeOf _vehicleObject)));
	if !(isClass (missionConfigFile >> "CfgVehicleCustoms" >> _vehicleParentClass) ) then
	{
		throw 7;
	};
	_salesPrice = -1;
	_skinVariations = getArray(missionConfigFile >> "CfgVehicleCustoms" >> _vehicleParentClass >> "skins");
	{
		_availableSkinClassName = _x select 0;
		diag_log format["teste %1", _availableSkinClassName];
		if (_availableSkinClassName isEqualTo _skinClassName) exitWith
		{
		diag_log "Yay";
			_salesPrice = _x select 1;
		};
	}
	forEach _skinVariations;
	if (_salesPrice <= 0) then
	{
		throw 4;
	};
	_playerMoney = _playerObject getVariable ["ExileMoney", 0];
	if (_playerMoney < _salesPrice) then
	{
		throw 5;
	};
	_skinTextures = getArray(configFile >> "CfgVehicles" >> _skinClassName >> "hiddenSelectionsTextures");
	_skinMaterials = getArray(configFile >> "CfgVehicles" >> _skinClassName >> "hiddenSelectionsMaterials");
	{
		_vehicleObject setObjectTextureGlobal [_forEachIndex, _x];
	}
	forEach _skinTextures;
	{
		_vehicleObject setObjectMaterial [_forEachIndex, _x];
	}
	forEach _skinMaterials;
	_vehicleID = _vehicleObject getVariable ["ExileDatabaseID", -1];
	format["updateVehicleClass:%1:%2", _skinClassName, _vehicleID] call ExileServer_system_database_query_fireAndForget;
	_playerMoney = _playerMoney - _salesPrice;
	_playerObject setVariable ["ExileMoney", _playerMoney];
	format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "purchaseVehicleSkinResponse", [0, str _playerMoney]] call ExileServer_system_network_send_to;
}
catch 
{
	_responseCode = _exception;
	[_sessionID, "purchaseVehicleSkinResponse", [_responseCode, ""]] call ExileServer_system_network_send_to;
};
_playerObject setVariable ["ExileMutex",false];
true