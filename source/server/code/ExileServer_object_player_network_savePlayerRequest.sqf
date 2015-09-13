/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_parameters","_hunger","_thirst","_alcohol","_player"];
_sessionID = _this select 0;
_parameters = _this select 1;
_hunger = _parameters select 0;
_thirst = _parameters select 1;
_alcohol = _parameters select 2;
_player = _sessionID call ExileServer_system_session_getPlayerObject;
if (!isNull _player) then
{
	_player setVariable["ExileHunger", _hunger];
	_player setVariable["ExileThirst", _thirst];
	_player setVariable["ExileAlcohol", _alcohol];
	if!(_player in ExileSystemPlayerSaveASYNC)then
	{
		ExileSystemPlayerSaveASYNC pushBack _player;
	};
};
true