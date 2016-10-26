private _vehicles = [];
for "_i" from 0 to 2 do {
    _pos = [
        "mkrAO",
        [0, 2500]
    ] call Zen_FindGroundPosition;

    _roads = _pos nearRoads 400;

    if (count _roads > 0) then {
        _pos = getPos (_roads select 0);
    };

    _vehicle = [
        _pos,
        ["I_MRAP_03_hmg_F"]
    ] call ZEN_SpawnGroundVehicle;

    _vehicles pushBack _vehicle;
};

[
    _vehicles,
    jh_pvar_aoPosition,
    2500
] spawn Zen_OrderVehiclePatrol;

["[AO] %1 light armoured vehicles spawned.", count _vehicles] call jh_fnc_log;
[_vehicles, "ColorGreen", "mil_box"] call jh_fnc_debugTrack;

// Spawn Helicopter
_vehicle = [
    jh_pvar_aoPosition,
    ["I_Heli_light_03_F"]
] call Zen_SpawnHelicopter;

// Give the helicopter two rounds of flares
_vehicle removeMagazinesTurret ["168Rnd_CMFlare_Chaff_Magazine", [-1]];
_vehicle addMagazineTurret ["168Rnd_CMFlare_Chaff_Magazine", [-1], 48]

[
    [_vehicle],
    jh_pvar_aoPosition,
    3000
] spawn Zen_OrderAircraftPatrol;

"[AO] 1 helicopter spawned" call jh_fnc_log;
[_vehicle, "ColorRed", "mil_triangle"] call jh_fnc_debugTrack;
