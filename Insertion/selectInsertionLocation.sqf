private _aoPos = jh_pvar_aoPosition;
private _lzPos = [];
private _dir = 0;
private _distance = 4000;

private _fnc_checkPosition = _this;

while {true} do {
    _dir = random 360;
    _found = false;
    for "_i" from 0 to 360 step 10 do {
        _dir = _dir + _i;
        _pos = [_aoPos, _distance, _dir] call Zen_ExtendPosition;

        _lzPos = _pos call _fnc_checkPosition;
        if (count _lzPos > 0) exitWith {_found = true};
    };

    if (_found) exitWith {};

    _distance = _distance + 500;

    [
        "[Insertion] Failed to find a valid insertion point. Expanding search radius to %1m.",
        _distance
    ] call jh_fnc_log;
};

createMarker ["mkrLZ", _lzPos];
jh_pvar_lzPosition = _lzPos;
publicVariable "jh_pvar_lzPosition";

[
    "[Insertion] Selected LZ location: %1. LZ is %2m away from the AO.",
    mapGridPosition _lzPos,
    _aoPos distance _lzPos
] call jh_fnc_log;
