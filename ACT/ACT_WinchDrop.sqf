//Action: Drop helicopter cargo
private["_veh","_altitude"];
_veh=vehicle player;
_altitude=getPosATL _veh select 2;
if ((_altitude <= 15) || (_altitude >= 70)) then
{
	FFA_WINCHCARGO=false;
}
else
{
	hint localize "STR_HINT_NoDrop";
};
exit;