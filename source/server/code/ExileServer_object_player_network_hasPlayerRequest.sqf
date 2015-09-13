/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_player","_hasAlivePlayer"];
_sessionID = _this select 0;
_player = _sessionID call ExileServer_system_session_getPlayerObject;
_uid = getPlayerUID _player;
_hasAlivePlayer = format["hasAlivePlayer:%1", _uid] call ExileServer_system_database_query_selectSingleField;
[_sessionID, "hasPlayerResponse", [_hasAlivePlayer]] call ExileServer_system_network_send_to;
true