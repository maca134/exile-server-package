/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_containerObject","_position","_vectorDirection","_vectorUp","_data","_extDB2Message","_containerID"];
_containerObject = _this;
_position = getPosATL _containerObject;
_vectorDirection = vectorDir _containerObject;
_vectorUp = vectorUp _containerObject;
_data =
[
	typeOf _containerObject,
	_containerObject getVariable ["ExileOwnerUID", ""],
	_position select 0,
	_position select 1,
	_position select 2,
	_vectorDirection select 0, 
	_vectorDirection select 1,
	_vectorDirection select 2,
	_vectorUp select 0,
	_vectorUp select 1,
	_vectorUp select 2,
	[],
	[],
	[],
	[],
	"0000"
];
_extDB2Message = ["insertContainer", _data] call ExileServer_util_extDB2_createMessage;
_containerID = _extDB2Message call ExileServer_system_database_query_insertSingle;
_containerObject setVariable ["ExileDatabaseID", _containerID];
_containerObject setVariable ["ExileIsPersistent", true];
_containerObject setVariable ["ExileIsContainer", true];
_containerObject setVariable ["ExileAccessCode","0000"];
_containerObject addMPEventHandler ["MPKilled",{if!(isServer)exitwith{}; (_this select 0) call ExileServer_object_container_database_delete}];
if(getNumber(configFile >> "CfgVehicles" >> typeOf _containerObject >> "exileIsLockable") isEqualTo 1)then
{
	_containerObject setVariable ["ExileIsLocked",-1,true];
};
_containerID