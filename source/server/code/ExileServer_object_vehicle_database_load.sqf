/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_vehicleID","_data","_position","_vectorDirection","_vectorUp","_pinCode","_vehicleObject","_lock","_cargoContainers"];
_vehicleID = _this;
_data = format ["loadVehicle:%1", _vehicleID] call ExileServer_system_database_query_selectSingle;
_position = [_data select 8, _data select 9, _data select 10];
_vectorDirection = [_data select 11, _data select 12, _data select 13];
_vectorUp = [_data select 14, _data select 15, _data select 16];
_pinCode = _data select 20;
_vehicleObject = [(_data select 1), _position, 0, true,_pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
_vehicleObject setVectorDirAndUp [_vectorDirection, _vectorUp];
_vehicleObject setVariable ["ExileDatabaseID", _vehicleID];
_vehicleObject setVariable ["ExileOwnerUID", (_data select 3)];
_lock = (_data select 4);
if(_lock isEqualTo -1)then
{
	_vehicleObject setVariable ["ExileIsLocked",-1];
	_vehicleObject lock 2;
	_vehicleObject enableRopeAttach false;
}
else
{
	_vehicleObject setVariable ["ExileIsLocked",0];
	_vehicleObject lock 0;
};
_vehicleObject setFuel (_data select 5);
_vehicleObject setDamage (_data select 6);
{
	_vehicleObject setHitPointDamage [_x select 0, _x select 1];
}
forEach (_data select 7);
[_vehicleObject, (_data select 17)] call ExileServer_util_fill_fillItems;
[_vehicleObject, (_data select 18)] call ExileServer_util_fill_fillMagazines;
[_vehicleObject, (_data select 19)] call ExileServer_util_fill_fillWeapons;
_cargoContainers = format ["loadVehicleContainer:%1", _vehicleID] call ExileServer_system_database_query_selectSingle;
if !(_cargoContainers isEqualTo []) then
{
	[_vehicleObject, (_cargoContainers select 0)] call ExileServer_util_fill_fillContainers;
};
_vehicleObject enableSimulationGlobal false;
_vehicleObject call ExileServer_system_simulationMonitor_addVehicle;
_vehicleObject