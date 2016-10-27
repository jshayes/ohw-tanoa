#include "defines.hpp"

// Spawn Distant infantry patrols
private _groups = [];
private _unitCount = 0;

for "_i" from 0 to 9 do {
    _pos = [
        "mkrAO",
        [200, 1500]
    ] call Zen_FindGroundPosition;

    _group = [
        _pos,
        east,
        ENEMY_SKILL,
        [3, 5],
        "Men",
        "OPF_T_F",
        ENEMY_CLASSES,
        "Expansion"
    ] call ZEN_SpawnInfantry;

    _groups pushBack _group;
    _unitCount = _unitCount + (count units _group);
};

_groups call jh_fnc_removeFirstAidKits;

[
    _groups,
    jh_pvar_aoPosition,
    [200, 1500]
] spawn Zen_OrderInfantryPatrol;

["[AO] %1 area patrol units spawned.", _unitCount] call jh_fnc_log;
[_groups, "ColorRed", "hd_dot"] call jh_fnc_debugTrack;

// Spawn town infantry patrols
_groups = [];
_unitCount = 0;

for "_i" from 0 to 6 do {
    _pos = [
        "mkrAO",
        [0, 400]
    ] call Zen_FindGroundPosition;

    _group = [
        _pos,
        east,
        ENEMY_SKILL,
        [2, 3],
        "Men",
        "OPF_T_F",
        ENEMY_CLASSES,
        "Expansion"
    ] call ZEN_SpawnInfantry;

    _groups pushBack _group;
    _unitCount = _unitCount + (count units _group);
};

_groups call jh_fnc_removeFirstAidKits;

[
    _groups,
    jh_pvar_aoPosition,
    [0, 250]
] spawn Zen_OrderInfantryPatrol;

["[AO] %1 town patrol units spawned.", _unitCount] call jh_fnc_log;
[_groups, "ColorYellow", "hd_dot"] call jh_fnc_debugTrack;
