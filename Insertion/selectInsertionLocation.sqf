private _aoPos = jh_pvar_aoPosition;
private _lzPos = [];

private _fnc_checkPosition = _this;
private _callback = {
    _lzPos = _this call _fnc_checkPosition;
    count _lzPos > 0
};

[
    _callback,
    _aoPos,
    [4000, 10000],
    random 360,
    50
] call jh_fnc_radialScan;

createMarker ["mkrLZ", _lzPos];
jh_pvar_lzPosition = _lzPos;
publicVariable "jh_pvar_lzPosition";

[
    "[Insertion] Selected LZ location: %1. LZ is %2m away from the AO.",
    mapGridPosition _lzPos,
    _aoPos distance _lzPos
] call jh_fnc_log;
