/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_recipient","_messageName","_messageParameters","_player","_publicMessage"];
_recipient = _this select 0;
_messageName = _this select 1;
_messageParameters = _this select 2;
if (typeName _recipient == "STRING") then 
{
	_player = _recipient call ExileServer_system_session_getPlayerObject;
}
else 
{
	_player = _recipient;
};
_publicMessage = [_messageName, _messageParameters];
if(typeName _player isEqualTo "SCALAR")then
{
	_publicMessage remoteExecCall ["ExileClient_system_network_dispatchIncomingMessage",_player];
}
else
{
	_publicMessage remoteExecCall ["ExileClient_system_network_dispatchIncomingMessage",owner _player];
};
_publicMessage = nil;