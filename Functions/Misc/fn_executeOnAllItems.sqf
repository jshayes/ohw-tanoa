private _callback = _this select 0;
private _item = _this select 1;

switch (typename _item) do {
    case "ARRAY": {
        private _args = _this - [_callback];
        _args = _args - [_item];

        {
            ([_callback] + [_x] + _args) call jh_fnc_executeOnAllItems;
        } foreach _item;
    };
    case "GROUP": {
        private _args = _this - [_callback];
        _args = _args - [_item];

        {
            ([_callback] + [_x] + _args) call jh_fnc_executeOnAllItems;
        } foreach units _item;
    };
    default {
        private _args = _this - [_callback];

        _args call _callback;
    };
};
