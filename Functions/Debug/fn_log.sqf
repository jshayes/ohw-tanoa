if (jh_var_debug) then {
    if (typeName _this == "STRING") then {
        _this = ["%1", _this];
    };

    diag_log (format ["[Debug]: %1", format _this]);
};
