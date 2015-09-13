/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_messageName","_fields","_numberOfFields","_message","_i"];
_messageName = _this select 0;
_fields = _this select 1;
_numberOfFields = count _fields;
_message = "";
for "_i" from 0 to _numberOfFields - 1 do 
{
	_message = _message + format [":%1", _fields select _i];
};
_message = format["%1%2", _messageName, _message];
_message