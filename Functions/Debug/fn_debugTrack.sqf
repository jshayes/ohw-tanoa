if (jh_var_markerDebug) then {
    if (isNil "jh_var_markerDebugHandle") then {
        jh_var_markerDebugUnits = [];

        jh_var_markerDebugHandle = [] spawn {
            while {true} do {
                {
                    _object = _x select 0;
                    _colour = _x select 1;
                    _type = _x select 2;

                    _mkrName = format ['mkr%1', _object call BIS_fnc_netId];

                    if (getMarkerType _mkrName == "") then {
                        createMarker [_mkrName, getPos _object];
                        _mkrName setMarkerType _type;
                        _mkrName setMarkerColor _colour;
                    };

                    _mkrName setMarkerPos (getPos _object);

                } foreach jh_var_markerDebugUnits;

                sleep 2;
            }; 
        };
    };

    private _trackItem = {
        jh_var_markerDebugUnits pushBack _this;
    };

    ([_trackItem] + _this) call jh_fnc_executeOnAllItems;
};
