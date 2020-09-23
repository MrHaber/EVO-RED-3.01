private ["_posat","_at_name","_marker2"];
FFA_DELETE_AT=
{
	sleep 25;
	fat removeAllEventHandlers "killed";
	fat removeAllEventHandlers "fired";
	atnest_pos = [];
	deleteVehicle fat;
};
FFA_DELETE_AMMO_AT=
{
	if (player==gunner fat)then
	{
		player removeMagazine "AT13";
	};
};
_at_ammo = {_x == "AT13"} count magazines player;
if (_at_ammo == 0) exitWith {hint localize "STR_HINT_METIS_AMMO"};
if (alive fat) exitWith {hint localize "STR_HINT_METIS_CREAT"};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 5;
WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith 
{
	atnest_pos = [];
};
_posat  = getdir player;
fat = "Metis" createVehicle ([0,0,0]);
fat setdir _posat;
fat setPos getPos player;
atnest_pos = position fat;
fat SetVehicleInit "this addEventHandler [""killed"",""_this spawn FFA_DELETE_AT""]; this addEventHandler [""fired"",{[] call FFA_DELETE_AMMO_AT}]";
ProcessInitCommands;
fat addAction [localize "STR_ACT_METIS_DES", "ACT\ACT_removeat.sqf"];
player moveInGunner fat;
if (true) exitWith 
{
	player removeWeapon "MetisLauncher";
	player addEventHandler ["killed","_this spawn FFA_DELETE_AT"];
};