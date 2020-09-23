//Server thread, that provides AI unlimited fuel and ammo

private["_marker","_i","_cnt","_item","_veh","_deathtime"];

while {!(FFA_GAMEENDED)} do
{
	sleep 3000;

	{_x setVehicleAmmo 1;sleep 1;} forEach (list WestAir);
	{_x setFuel 1;sleep 1;} forEach (list WestAir);
	
};