if (!isServer) exitWith {};

waitUntil {!isNil "jh_var_playerGroup"};
waitUntil {!isNil "jh_pvar_insertHelo"};

sleep 1;

// Wait until everyone is out of the helicopter
_units = units jh_var_playerGroup;
waitUntil {
    sleep 1;

    {
        if (vehicle _x == _x) then {
            _units = _units - [_x];
        };
    } foreach _units;

    (count _units == 0) && ((jh_pvar_insertHelo distance jh_pvar_lzPosition) > 100)
};

jh_pvar_intelTask = [
    jh_var_playerGroup,
    "Locate and upload the intel.",
    "Find intel",
    0,
    true
] call Zen_InvokeTask;

publicVariable "jh_pvar_intelTask";
