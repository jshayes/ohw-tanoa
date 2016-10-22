private _callback = param [0];
private _position = param [1];
private _range = param [2];
private _startAngle = param [3, 0, [0]];
private _distanceStep = param [4, 50, [0]];

private _minDistance = _range select 0;
private _maxDistance = _range select 1;

private _distance = _minDistance;
while {_distance < _maxDistance} do {
    _dir = 0;
    _angle = acos ((2 * (_distance ^ 2) - _distanceStep ^ 2) / (2 * _distance ^ 2));

    while {_dir < (360 - _angle)} do {
        _dir = _dir + _angle;
        _pos = [_position, _distance, _dir + _startAngle] call Zen_ExtendPosition;

        _pos call _callback;
    };

    _distance = _distance + _distanceStep;
};
