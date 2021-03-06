// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_FrameworkLibrary.sqf"
#include "..\Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_UpdateTask", _this] call Zen_StackAdd;
private ["_nameString", "_taskState", "_destination", "_descriptionLong", "_descriptionShort", "_taskArrayNew", "_taskArrayOld", "_childTasks", "_parentTask", "_childTasksComplete", "_childTaskState", "_showNotification", "_completeParentChild", "_childTasksOld", "_taskIcon"];

if !([_this, [["STRING"], ["SCALAR", "STRING"], ["VOID"], ["SCALAR", "STRING"], ["SCALAR", "STRING"], ["BOOL"], ["BOOL"], ["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;

ZEN_STD_Parse_GetArgumentDefault(_taskState, 1, 0)
ZEN_STD_Parse_GetArgumentDefault(_destination, 2, 0)
ZEN_STD_Parse_GetArgumentDefault(_descriptionLong, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_descriptionShort, 4, 0)
ZEN_STD_Parse_GetArgumentDefault(_completeParentChild, 5, false)
ZEN_STD_Parse_GetArgumentDefault(_showNotification, 6, true)
ZEN_STD_Parse_GetArgumentDefault(_taskIcon, 7, "default")
// ZEN_STD_Parse_GetArgumentDefault(_childTasks, 8, [])

_childTasks = [];
if (count _this > 8) then {
    _childTasks = [(_this select 8)];
};

_taskArrayOld = [_nameString] call Zen_GetTaskDataGlobal;

if (count _taskArrayOld == 0) exitWith {
    0 = ["Zen_UpdateTask", "Given task does not exist", _this] call Zen_PrintError;
    call Zen_StackPrint;
    call Zen_StackRemove;
};

if ((typeName _taskState) == "SCALAR") then {_taskState = (_taskArrayOld select 2);};
if ((typeName _destination) == "SCALAR") then {
    _destination = (_taskArrayOld select 3);
} else {
    _destination = [_destination] call Zen_ConvertToPosition;
};

if ((typeName _descriptionLong) == "SCALAR") then {_descriptionLong = (_taskArrayOld select 4);};
if ((typeName _descriptionShort) == "SCALAR") then {_descriptionShort = (_taskArrayOld select 5);};

_childTasksOld = _taskArrayOld select 7;
if (count _childTasks > 0) then {
    0 = [_childTasksOld, _childTasks] call Zen_ArrayAppendNested;
};

_taskArrayNew = [(_taskArrayOld select 0), (_taskArrayOld select 1), _taskState, _destination, _descriptionLong, _descriptionShort, (_taskArrayOld select 6), _childTasksOld, _taskIcon];

{
    if ((_x select 0) == _nameString) then {
        Zen_Task_Array_Global set [_forEachIndex, _taskArrayNew];
    };
} forEach Zen_Task_Array_Global;
publicVariable "Zen_Task_Array_Global";

0 = [_nameString, _taskState, _showNotification] call Zen_UpdateTaskClient;

if (isMultiplayer) then {
    Zen_MP_Closure_Packet = ["Zen_UpdateTaskClient", [_nameString, _taskState, _showNotification]];
    publicVariable "Zen_MP_Closure_Packet";
};

if (_completeParentChild) then {
    _taskArrayNew = [_nameString] call Zen_GetTaskDataGlobal;

    _parentTask = _taskArrayNew select 6;
    _childTasks = _taskArrayNew select 7;

    if ([_taskState, ["failed", "succeeded", "canceled"]] call Zen_ValueIsInArray) then {
        {
            _childTaskState = ([_x] call Zen_GetTaskDataGlobal) select 2;
            if !([_childTaskState, ["failed", "succeeded", "canceled"]] call Zen_ValueIsInArray) then {
                0 = [_x, _taskState] call Zen_UpdateTask;
            };
        } forEach _childTasks;
    };

    if !([_parentTask, ""] call Zen_ValuesAreEqual) then {

        _childTasks = ([_parentTask] call Zen_GetTaskDataGlobal) select 7;
        _childTasksComplete = true;

        {
            _taskState = ([_x] call Zen_GetTaskDataGlobal) select 2;
            if !([_taskState, "succeeded"] call Zen_ValuesAreEqual) exitWith {
                _childTasksComplete = false;
            };
        } forEach _childTasks;

        if (_childTasksComplete) then {
            _taskState = ([_parentTask] call Zen_GetTaskDataGlobal) select 2;
            if !([_taskState, ["failed", "succeeded", "canceled"]] call Zen_ValueIsInArray) then {
                0 = [_parentTask, "succeeded"] call Zen_UpdateTask;
            };
        };
    };
};

call Zen_StackRemove;
if (true) exitWith {};
