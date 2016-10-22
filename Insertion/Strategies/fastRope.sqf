jh_fnc_selectInsertionLocation = {
    _fnc_checkPosition = {
        _this isFlatEmpty [10, -1, -1, -1, 0]
    };

    _fnc_checkPosition call compile preprocessFileLineNumbers "Insertion\selectInsertionLocation.sqf"
};

jh_fnc_orderInsertion = compileFinal preprocessFileLineNumbers "Insertion\Strategies\FastRope\orderInsertion.sqf";
