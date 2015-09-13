/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_itemClassName","_quantity","_containerType","_containerNetID","_playerObject","_vehicleObject","_salesPrice","_sellPrice","_playerMoney","_respectGain","_playerRespect","_responseCode"];
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
	_sellPrice = floor (_salesPrice * 0.5);
	if (_sellPrice <= 0) then
	{
		throw 4;
	};
	_playerMoney = _playerObject getVariable ["ExileMoney", 0];
	_playerMoney = _playerMoney + _sellPrice;
	_playerObject setVariable ["ExileMoney", _playerMoney];
	_respectGain = _sellPrice * getNumber (configFile >> "CfgSettings" >> "Respect" >> "tradingRespectFactor");
	_playerRespect = _playerObject getVariable ["ExileScore", 0];
	_playerRespect = floor (_playerRespect + _respectGain);
	_playerObject setVariable ["ExileScore", _playerRespect];
	format["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "sellItemResponse", [0, str _playerMoney, _itemClassName, 1, _containerType, _containerNetID, str _playerRespect]] call ExileServer_system_network_send_to;
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
	diag_log format ["NOPE: %1", _responseCode];
	[_sessionID, "sellItemResponse", [_responseCode, "", "", 0, 0, "", ""]] call ExileServer_system_network_send_to;
};
_playerObject setVariable ["ExileMutex",false];
true