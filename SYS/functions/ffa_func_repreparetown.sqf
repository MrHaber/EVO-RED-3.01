//установка переменных для генерации новой антенны

FFA_TOWNGUARDSSPAWNED=false;

private ["_location1","_x","_y"];
	
FFA_ENEMY_PRES=true;
publicVariable "FFA_ENEMY_PRES";

  sleep 1;
  
FFA_ENEMY_PRES=false;
publicVariable "FFA_ENEMY_PRES";

 sleep 10;
 
FFA_RERADIO=true;
publicVariable "FFA_RERADIO";
	
FFA_RADIOMINED=false;
publicVariable "FFA_RADIOMINED";

	
sleep 0.5;

if (alive FFA_RADIO) then {FFA_RADIO removeAllEventHandlers "hit"};
FFA_RADIO= createVehicle ["Land_Antenna",getMarkerPos FFA_CURRENTTOWNMARKER,[],350,"NONE"];

_location1 = GetPosATL FFA_RADIO;
	
while {surfaceIsWater _location1} do
{
	_x=(_location1 select 0) - 25;
	_y=(_location1 select 1) + 25;
	_location1 set [0, _x];
	_location1 set [1, _y];
};
	
FFA_RADIO SetPosATL _location1;

FFA_RADIO addEventHandler ["hit",{FFA_RADIO setDammage 0}];
publicVariable "FFA_RADIO";
"RadioMarker" setMarkerPos getPosATL FFA_RADIO;

[] execVM "SYS\functions\ffa_func_reinforcements.sqf";


FFA_TNDEF=1;
publicVariable "FFA_TNDEF";
	
FFA_RERADIO=false;
publicVariable "FFA_RERADIO";

sleep 1;
FFA_TOWNGUARDSSPAWNED=true;
