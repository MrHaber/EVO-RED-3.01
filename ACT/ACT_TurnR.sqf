//Action: turn 90 right your static

private["_veh"];

_veh=_this select 3;

if (!(isNull _veh)) then
{
_veh setdir ((getdir _veh)+90);
};