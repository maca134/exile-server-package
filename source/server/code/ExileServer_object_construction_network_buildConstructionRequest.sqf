/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_paramaters","_objectClassName","_objectPosition","_playerObject","_maxRange","_no","_flags","_range","_buildRights","_object"];
_sessionID = _this select 0;
_paramaters = _this select 1;
_objectClassName = _paramaters select 0;
_objectPosition = _paramaters select 1;
try
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	_maxRange = getArray(missionConfigFile >> "CfgTerritories" >> "prices");
	_maxRange = (_maxRange select ((count _maxRange) -1)) select 1;
	_no_need_for_Terriotry = getArray(missionConfigFile >> "CfgTerritories" >> "noNeedForTerritory");
	if!(_objectClassName in _no_need_for_Terriotry)then
	{
		_flags = nearestObjects [_playerObject,["Exile_Construction_Flag_Static"],_maxRange];
		if!(_flags isEqualTo [])then
		{
			_flags = _flags select 0;
			_range = _flags getVariable ["ExileTerritorySize",0];
			if(_range < (_playerObject distance2D _flags))then
			{
				throw "Build a territory first!"
			};
			_buildRights = _flags getVariable ["ExileTerritoryBuildRights",[]];
			if!((getPlayerUID _playerObject) in _buildRights)then
			{
				throw "No territory access!"
			};
		}
		else
		{
			throw "Build a territory first!"
		};
	};
	_object = createVehicle[_objectClassName, _objectPosition, [], 0, "CAN_COLLIDE"];
	_object setPos _objectPosition;
	_object setVariable ["BIS_enableRandomization", false];
	_object enableSimulationGlobal false;
	_object setVariable ["ExileOwnerUID",getPlayerUID _playerObject];
	if(!isNull _playerObject)then
	{
		ExileServerOwnershipSwapQueue pushBack [_object,_playerObject];
		[_sessionID,"constructionResponse",[netid _object]] call ExileServer_system_network_send_to;
	}
	else
	{
		deleteVehicle _object;
		"Construction request aborted player is null!" call ExileServer_util_log;
	};
}
catch
{
	[_sessionID,"notificationRequest",["Whoops",[_exception]]] call ExileServer_system_network_send_to;
};
true