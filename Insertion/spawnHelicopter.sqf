private _aoPos = jh_pvar_aoPosition;
private _lzPos = jh_pvar_lzPosition;
private _dir = _aoPos getDir _lzPos;

private _heloStartPos = [_aoPos, 7000, _dir] call Zen_ExtendPosition;

jh_pvar_insertHelo = [
    _heloStartPos,
    ["B_Heli_Transport_01_camo_F"]
] call Zen_SpawnHelicopter;

publicVariable "jh_pvar_insertHelo";

jh_pvar_insertHelo call jh_fnc_removeFirstAidKits;

[jh_var_playerGroup, jh_pvar_insertHelo] call Zen_MoveInVehicle;
