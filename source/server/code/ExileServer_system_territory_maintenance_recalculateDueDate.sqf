/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_flag","_currentTimestamp","_timePayed","_timePayedMinutes","_maintenancePeriod","_maintenancePeriodMinutes","_nukeTime"];
_flag = _this;
_currentTimestamp = call ExileServer_util_time_currentTime;
_timePayed = _flag getVariable ["ExileTerritoryLastPayed", _currentTimestamp];
_timePayedMinutes = _timePayed call ExileServer_util_time_toMinutes;
_maintenancePeriod = getNumber(missionConfigFile >> "CfgTerritories" >> "protectionPeriod");
_maintenancePeriodMinutes = _maintenancePeriod * 1440;
_nukeTime = _timePayedMinutes + _maintenancePeriodMinutes;
_flag setVariable ["ExileTerritoryMaintenanceDue", _nukeTime call ExileServer_util_time_toArma, true];