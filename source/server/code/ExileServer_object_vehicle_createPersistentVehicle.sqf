/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_className","_position","_direction","_usePositionATL","_pinCode","_vehicleObject"];
_className = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_usePositionATL = _this select 3;
_pinCode = _this select 4;
_vehicleObject = createVehicle [_className, _position, [], 0, "CAN_COLLIDE"];
clearBackpackCargoGlobal _vehicleObject;
clearItemCargoGlobal _vehicleObject;
clearMagazineCargoGlobal _vehicleObject;
clearWeaponCargoGlobal _vehicleObject;
_position set[2, (_position select 2) + 0.25]; 
_vehicleObject setDir _direction;		
if (_usePositionATL) then
{
	_vehicleObject setPosATL _position;
}
else 
{
	_vehicleObject setPosASL _position;
};
_vehicleObject setVariable ["ExileIsPersistent", true];
_vehicleObject setVariable ["ExileAccessCode",_pinCode];
_vehicleObject addEventHandler ["GetOut", { _this call ExileServer_object_vehicle_event_onGetOut}];
_vehicleObject addMPEventHandler ["MPKilled", { _this call ExileServer_object_vehicle_event_onMPKilled}];
_vehicleObject call ExileServer_system_simulationMonitor_addVehicle;
_vehicleObject