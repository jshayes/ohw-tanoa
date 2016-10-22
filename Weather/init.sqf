#define GetCloudForecast() (call af_fnc_getCloudForecast)
#define GetFogForecast() (call af_fnc_getFogForecast)
#define GetRainForecast() (call af_fnc_getRainForecast)
#define GetWindForecast() (call af_fnc_getWindForecast)
#define GetWeatherDuration() (([30, 60] call BIS_fnc_randomNum) * 60)

private ["_weatherType", "_types", "_weights"];
private ["_future", "_overcastArray", "_fogArray", "_rainArray", "_windArray", "_h", "_time"];

"[Weather] Initializing" call jh_fnc_log;

_weatherType = "Weather" call BIS_fnc_getParamValue;

_types = [
    "random",
    "clear",
    "cloudy",
    "overcast",
    "lightRain",
    "heavyRain",
    "storm"
];

_weatherType = _types select _weatherType;

["[Weather] Selected weather type: %1", _weatherType] call jh_fnc_log;

if (_weatherType == "random") then {
    _types = _types - ["random"];
    _weights = [1, 1, 0.5, 0.5, 0.5, 0.5];
    _weatherType = [_types, _weights] call BIS_fnc_selectRandomWeighted;
};

["[Weather] Weather set to: %1", _weatherType] call jh_fnc_log;
call compile preprocessFileLineNumbers format ["Weather\Strategies\%1.sqf", _weatherType];

_future = GetWeatherDuration();
_overcastArray = ["overcast", GetCloudForecast(), GetCloudForecast(), _future];
_fogArray = ["fog", GetFogForecast(), GetFogForecast(), _future];
_rainArray = ["rain", GetRainForecast(), GetRainForecast(), _future];
_windArray = ["wind", GetWindForecast(), GetWindForecast(), _future];

_h = [
    _overcastArray,
    _fogArray,
    _rainArray,
    _windArray
] spawn Zen_SetWeather;

waitUntil {scriptDone _h;};

skipTime 1;
sleep 0.1;
skipTime -1;

while {true} do {
    _future = GetWeatherDuration();
    _time = daytime;

    [
        "[Weather] Weather forcast set at: %1. Next update at: %2", 
        [_time, "HH:MM"] call BIS_fnc_timeToString,
        [(_time + (_future / 3600)) mod 24, "HH:MM"] call BIS_fnc_timeToString
    ] call jh_fnc_log;

    _overcastArray = ["overcast", -1, GetCloudForecast(), _future];
    _fogArray = ["fog", -1, GetFogForecast(), _future];
    _rainArray = ["rain", -1, GetRainForecast(), _future];
    _windArray = ["wind", -1, GetWindForecast(), _future];

    [
        _overcastArray,
        _fogArray,
        _rainArray,
        _windArray
    ] spawn Zen_SetWeather;

    waitUntil {_time + (_future / 3600) <= daytime};
};
