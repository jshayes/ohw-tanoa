// Select the AO location
private _size = worldSize;
private _worldCenter = (_size/2);
while {true} do {
    _locations = nearestLocations [[_worldCenter, _worldCenter], ["NameVillage", "NameCity"], _size];
    _location = _locations call BIS_fnc_selectRandom;
    _housesArray = nearestTerrainObjects [getPos _location, ["Building", "House"], 100, false];
    if (count _housesArray > 10) exitWith {jh_pvar_aoLocation = _location;};
};

jh_pvar_aoPosition = getPos jh_pvar_aoLocation;
publicVariable "jh_pvar_aoLocation";
publicVariable "jh_pvar_aoPosition";

createMarker ["mkrAO", jh_pvar_aoPosition];

["[AO] Selected AO location: %1", text jh_pvar_aoLocation] call jh_fnc_log;
