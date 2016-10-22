private ["_text"];

waitUntil {!isNil "jh_pvar_aoLocation"};
waitUntil {!isNil "jh_pvar_lzPosition"};
waitUntil {!isNil "jh_pvar_vehicleStartPosition"};

_text = "
We have receive intel that there is a HVT located somewhere in %1. We believe that he is in posession of some intel that is critical to halting their nuclear program. <br/><br/>
Your tasks are as follows<br/><br/>
Task 1 - Approach %1<br/>
We will be dropping you at a <marker name='mkrLZ'>safe distance</marker> from the AO. You are to carefully make your way toward the AO.<br/><br/>
Task 2 - Locate the intel<br/>
Once you make your way to %1, search the area for the intel. Once you have located it, you will upload a copy of the data to the drive. After this you are to wipe the device.<br/><br/>
Task 3 - Locate and eliminate the HVT<br/>
This is an optional task. If you do find the HVT, take him out.<br/><br/>
Task 4 - Exfil<br/>
Once you have the intel, we need you to get back home with it. We'll have a chopper on standby waiting for you to radio in. Find a suitable spot for him, then radio for a pick up.
";
player createDiaryRecord [
    "Diary",
    [
        "Mission",
        format [
            _text,
            format ["<marker name='mkrAO'>%1</marker>", text jh_pvar_aoLocation]
        ]
    ]
];

_text = "
We had some drones flyby and scope out the area. From what we can see, you should expect some heavy resistence. Looks like they are really trying to protect this intel.<br><br>
We have spotted multiple vehicle patrols. Looks like some light armour, and some heavy armour. There is also a helicopter patrolling the area. Aside from that, there looks to be a dozen or so squads patrolling the area.
";
player createDiaryRecord [
    "Diary",
    [
        "Intel",
        format [
            _text,
            format ["<marker name='mkrAO'>%1</marker>", text jh_pvar_aoLocation]
        ]
    ]
];

_text = "We have arranged to get some Hunters near your insertion location. There are a total of 2 vehicles available for you, however, only one of them is armed. You will be able to find at the side of a road to the %1 of the LZ.";
player createDiaryRecord [
    "Diary",
    [
        "Transport",
        format [
            _text,
            format ["<marker name='mkrAO'>%1</marker>", (jh_pvar_lzPosition getDir jh_pvar_vehicleStartPosition) call jh_fnc_getCardinalDirection]
        ]
    ]
];
