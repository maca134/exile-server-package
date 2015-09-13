/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_lootTableName","_itemClassName","_lootTableConfig","_top","_lootTableEntries","_chance"];
_lootTableName = _this;
_itemClassName = "";
_lootTableConfig = configFile >> "CfgLootTables" >> _lootTableName;
_top = getNumber(_lootTableConfig >> "top");
_lootTableEntries = getArray(_lootTableConfig >> "items");
_chance = random(_top); 
{
	if ((_x select 0) >= _chance) exitWith
	{
		_itemClassName = _x select 1;
	};
}
forEach _lootTableEntries;
_itemClassName