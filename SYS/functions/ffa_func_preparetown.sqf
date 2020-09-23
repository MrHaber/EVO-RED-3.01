//selects the next town to attack

	private ["_stp","_force"];

	sleep 0.5;
	
	if (alive FFA_RADIO) then {FFA_RADIO removeAllEventHandlers "hit";FFA_RADIO setDammage 1;FFA_RADIO=objNull;};

	"EnemyArea" setMarkerSize [0,0];
	"RadioMarker" setMarkerPos [0,0];

	[] call compile "{if (_x isKindOf ""Man"") then {_x setDammage 1}} forEach list WestAir";

	FFA_TOWNGUARDSSPAWNED=false;
	FFA_CURRENTTOWNCAPTURED=true;

	FFA_RADIOMINED=false;
	publicVariable "FFA_RADIOMINED";

	FFA_CLIENTREPORTOBJACTIVE=false;
	publicVariable "FFA_CLIENTREPORTOBJACTIVE";

	if (FFA_CURRENTTOWNNAME!="") then
	{
		FFA_CLIENTREPORTOBJDONE=true;
		publicVariable "FFA_CLIENTREPORTOBJDONE";
	};
	
	{_x addScore 10} forEach (list FFA_EASTSENSOR);

	sleep 10;

	FFA_INNERRING=FFA_INNERRING+1;
	FFA_CURRENTTOWNINDEX=FFA_CURRENTTOWNINDEX+1;

	if (FFA_INNERRING>=(paramsArray select 3)) then
	{
		FFA_INNERRING=0;
		FFA_OUTERRING=FFA_OUTERRING+1;
		FFA_REINFORCEMENTSTIMEMODIFIER=FFA_REINFORCEMENTSTIMEMODIFIER+0.1;

		FFA_INNERTOWNLIST=FFA_ENEMYTOWNS select FFA_OUTERRING;
		FFA_INNERTOWNNAMES=FFA_TOWNNAMES select FFA_OUTERRING;
	};

	if (FFA_CURRENTTOWNINDEX>(paramsArray select 2)) exitWith
	{
		FFA_GAMEENDED=true;
		publicVariable "FFA_GAMEENDED";
	};

	_InnerTownCount=(count FFA_INNERTOWNLIST)-1;
	_InnerTownNumber=round (random _InnerTownCount);

	FFA_CURRENTTOWNMARKER=FFA_INNERTOWNLIST select _InnerTownNumber;
	FFA_INNERTOWNLIST=FFA_INNERTOWNLIST-[FFA_CURRENTTOWNMARKER];

	FFA_CURRENTTOWNNAME=FFA_INNERTOWNNAMES select _InnerTownNumber;
	FFA_INNERTOWNNAMES=FFA_INNERTOWNNAMES-[FFA_CURRENTTOWNNAME];

	publicVariable "FFA_CURRENTTOWNMARKER";
	publicVariable "FFA_CURRENTTOWNNAME";

	FFA_REINFORCEMENT=[];
	for [{_stp=1},{_stp<4},{_stp=_stp+1}] do
	{
		FFA_REINFORCEMENT=FFA_REINFORCEMENT+[format["Force_%1_%2_%3",FFA_OUTERRING+1,_InnerTownNumber+1,_stp]];
	};

	sleep 10;

	FFA_EASTSENSOR setPos getMarkerPos FFA_CURRENTTOWNMARKER;
	FFA_WESTSENSOR setPos getMarkerPos FFA_CURRENTTOWNMARKER;
	"EnemyArea" setMarkerPos getMarkerPos FFA_CURRENTTOWNMARKER;

	FFA_RADIO=createVehicle ["Land_Antenna",getMarkerPos FFA_CURRENTTOWNMARKER,[],400,"NONE"];
	FFA_RADIO addEventHandler ["hit",{FFA_RADIO setDammage 0}];
	publicVariable "FFA_RADIO";

	[FFA_CURRENTTOWNMARKER] execVM "SYS\functions\ffa_func_townguards.sqf";

	waitUntil{FFA_TOWNGUARDSSPAWNED};

	"EnemyArea" setMarkerSize [850,850];

	FFA_CURRENTTOWNCAPTURED=false;

	FFA_CLIENTREPORTOBJACTIVE=true;
	publicVariable "FFA_CLIENTREPORTOBJACTIVE";

	FFA_CLIENTREPORTOBJDONE=false;
	publicVariable "FFA_CLIENTREPORTOBJDONE";

	"RadioMarker" setMarkerPos getPosATL FFA_RADIO;

	[] execVM "SYS\functions\ffa_func_reinforcements.sqf";
	
        FFA_TNDEF=1;
	publicVariable "FFA_TNDEF";