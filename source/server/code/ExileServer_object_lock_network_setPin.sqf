/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_paramaters","_object","_pincode","_newPinCode","_objectPinCode"];
_sessionID = _this select 0;
_paramaters = _this select 1;
_object = objectFromNetId (_paramaters select 0);
_pincode = _paramaters select 1;
_newPinCode = _paramaters select 2;
_objectPinCode = _object getVariable ["ExileAccessCode","000000"];
if(_pincode isEqualTo _objectPinCode)then
{
	_object setVariable ["ExileAccessCode",_newPinCode];
	[_sessionID,"setPinResponse",[["Success",[format ["New pin set to: %1",_newPinCode]]],_object,_newPinCode]] call ExileServer_system_network_send_to;
	[_object,_newPinCode] call ExileServer_object_container_database_setpin;
}
else
{
	[_sessionID, "setPinResponse", [["Whoops", ["Wrong pin code!"]],objNull,""]] call ExileServer_system_network_send_to;
};
true