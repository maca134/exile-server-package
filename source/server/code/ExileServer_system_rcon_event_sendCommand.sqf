/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_command","_password","_return"];
_command = _this;
_password = getText(configFile >> "CfgSettings" >> "RCON" >> "serverPassword");
_return = _password serverCommand _command;
_return