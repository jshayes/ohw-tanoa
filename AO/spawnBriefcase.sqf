private _housesArray = nearestTerrainObjects[jh_pvar_aoPosition, ["Building", "House"], 300, false];

while {true} do {
    _house = _housesArray call BIS_fnc_selectRandom;
    _housePositions = [_house] call BIS_fnc_buildingPositions;
    //Land_Suitcase_F
    if (count _housePositions > 0) exitWith {
        _position = _housePositions call BIS_fnc_selectRandom;
        _mkrName = 'mkrIntel';
        createMarker [_mkrName, getPos _house];
        _mkrName setMarkerType "hd_objective";
        _mkrName setMarkerColor 'ColorGreen';
    };
};
