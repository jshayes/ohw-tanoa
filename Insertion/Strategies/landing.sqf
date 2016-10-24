jh_fnc_selectInsertionLocation = {
    _fnc_checkPosition = {
        _this isFlatEmpty [10, -1, 0.5, 5, 0, false]
    };

    _fnc_checkPosition call compile preprocessFileLineNumbers "Insertion\selectInsertionLocation.sqf"
};

jh_fnc_orderInsertion = compileFinal preprocessFileLineNumbers "Insertion\Strategies\Landing\orderInsertion.sqf"
