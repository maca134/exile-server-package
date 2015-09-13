/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_clanName","_player","_alphabet","_forbiddenCharacter","_registrationFee","_playerMoney","_clanID"];
_sessionID = _this select 0;
_parameters = _this select 1;
_clanName = _parameters select 0;
try 
{
	_player = _sessionID call ExileServer_system_session_getPlayerObject;
	_alphabet = getText (missionConfigFile >> "CfgClans" >> "clanNameAlphabet");
	_forbiddenCharacter = [_clanName, _alphabet] call ExileClient_util_string_containsForbiddenCharacter;
	if !(_forbiddenCharacter isEqualTo -1) then
	{
		throw 5;
	};
	if (_player isEqualTo objNull) then
	{
		throw 1;
	};
	if !(alive _player) then
	{
		throw 2;
	};
	_registrationFee = getNumber (missionConfigFile >> "CfgClans" >> "registrationFee");
	_playerMoney = _player getVariable ["ExileMoney", 0]; 
	if (_playerMoney < _registrationFee) then
	{
		throw 3;
	};
	if !((_player getVariable ["ExileClanID", -1]) isEqualTo -1) then
	{
		throw 4;
	};
	_playerMoney = _playerMoney - _registrationFee;
	_player setVariable ["ExileMoney", _playerMoney];
	format["setAccountMoney:%1:%2", _playerMoney, getPlayerUID _player] call ExileServer_system_database_query_fireAndForget;
	_clanID = format["createClan:%1:%2", getPlayerUID _player, _clanName] call ExileServer_system_database_query_insertSingle;
	format["setAccountClanLink:%1:%2", _clanID, getPlayerUID _player] call ExileServer_system_database_query_fireAndForget;
	_player setVariable ["ExileClanID", _clanID];
	_player setVariable ["ExileClanName", _clanName];
	[_sessionID, "registerClanResponse", [0, _clanName, str _playerMoney]] call ExileServer_system_network_send_to;
}
catch
{
	[_sessionID, "registerClanResponse", [_exception, "", 0]] call ExileServer_system_network_send_to;
};
true