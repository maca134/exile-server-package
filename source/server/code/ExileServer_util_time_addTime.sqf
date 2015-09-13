/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_time1","_time2","_time"];
_time1 = _this select 0;
_time2 = _this select 1;
_time1 = _time1 call ExileServer_util_time_toMinutes;
_time2 = _time2 call ExileServer_util_time_toMinutes;
_time = _time1 + _time2;
_time