/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_paramaters","_objectClassName","_objectPosition","_flag","_territoryName","_alphabet","_forbiddenCharacter","_playerObject","_maxRange","_flags","_object"];
_sessionID = _this select 0;
_paramaters = _this select 1;
_objectClassName = _paramaters select 0;
_objectPosition = _paramaters select 1;
_flag = _paramaters select 2;
_territoryName = _paramaters select 3;
try
{
	_territoryName = _territoryName call ExileClient_util_string_trim;
	_alphabet = getText (missionConfigFile >> "CfgClans" >> "clanNameAlphabet");
	_forbiddenCharacter = [_territoryName, _alphabet] call ExileClient_util_string_containsForbiddenCharacter;
	if!(_forbiddenCharacter isEqualTo -1)then
	{
		throw "Forbidden Character"
	};
	if!(_objectClassName isEqualTo "Exile_Construction_Flag_Preview")then
	{
		throw "What a hell are you doing"
	};
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	_maxRange = getArray(missionConfigFile >> "CfgTerritories" >> "prices");
	_maxRange = (_maxRange select ((count _maxRange) -1)) select 1;
	_flags = nearestObjects [_playerObject,["Exile_Construction_Flag_Static"],_maxRange * 2];
	if!(_flags isEqualTo [])then
	{
		throw "Cant build in another teritory range!"
	};
	_object = createVehicle[_objectClassName, _objectPosition, [], 0, "CAN_COLLIDE"];	
	_object setPos _objectPosition;
	_object enableSimulationGlobal true;
	if(isClass (configFile >> "CfgFlagsNative" >> _flag))then
	{
		_flag = getText(configFile >> "CfgFlagsNative" >> _flag >> "texture");
	}
	else
	{
		_flag = getText(missionConfigFile >> "CfgFlags" >> _flag >> "texture");
	};
	_object setVariable ["ExileFlagTexture",_flag];
	_object setFlagTexture _flag;
	_object setVariable ["ExileTerritoryName",_territoryName];
	_object setVariable ["ExileOwnerUID",getPlayerUID _playerObject,true];
	if(isNull _playerObject)then
	{
		deleteVehicle _object;
		throw "Invalid Player Object";
	};
	ExileServerOwnershipSwapQueue pushBack [_object,_playerObject];
	[_sessionID,"constructionResponse",[netid _object]] call ExileServer_system_network_send_to;
}
catch
{
	[_sessionID,"notificationRequest",["Whoops",[_exception]]] call ExileServer_system_network_send_to;
	_exception call ExileServer_util_log;
};
true