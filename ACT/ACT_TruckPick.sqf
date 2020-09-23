//Action: Pick truck cargo
private["_veh","_cargo","_name","_actid","_pos","_velocity"];

_veh=vehicle player;
_cargo=_this select 3;

if ((isNull _cargo) || ((_cargo distance _veh) > 20) ) exitWith {FFA_WINCHCARGO=false;};

FFA_WINCHCARGO=true;
_name=gettext(configFile >> "CfgVehicles" >> (typeof _cargo) >> "displayName");

_actid = _veh addAction [format [localize "STR_ACT_DropCargo", _name], "ACT\ACT_TruckDrop.sqf", _cargo];

hint format[localize "STR_HINT_Picked",_name]; 

while{(FFA_WINCHCARGO) && (alive _veh) && ((_veh emptyPositions "driver")==0) && (({alive _x} count (crew _cargo))==0)} do 
{
	sleep 0.05;
	_pos = (_veh modelToWorld [0,-10,0]);
	_velocity = velocity _veh;

	_cargo setdir ((getdir _veh)+180);
	_cargo setposATL [_pos select 0,_pos select 1,1];	
	_cargo setvelocity [(_velocity select 0),(_velocity select 1),(_velocity select 2)];
};

_veh removeAction _actid;
FFA_WINCHCARGO=false;

if (!(alive _veh) || ((_veh emptyPositions "driver")>0)) then
{
	_pos=(_veh modelToWorld [0,-10,0]);
	_velocity=velocity _veh;

	_cargo setposATL [_pos select 0,_pos select 1,0];	


	_cargo setvelocity [(_velocity select 0)*5,(_velocity select 1)*5,0];


};