#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

jh_var_debug = false;
jh_var_markerDebug = false;
Zen_Debug_Arguments = false;
Zen_Print_All_Errors = false;
tf_no_auto_long_range_radio = true;

enableSaving [false, false];

// <Your mission name here> by <your name here>
// Version = <the date here>
// Tested with ArmA 3 <version number>

"blackScreen" cutText ["", "BLACK FADED", 0, true];
_soundVolume = soundVolume;
0 fadeSound 0;

execVM "briefing.sqf";

if (isServer) then {
    jh_var_playerGroup = group jh_player_SL;
    execVM "Loadouts\init.sqf";
    execVM "AO\init.sqf";
    execVM "Insertion\init.sqf";
    execVM "placeVehicles.sqf";
    execVM "Daytime\init.sqf";
    execVM "Weather\init.sqf";
};

sleep 1;

execVM "Objectives\init.sqf";

if (isDedicated) exitWith {};

sleep 5;

"blackScreen" cutFadeout 5;
5 fadeSound _soundVolume;
