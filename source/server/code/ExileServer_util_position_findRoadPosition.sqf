/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_position","_radius","_roads","_numberOfRoads","_road","_position2d"];
_position = _this select 0;
_radius = _this select 1;
_roads = _position nearRoads _radius;
_numberOfRoads = count _roads;
if (_numberOfRoads > 0) then
{
    _road = _roads select floor(random _numberOfRoads); 
    _position = getPos _road;
    _radius = 50;
};
_position2d = 
[
    _position,          
    0,                  
    _radius,            
    5,                  
    0,                  
    99999,              
    0                   
]
call BIS_fnc_findSafePos;
_position = [_position2d select 0, _position2d select 1, 0];
_position