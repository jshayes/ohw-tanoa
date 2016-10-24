waitUntil {!isNil "jh_pvar_suitcase"};

jh_fnc_intel = {
    params
    [
        ["_suitcase", objNull, [objNull]]
    ];

    // No valid unit or required key is not pressed
    if (isNull _suitcase) exitWith {false};

    // Check distance
    if (player distance _suitcase > 2) exitWith {false};

    // Check validity of player
    if (vehicle player != player) exitWith {false};

    // Check life state
    if (lifeState _suitcase == "INCAPACITATED") exitWith {false};

    // Make sure you are looking at the suitcase
    if (cursorTarget != _suitcase) exitWith {false};

    true
};

private _title = "Gather Intel";
private _iconIdle = "\A3\3DEN\data\CfgWaypoints\unload_ca.paa";
private _iconProgress = _iconIdle;
private _condShow = "[_target] call jh_fnc_intel";
private _condProgress = _condShow;
private _codeStart = {};
private _codeProgress = {};
private _codeCompleted =
{
    [jh_pvar_intelTask, 'succeeded'] call Zen_UpdateTask;

    jh_pvar_extractTask = [
        group player,
        "Secure an LZ for extraction, then radio in your coordinates.",
        "Extract",
        0,
        true
    ] call Zen_InvokeTask;
    publicVariable "jh_pvar_extractTask";

    _trg = createTrigger ["EmptyDetector", getPos player];
    _trg setTriggerArea [5, 5, 0, false];
    _trg setTriggerActivation ["ALPHA", "PRESENT", true];
    _trg setTriggerStatements ["this", "thisTrigger execVM 'Objectives\startExtraction.sqf'", ""];
};
private _codeInterrupted = {};
private _arguments = [];
private _duration = 30;
private _priority = 1000;

private _actionID = [
    jh_pvar_suitcase,
    _title,
    _iconIdle,
    _iconProgress,
    _condShow,
    _condProgress,
    _codeStart,
    _codeProgress,
    _codeCompleted,
    _codeInterrupted,
    _arguments,
    _duration,
    _priority
] call BIS_fnc_holdActionAdd;
