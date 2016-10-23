private _aoPos = jh_pvar_aoPosition;
private _lzPos = jh_pvar_lzPosition;
private _dir = _aoPos getDir _lzPos;

jh_pvar_insertHelo lock true;
[jh_pvar_insertHelo, _lzPos] call Zen_OrderVehicleMove;

sleep 5;

[jh_pvar_insertHelo, units group jh_player1] call Zen_OrderFastRope;

sleep 5;

_heloDestinationPos = [_lzPos, 10000, _dir] call Zen_ExtendPosition;

[jh_pvar_insertHelo, _heloDestinationPos] call Zen_OrderVehicleMove;
