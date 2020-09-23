//Action: Drop truck cargo
private["_veh","_cargo","_pos","_velocity"];

_veh=vehicle player;
_cargo=_this select 3;

FFA_WINCHCARGO=false;


sleep 1;

_pos = (_veh modelToWorld [0,-10,0]);
_velocity = velocity _veh;

_cargo setdir ((getdir _veh)+180);
_cargo setposATL [_pos select 0,_pos select 1,0];	
_cargo setvelocity [(_velocity select 0),(_velocity select 1),(_velocity select 2)];

exit;