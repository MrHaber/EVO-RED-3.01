private ["_aa_name","_sWeap","_pWeap"];
_sWeap = secondaryWeapon player;
_pWeap = primaryWeapon player;
if (vehicle player == faa) exitWith {hint localize "STR_HINT_IGLA_EXT"};
if ((_sWeap == "") && (_pWeap != "Pecheneg") && (_pWeap != "PK") && (_pWeap != "KSVK") && (_pWeap != "M107") && (_pWeap != "M240") && (_pWeap != "Mk_48") && (_pWeap != "M249")) then
{
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;
	WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
	if (!(alive player)) exitWith 
	{
	};
	deleteVehicle faa;
	aanest_pos = [];
	_aa_name = format [localize "STR_MAP_IGLA", name player];
	deleteMarker _aa_name;
	if (true) exitWith 
	{
		player addWeapon "Igla";
	};
}
else
{
	hint localize "STR_HINT_UnableRemove";
};