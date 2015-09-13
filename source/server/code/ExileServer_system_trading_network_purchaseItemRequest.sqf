/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_itemClassName","_quantity","_containerType","_containerNetID","_playerObject","_vehicleObject","_salesPrice","_playerMoney","_responseCode"];
_sessionID = _this select 0;
_parameters = _this select 1;
_itemClassName = _parameters select 0;
_quantity = _parameters select 1;
_containerType = _parameters select 2;
_containerNetID = _parameters select 3;
try 
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if(_playerObject getVariable ["ExileMutex",false])then
	{
		throw 12;
	};
	_playerObject setVariable ["ExileMutex",true];
	_vehicleObject = objNull;
	if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
	if !(isClass (missionConfigFile >> "CfgExileArsenal" >> _itemClassName) ) then
	{
		throw 3;
	};
	_salesPrice = getNumber (missionConfigFile >> "CfgExileArsenal" >> _itemClassName >> "price");
	if (_salesPrice <= 0) then
	{
		throw 4;
	};
	_playerMoney = _playerObject getVariable ["ExileMoney", 0];
	if (_playerMoney < _salesPrice) then
	{
		throw 5;
	};
	_playerMoney = _playerMoney - _salesPrice;
	_playerObject setVariable ["ExileMoney", _playerMoney];
	format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "purchaseItemResponse", [0, str _playerMoney, _itemClassName, 1, _containerType, _containerNetID]] call ExileServer_system_network_send_to;
	if !(_vehicleObject isEqualTo objNull) then
	{
		_vehicleObject call ExileServer_object_vehicle_database_update;
	}
	else 
	{
		_playerObject call ExileServer_object_player_database_update;
	};
}
catch 
{
	_responseCode = _exception;
	[_sessionID, "purchaseItemResponse", [_responseCode, "", "", 0, 0, ""]] call ExileServer_system_network_send_to;
};	
_playerObject setVariable ["ExileMutex",false];
true