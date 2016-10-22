#define LogTimeSelection(_method) (["[Insertion] Selected insertion method: %1", _method] call jh_fnc_log)

if (!isServer) exitWith {};

"[Insertion] Initializing" call jh_fnc_log;

waitUntil {!isNil "jh_pvar_aoLocation"};

private _insertionMethod = "Insertion" call BIS_fnc_getParamValue;
switch (_insertionMethod) do {
    case 0: {
        LogTimeSelection("Helicopter Landing");
        call compile preprocessFileLineNumbers "Insertion\Strategies\landing.sqf";
    };
    case 1: {
        LogTimeSelection("Helicopter Fast Rope");
        call compile preprocessFileLineNumbers "Insertion\Strategies\fastRope.sqf";
    };
};

call jh_fnc_selectInsertionLocation;

// Wait until mission start
sleep 1;

call compile preprocessFileLineNumbers "Insertion\spawnHelicopter.sqf";

call jh_fnc_orderInsertion;
