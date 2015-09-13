/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_spawnedLootForPlayers","_spawnRadius","_notifyPlayer","_player","_time","_spawnedLoot","_playersInformed"];
_spawnedLootForPlayers = [];
_spawnRadius = getNumber (configFile >> "CfgSettings" >> "LootSettings" >> "spawnRadius");
_notifyPlayer = (getNumber (configFile >> "CfgSettings" >> "LootSettings" >> "notifyPlayer")) isEqualTo 1;
{
	_player = _x;
	_time = _player getVariable ["ExileLastLootSpawnTime", 0];
	if (_time + 60 < time) then
	{
		_spawnedLoot = _player call ExileServer_system_lootManager_spawnLootForPlayer;
		_player setVariable["ExileLastLootSpawnTime", time];
		if (_notifyPlayer) then
		{
			if (_spawnedLoot) then
			{
				_spawnedLootForPlayers pushBack _player;
			};
		};
	};
}
forEach allPlayers;
if (_notifyPlayer) then
{
	_playersInformed = [];
	{
		{
			if !(_x in _playersInformed) then
			{
				[_x, "notificationRequest", ["Success", ["Loot spawned in your area!"]]] call ExileServer_system_network_send_to;
				_playersInformed pushBack _x;
			};
		}
		forEach ([getPosATL _x, _spawnRadius] call ExileClient_util_world_getNearbyPlayers);
	}
	forEach _spawnedLootForPlayers;
};
true