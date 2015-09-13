/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_objectNetID","_object","_playerObject","_radius","_flags","_flag","_build","_objectID"];
_sessionID = _this select 0;
_parameters = _this select 1;
_objectNetID = _parameters select 0;
_object = objectFromNetId _objectNetID;
_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
_radius = getArray(missionConfigFile >> "CfgTerritories" >> "prices");
_radius = (_radius select ((count _radius) -1)) select 1;
_flags = _playerObject nearObjects ["Exile_Construction_Flag_Static", _radius * 2];
_flag = _flags select 0;
_build_rights = _flag getVariable ["ExileTerritoryBuildRights",[]];
if((getPlayerUID _playerObject) in _build_rights)then
{
	if!(_object isKindOf "Exile_Construction_Abstract_Physics")then
	{
		_objectID = _object getVariable ["ExileDatabaseID",-1];
		if(_objectID != -1)then{
			_object call ExileServer_object_construction_database_delete;
		};
	};
	deleteVehicle _object;
	[_sessionID,"constructionMoveResponse",[true,typeOf _object]] call ExileServer_system_network_send_to;
}
else
{
	[_sessionID,"constructionMoveResponse",[false,"Banana!"]] call ExileServer_system_network_send_to;
};
