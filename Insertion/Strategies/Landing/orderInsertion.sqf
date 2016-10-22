private _aoPos = jh_pvar_aoPosition;
private _lzPos = jh_pvar_lzPosition;
private _dir = _aoPos getDir _lzPos;

private _heloDestinationPos = [
    (_aoPos select 0) + 10000 * (sin _dir), 
    (_aoPos select 1) + 10000 * (cos _dir)
];

[
    jh_pvar_insertHelo,
    [_lzPos, _heloDestinationPos],
    units group jh_player1
] spawn Zen_OrderInsertion;
