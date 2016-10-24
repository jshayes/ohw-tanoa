if (!isServer) exitWith {};

waitUntil {!isNil "jh_var_playerGroup"};
waitUntil {!isNil "jh_pvar_insertHelo"};

sleep 1;

// Wait until everyone is out of the helicopter
_units = units jh_var_playerGroup;
waitUntil {
    sleep 1;

    _units = [
        units jh_var_playerGroup,
        {
            vehicle _this == _this
        }
    ] call Zen_ArrayFilterCondition;

    (count _units == 0) && ((jh_pvar_insertHelo distance jh_pvar_lzPosition) > 250)
};

jh_pvar_intelTask = [
    jh_var_playerGroup,
    "Locate and upload the intel.",
    "Find intel",
    0,
    true
] call Zen_InvokeTask;

publicVariable "jh_pvar_intelTask";
