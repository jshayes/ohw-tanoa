#include "heavyRain.sqf";

af_fnc_getCloudForecast = {
    random 0.1 + 0.9
};

af_fnc_getFogForecast = {
    random 0.1 + 0.05
};

af_fnc_getRainForecast = {
    random 0.5 + 0.5
};

af_fnc_getWindForecast = {
    random 5 + 5
};
