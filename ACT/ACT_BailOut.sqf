//Action: bail out from locked vehicle

private["_veh","_group","_cnt","_i","_dir","_pos","_unit","_chute"];

_veh=vehicle player;

_group=(units (group player))-[player];
_cnt=count _group;

for [{_i=0},{_i<_cnt},{_i=_i+1}] do
{
	_unit=_group select _i;
	if (!(isPlayer _unit) && (_veh==(vehicle _unit))) then
	{
		sleep 0.5;
	
		_dir=direction _veh;
		_pos=getPosATL _veh;
		_unit setPos [(_pos select 0)-5*cos(_dir),(_pos select 1)-5*sin(_dir),(_pos select 2)-1];

		if (((_pos select 2)>5) && ((vehicle _unit)==_unit)) then
		{
			[_unit] spawn FFA_FUNC_ACTPARA;
		};	
	};	
};

player action["EngineOff",_veh];
player action["GetOut",_veh];

sleep 1;

if (((getPosATL player)select 2)>5) then
{
 [player] spawn FFA_FUNC_ACTPARA;
};