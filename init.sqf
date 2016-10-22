#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

jh_var_debug = true;
jh_var_markerDebug = true;
Zen_Debug_Arguments = true;
Zen_Print_All_Errors = true;

enableSaving [false, false];

diag_log __FILE__;

// <Your mission name here> by <your name here>
// Version = <the date here>
// Tested with ArmA 3 <version number>

"blackScreen" cutText ["", "BLACK FADED", 0, true];
_soundVolume = soundVolume;
0 fadeSound 0;

execVM "briefing.sqf";

if (isServer) then {
    execVM "AO\init.sqf";
    execVM "Insertion\init.sqf";
    execVM "placeVehicles.sqf";
    execVM "Daytime\init.sqf";
    execVM "Weather\init.sqf";
};

sleep 1;

waitUntil {!isNil "jh_pvar_insertHelo"};

sleep 1;

player moveInCargo jh_pvar_insertHelo;

sleep 5;

"blackScreen" cutFadeout 5;
5 fadeSound _soundVolume;
