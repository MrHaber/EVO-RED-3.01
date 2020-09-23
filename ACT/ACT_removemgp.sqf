private ["_mg_name","_sWeap","_pWeap"];
_sWeap = secondaryWeapon player;
_pWeap = primaryWeapon player;
if (vehicle player == fmg) exitWith {hint localize "STR_HINT_MG_EXT"};
if ((_sWeap == "") && (_pWeap == "")) then
{
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;
	WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
	if (!(alive player)) exitWith 
	{
	};
	deleteVehicle fmg;
	mgnest_pos = [];
	_mg_name = format [localize "STR_MAP_MG", name player];
	deleteMarker _mg_name;
	if (true) exitWith 
	{
	player addWeapon "Pecheneg";
	player removeMagazine "100Rnd_762x54_PK";
	};
}
else
{
	hint localize "STR_HINT_UnableRemove";
};