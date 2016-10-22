if (!isServer) exitWith {};

waitUntil {!isNil "jh_pvar_lzPosition"};

private _road = objNull;
private _checkPosition = {
    _road = roadAt _this;
    !isNull _road
};

[
    _checkPosition,
    jh_pvar_lzPosition,
    [200, 1000],
    random 360,
    25
] call jh_fnc_radialScan;

private _roadDir = _road call jh_fnc_getRoadDirection;
private _roadPos = getPos _road;

jh_pvar_vehicleStartPosition = [
    (_roadPos select 0) + 6 * sin (_roadDir + 90),
    (_roadPos select 1) + 6 * cos (_roadDir + 90)
];
publicVariable "jh_pvar_vehicleStartPosition";

private _vehiclePos = jh_pvar_vehicleStartPosition;
for "_i" from 0 to 1 do {
    _vehicleDir = _roadDir - 10 + random 5;
    _vehiclePos = [
        (_vehiclePos select 0) + 15 * sin (_roadDir) * _i,
        (_vehiclePos select 1) + 15 * cos (_roadDir) * _i
    ];
    _vehicle = [_vehiclePos, "B_MRAP_01_hmg_F", 0, _vehicleDir] call Zen_SpawnVehicle;
};

[
    "[Insertion] Vehicles placed at %1, which is %2m to the %3 of the LZ",
    mapGridPosition jh_pvar_vehicleStartPosition,
    jh_pvar_lzPosition distance jh_pvar_vehicleStartPosition,
    (jh_pvar_lzPosition getDir jh_pvar_vehicleStartPosition) call jh_fnc_getCardinalDirection
] call jh_fnc_log;

"B_supplyCrate_F"
