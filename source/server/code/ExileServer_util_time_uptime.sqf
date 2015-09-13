/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_startTime","_currentTime","_startMinute","_currentMinute","_uptimeMinutes"];
_startTime = ExileServerStartTime;
_currentTime = call ExileServer_util_time_currentTime;
_startMinute = ((_startTime select 3) * 60) + (_startTime select 4);
_currentMinute  =((_currentTime select 3) * 60) + (_currentTime select 4);
_uptimeMinutes = _currentMinute - _startMinute;
_uptimeMinutes