// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_FrameworkLibrary.sqf"
#include "..\Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_UnlinkControl", _this] call Zen_StackAdd;
private ["_dialogID", "_index", "_dialogData", "_controlArray", "_controlID"];

if !([_this, [["STRING"], ["STRING"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_dialogID = _this select 0;
_controlID = _this select 1;

_index = [Zen_Dialog_Classes_Global, _dialogID, 0] call Zen_ArrayGetNestedIndex;
if (count _index == 0) exitWith {
    ZEN_FMW_Code_ErrorExitValue("Zen_UnlinkControl", "Invalid dialog class given")
};

_index = _index select 0;
_dialogData = Zen_Dialog_Classes_Global select _index;
_controlArray = _dialogData select 1;

0 = [_controlArray, _controlID] call Zen_ArrayRemoveValue;

call Zen_StackRemove;
if (true) exitWith {};
