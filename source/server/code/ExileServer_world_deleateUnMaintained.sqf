/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_countbefore","_baseExpire","_countafter"];
"Removing unmaintained constructions" call ExileServer_util_log;
_countbefore = "countConstruction" call ExileServer_system_database_query_selectSingleField;
_baseExpire = getNumber(missionConfigFile >> "CfgTerritories" >> "protectionPeriod");
format ["deleateUnMaintainedConstruction:%1",_baseExpire]  call ExileServer_system_database_query_selectFull;
_countafter = "countConstruction" call ExileServer_system_database_query_selectSingleField;
format ["Removed %1 unmaintained constructions",_countbefore - _countafter] call ExileServer_util_log;
"Unmaintained constructions Removed!" call ExileServer_util_log;
true