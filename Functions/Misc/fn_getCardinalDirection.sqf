private _index = floor ((_this + 22.5) / 45);
_index = _index max 0;
_index = _index min 8;

_direction = ["North", "North East", "East", "South East", "South", "South West", "West", "North West"] select _index;

["Cardinal direction for %1 is %2.", _this, _direction] call jh_fnc_log;

_direction
