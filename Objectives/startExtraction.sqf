private _landingPosition = [];

private _fnc_checkPosition = {
    _landingPosition = _this isFlatEmpty [10, -1, 0.5, 5, 0, false];
    count _landingPosition > 0
};

"[Extraction] Initializing" call jh_fnc_log;

// Look for a nearby landing zone
[
    _fnc_checkPosition,
    getPos player,
    [0, 100],
    random 360,
    50
] call jh_fnc_radialScan;

if (count _landingPosition == 0) exitWith {
    {[west, "BLU"] sideChat "Cannot find a landing zone!";} remoteExec ["bis_fnc_call", 0];
};

["[Extraction] Landing zone found at: %1", _landingPosition call BIS_fnc_PosToGrid] call jh_fnc_log;
deleteVehicle _this;

{[west, "BLU"] sideChat "Found a landing zone!";} remoteExec ["bis_fnc_call", 0];

// Find the starting location for the extraction chopper
private _dir = jh_pvar_aoPosition getDir _landingPosition;
private _heloStartPos = [_landingPosition, 4000, _dir] call Zen_ExtendPosition;

_helo = [
    _heloStartPos,
    ["B_Heli_Transport_01_camo_F"]
] call Zen_SpawnHelicopter;

["[Extraction] Helicopter created at", _heloStartPos call BIS_fnc_PosToGrid] call jh_fnc_log;
[_helo, "ColorGreen", "mil_triangle"] call jh_fnc_debugTrack;

[_helo, [_landingPosition, _heloStartPos], group player] spawn Zen_OrderExtraction;

// Wait until all players are in the extraction chopper
waitUntil {
    _units = [
        units group player,
        {
            vehicle _this == _helo
        }
    ] call Zen_ArrayFilterCondition;

    count _units == 0
};

"[Extraction] Successful" call jh_fnc_log;
[jh_pvar_extractTask, 'succeeded'] call Zen_UpdateTask;

waitUntil {player distance _landingPosition > 1000};

"EveryoneWon" call BIS_fnc_endMissionServer
