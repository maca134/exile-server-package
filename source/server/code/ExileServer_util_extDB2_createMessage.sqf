/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_messageName","_fields","_message"];
_messageName = _this select 0;
_fields = _this select 1;
_message = "";
_message = _fields joinString ":";
_message = [_messageName,_message] joinString ":";
_message