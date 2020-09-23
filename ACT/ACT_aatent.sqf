private ["_posaa","_aa_name","_marker1"];
FFA_DELETE_AA=
{
	sleep 25;
	faa removeAllEventHandlers "killed";
	faa removeAllEventHandlers "fired";
	aanest_pos = [];
	deleteVehicle faa;
};
FFA_DELETE_AMMO_AA=
{
	if (player==gunner faa)then
	{
	player removeMagazine "Igla";
	};
};
_aa_ammo = {_x == "Igla"} count magazines player;
if (_aa_ammo == 0) exitWith {hint localize "STR_HINT_IGLA_AMMO"};
if (alive faa) exitWith {hint localize "STR_HINT_IGLA_CREAT"};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 5;
WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith 
{
	aanest_pos = [];
};
_posaa  = getdir player;
faa = "Igla_AA_pod_East" createVehicle ([0,0,0]);
faa setdir _posaa;
faa setPos getPos player;
aanest_pos = position faa;
faa SetVehicleInit "this addEventHandler [""killed"",""_this spawn FFA_DELETE_AA""]; this addEventHandler [""fired"",{[] call FFA_DELETE_AMMO_AA}]";
	ProcessInitCommands;
faa addAction [localize "STR_ACT_IGLA_DES", "ACT\ACT_removeaa.sqf"];
player moveInGunner faa;
if (true) exitWith 
{
	player removeWeapon "Igla";
	player addEventHandler ["killed","_this spawn FFA_DELETE_AA"];
};