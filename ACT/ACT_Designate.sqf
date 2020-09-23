//Action: designate airstrike target with a laser designator
private ["_delay","_pos"];
_delay=5;
if ((time - FFA_DESIGNATION_LASTTIME)<_delay) exitWith{hint format[localize "STR_HINT_DesignationTime",round(FFA_DESIGNATION_LASTTIME-time+_delay)]};
_pos=screenToWorld[0.5,0.5];
if (((player distance _pos) > 2000) || ((count _pos)==0)) exitWith{hint localize "STR_HINT_DesignationDistance"};
FFA_DESIGNATION_LASTTIME=time;
FFA_DESIGNATION_TARGET=[_pos select 0,_pos select 1,_pos select 2];
FFA_DESIGNATION_CALLER=player;
FFA_DESIGNATION_TIME=time;
publicVariable "FFA_DESIGNATION_TARGET";
publicVariable "FFA_DESIGNATION_TIME";
publicVariable "FFA_DESIGNATION_CALLER";
hint localize "STR_HINT_DesignationDone";