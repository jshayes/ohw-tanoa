private _trackItem = {
    private _removeHealthPacks = {
        _this removeItem "FirstAidKit";
        _this removeItem "Medikit";
    };

    private _item = _this select 0;
    _item call _removeHealthPacks;

    if (!(_item isKindOf "Man")) then {
        clearItemCargoGlobal _item;

        {
            _x call _removeHealthPacks;
        } foreach crew _item;
    };
};

([_trackItem] + [_this]) call jh_fnc_executeOnAllItems;
