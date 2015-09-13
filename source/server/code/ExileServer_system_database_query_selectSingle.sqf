/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_parameters","_query","_result"];
_parameters = _this;
_query = format["%1:%2:%3", 0, ExileServerDatabaseSessionId, _parameters];
_result = call compile ("extDB2" callExtension _query);
(_result select 1) select 0