#define LogTimeSelection(_time) (["[Daytime] Selected time: %1", _time] call jh_fnc_log)

"[Daytime] Initializing" call jh_fnc_log;

private _year = date select 0;
private _month = [1, 12] call BIS_fnc_randomInt;
private _day = [1, 28] call BIS_fnc_randomInt;

private _dawnDusk = date call BIS_fnc_sunriseSunsetTime;

private _dawnNum = _dawnDusk select 0;
private _duskNum = _dawnDusk select 1;

private _timeOfDay = "Daytime" call BIS_fnc_getParamValue;
private _daytime = 0;
switch (_timeOfDay) do {
    case 0: {
        LogTimeSelection("random");
        _daytime = random 24;
    };
    case 1: {
        LogTimeSelection("dawn");
        _daytime = _dawnNum;        
    };
    case 2: {
        LogTimeSelection("morning");
        _daytime = ([_dawnNum + 2, 12] call BIS_fnc_randomNum);     
        
    };
    case 3: {
        LogTimeSelection("afternoon");
        _daytime = ([12, _duskNum - 2] call BIS_fnc_randomNum);     
        
    };
    case 4: {
        LogTimeSelection("dusk");
        _daytime = _duskNum;        
    };
    case 5: {
        LogTimeSelection("night");
        _nightTime1 = [(_duskNum + 2), 24] call BIS_fnc_randomNum;
        _nightTime2 = [0, (_dawnNum - 2)] call BIS_fnc_randomNum;
        _daytime = (selectRandom [_nightTime1, _nightTime2]);       
    };
};

private _hours = floor(_daytime);
private _minutes = floor((_daytime - _hours) * 60);
setDate [_year, _month, _day, _hours, _minutes];

private _time = [dayTime, "HH:MM"] call BIS_fnc_timeToString;
["[Daytime] The date is: %1-%2-%3 %4", (date select 0), (date select 1), (date select 2), _time] call jh_fnc_log;
