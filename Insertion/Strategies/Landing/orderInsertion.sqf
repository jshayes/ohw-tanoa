private _aoPos = jh_pvar_aoPosition;
private _lzPos = jh_pvar_lzPosition;
private _dir = _aoPos getDir _lzPos;

private _heloDestinationPos = [_lzPos, 10000, _dir] call Zen_ExtendPosition;

[
    jh_pvar_insertHelo,
    [_lzPos, _heloDestinationPos],
    units group jh_player_SL
] call Zen_OrderInsertion;
