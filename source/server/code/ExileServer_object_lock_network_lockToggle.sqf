/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_paramaters","_object","_pincode","_state","_objectPinCode","_type"];
_sessionID = _this select 0;
_paramaters = _this select 1;
_object = objectFromNetId (_paramaters select 0);
_pincode = _paramaters select 1;
_state = _paramaters select 2;
_objectPinCode = _object getVariable ["ExileAccessCode","000000"];
_type = typeOf _object;
if((count _pincode) isEqualTo (count _objectPinCode))then
{
	if(_pincode isEqualTo _objectPinCode)then
	{
		if!(_state)then
		{
			if(isNumber(configFile >> "CfgVehicles" >> _type >> "exileIsLockable"))then
			{
				_object setVariable ["ExileIsLocked",0,true];
			}
			else
			{
				if(local _object)then
				{
					_object lock 0;
				}
				else
				{
					[owner _object,"LockVehicleRequest",[_object,false]] call ExileServer_system_network_send_to;
				};
				_object setVariable ["ExileIsLocked",0];
			};
			[_sessionID,"lockResponse",["Unlocked!", true , _object , _objectPinCode]] call ExileServer_system_network_send_to;
			_object enableRopeAttach true;
		}
		else
		{
			if(isNumber(configFile >> "CfgVehicles" >> _type >> "exileIsLockable"))then
			{
				_object setVariable ["ExileIsLocked",-1,true];
			}
			else
			{
				if(local _object)then
				{
					_object lock 2;
				}
				else
				{
					[owner _object,"LockVehicleRequest",[_object,true]] call ExileServer_system_network_send_to;
				};
				_object setVariable ["ExileIsLocked",-1];
			};
			[_sessionID,"lockResponse",["Locked!",true, _object, _objectPinCode]] call ExileServer_system_network_send_to;
			_object enableRopeAttach false;
		};
		_object call ExileServer_system_vehicleSaveQueue_addVehicle;
	}
	else
	{
		[_sessionID,"lockResponse",["Wrong PIN Code!", false, objNull, ""]] call ExileServer_system_network_send_to;
	};
};
true