/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_currentTimestamp","_time","_maintenancePeriod","_maintenancePeriodMinutes","_deleted","_flag","_timePayed","_timePayedMinutes","_nukeTime"];
"Running maintenance!" call ExileServer_util_log;
_currentTimestamp = call ExileServer_util_time_currentTime;
_time = _currentTimestamp call ExileServer_util_time_toMinutes;
_maintenancePeriod = getNumber(missionConfigFile >> "CfgTerritories" >> "protectionPeriod");
_maintenancePeriodMinutes = _maintenancePeriod * 1440;
_deleted = 0;
{
	_flag = _x;
	_timePayed = _flag getVariable ["ExileTerritoryLastPayed", _currentTimestamp];
	_timePayedMinutes = _timePayed call ExileServer_util_time_toMinutes;
	_nukeTime = _timePayedMinutes + _maintenancePeriodMinutes;
	if(_time > _nukeTime)then
	{
		_flag call ExileServer_system_territory_maintenance_kill;
		_deleted = _deleted + 1;
	}
	else
	{
		_flag setVariable ["ExileTerritoryMaintenanceDue",_nukeTime call ExileServer_util_time_toArma,true];
	};
}
forEach allMissionObjects "Exile_Construction_Flag_Static";
format ["Maintenance done. %1 territories deleted.",_deleted] call ExileServer_util_log;
true