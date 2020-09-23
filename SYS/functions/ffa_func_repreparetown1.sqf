//установка переменных для перехода к следующему городу

FFA_TOWNGUARDSSPAWNED=false;

private ["_count","_cnt","_veh"];

[] call FFA_FUNC_DESTROYALL;

_count=(count FFA_FORTSTOCLEAR)-1;

for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_veh=FFA_FORTSTOCLEAR select _cnt;
	_veh allowDamage true;
	deletevehicle _veh;
	sleep 0.25;
};

FFA_FORTSTOCLEAR=[];

FFA_TNDEF=0;
publicVariable "FFA_TNDEF";

sleep 1;
FFA_TOWNGUARDSSPAWNED=true;
