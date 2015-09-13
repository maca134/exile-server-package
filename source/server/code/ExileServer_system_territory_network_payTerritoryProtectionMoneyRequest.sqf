/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_flagNetID","_mode","_playerObject","_flagObject","_territoryDatabaseID","_radius","_level","_objectsInTerritory","_popTabAmountPerObject","_totalPopTabAmount","_respectAmountPerObject","_totalRespectAmount","_playerPopTabs","_playerRespect","_currentTimestamp"];
_sessionID = _this select 0;
_parameters = _this select 1;
_flagNetID = _parameters select 0;
_mode = _parameters select 1;
try 
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _playerObject) then
	{
		throw "Invalid player object";
	};
	_flagObject = objectFromNetId _flagNetID;
	if (isNull _flagObject) then
	{
		throw "Invalid flag object";
	};
	_territoryDatabaseID = _flagObject getVariable ["ExileDatabaseID", 0];
	_radius = _flagObject getVariable ["ExileTerritorySize", 15];
	_level = _flagObject getVariable ["ExileTerritoryLevel", 1];
	_objectsInTerritory = 1 + (count ((getPosATL _flagObject) nearObjects ["Exile_Construction_Abstract_Static", _radius]));
	_popTabAmountPerObject = getNumber (missionConfigFile >> "CfgTerritories" >> "popTabAmountPerObject");
	_totalPopTabAmount = _level * _popTabAmountPerObject * _objectsInTerritory;
	_respectAmountPerObject = getNumber (missionConfigFile >> "CfgTerritories" >> "respectAmountPerObject");
	_totalRespectAmount = _level * _respectAmountPerObject * _objectsInTerritory;
	_playerPopTabs = _playerObject getVariable ["ExileMoney", 0];
	_playerRespect = _playerObject getVariable ["ExileScore", 0];
	if (_mode isEqualTo 0) then
	{
		if (_playerPopTabs < _totalPopTabAmount) then
		{
			throw "You do not have enough pop tabs!";
		};
		_playerPopTabs = _playerPopTabs - _totalPopTabAmount;
		_playerObject setVariable ["ExileMoney", _playerPopTabs];
		format["setAccountMoney:%1:%2", _playerPopTabs, getPlayerUID _playerObject] call ExileServer_system_database_query_fireAndForget;
	}
	else 
	{
		if (_playerRespect < _totalRespectAmount) then
		{
			throw "You do not have enough respect!";
		};
		_playerRespect = _playerRespect - _totalRespectAmount;
		_playerObject setVariable ["ExileScore", _playerRespect];
		format["setAccountScore:%1:%2", _playerRespect, getPlayerUID _playerObject] call ExileServer_system_database_query_fireAndForget;
	};
	_currentTimestamp = call ExileServer_util_time_currentTime;
	_flagObject setVariable ["ExileTerritoryLastPayed", _currentTimestamp, true];
	format["maintainTerritory:%1", _territoryDatabaseID] call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "payTerritoryProtectionMoneyResponse", [str _playerPopTabs, str _playerRespect]] call ExileServer_system_network_send_to;
}
catch
{
	[_sessionID, "notificationRequest", ["Whoops", [_exception]]] call ExileServer_system_network_send_to;
	_exception call ExileServer_util_log;
};