//Action: Pick helicopter cargo
private["_veh","_cargo","_name","_actid","_pos","_altitude","_velocity","_chute","_dir"];
_veh=vehicle player;
_cargo=_this select 3;
if ((isNull _cargo) || ((_cargo distance _veh) > 20) ) exitWith {FFA_WINCHCARGO=false;};
FFA_WINCHCARGO=true;
_name=gettext(configFile >> "CfgVehicles" >> (typeof _cargo) >> "displayName");
_actid = _veh addAction [format [localize "STR_ACT_DropCargo", _name], "ACT\ACT_WinchDrop.sqf", _cargo];
hint format[localize "STR_HINT_Picked",_name]; 
while{(FFA_WINCHCARGO) && (alive _veh) && ((_veh emptyPositions "driver")==0) && (({alive _x} count (crew _cargo))==0)} do 
{
	sleep 0.02;
	_pos = getposATL _veh;
	_altitude = (_pos select 2);	
	_velocity = velocity _veh;

	if( _altitude > 15) then 
	{
		_cargo setdir getdir _veh;
		_cargo setposATL [(_pos select 0),(_pos select 1),(_pos select 2)-15];		
		_cargo setvelocity [(_velocity select 0),(_velocity select 1),(_velocity select 2)];
	}
 	else
 	{
		_cargo setdir getdir _veh;
		_cargo setposATL [(_pos select 0),(_pos select 1),0];		
		_cargo setvelocity [(_velocity select 0),(_velocity select 1),0];
	};
};
_veh removeAction _actid;
FFA_WINCHCARGO=false;
if (!(alive _veh) || ((_veh emptyPositions "driver")>0)) then
{
	_pos=getposATL _veh;
	_vel=velocity _veh;
	_cargo setvelocity [(_vel select 0)*5,(_vel select 1)*5,0];
	if ((_pos select 2)>25) then
	{
		sleep 5.0;
		_cargo setDammage 0.4;	
	};
	if ((_pos select 2)>45) then
	{
		sleep 5.0;
		_cargo setDammage 1;	
	};
}
else
{
	hint format[localize "STR_HINT_Dropped",_name];
	if ((((getPosATL _veh) select 2) > 70) && (alive _veh) && !(isNull _veh)) then	
	{
		_pos=getPosATL _cargo;
		_dir=getDir _cargo;
		_chute="ParachuteMediumEast";
		_chute=_chute createVehicle [0,0,0];
		_chute setPosATL [_pos select 0,_pos select 1,(_pos select 2)+10];
		_chute setDir _dir; 
		_cargo attachTo [_chute,[0,0,0]];
		while {(alive _chute) && ((getPosATL _cargo select 2)>5)} do
		{
			sleep 2;
		};
		detach  _cargo;
		_pos=getPosATL _cargo;
		_chute setPos [(_pos select 0)+3,(_pos select 1)+3,_pos select 2];
		sleep 5;
		deleteVehicle _chute;
	};
};