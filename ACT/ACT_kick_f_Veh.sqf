//Action: kick vehicle crew
private["_veh","_kick"];

_kick=false;
_veh=_this select 0;

if (((driver _veh)==player) && !(_kick)) then
{
(gunner _veh) action ["eject",_veh];
(commander _veh) action ["eject",_veh];
_kick=true;
};

if (((gunner _veh)==player) && !(_kick)) then
{
(driver _veh) action ["eject",_veh];
(commander _veh) action ["eject",_veh];
_kick=true;
};

if (((commander _veh)==player) && !(_kick)) then
{
(driver _veh) action ["eject",_veh];
(gunner _veh) action ["eject",_veh];
_kick=true;
};

if (!(_kick)) then
{
(driver _veh) action ["eject",_veh];
(gunner _veh) action ["eject",_veh];
(commander _veh) action ["eject",_veh];
_kick=true;
};
