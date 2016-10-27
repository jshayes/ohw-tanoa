#include "defines.hpp"

// Spawn town garrisoned units
private _nearBuilding = nearestBuilding (jh_pvar_aoPosition);
private _housesArray = nearestTerrainObjects[getPosATL _nearBuilding, ["Building", "House"], 300, false];

private _groups = [];
private _unitCount = 0;

for "_i" from 0 to 6 do {
    _house = _housesArray call BIS_fnc_selectRandom;
    _housesArray = _housesArray - [_house];

    _group = [
        getPosATL _house,
        east,
        ENEMY_SKILL,
        [2, 3],
        "Men",
        "OPF_T_F",
        ENEMY_CLASSES,
        "Expansion"
    ] call ZEN_SpawnInfantry;

    [
        _group,
        getPos leader _group,
        true,
        'aware',
        1
    ] spawn Zen_OrderInfantryPatrolBuilding;

    _groups pushBack _group;
    _unitCount = _unitCount + (count units _group);
};

_groups call jh_fnc_removeFirstAidKits;

["[AO] %1 town garrison units spawned.", _unitCount] call jh_fnc_log;
[_groups, "ColorGreen", "hd_dot"] call jh_fnc_debugTrack;
