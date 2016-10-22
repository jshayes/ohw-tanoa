"[AO] Initializing" call jh_fnc_log;

if (!isServer) exitWith {};

call compile preprocessFileLineNumbers "AO\selectAOLocation.sqf";

sleep 1;

execVM "AO\spawnInfantryPatrols.sqf";
execVM "AO\spawnInfantryGarrison.sqf";
execVM "AO\spawnVehiclePatrols.sqf";
execVM "AO\spawnBriefCase.sqf";
