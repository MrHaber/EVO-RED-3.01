private ["_posmg","_mg_name","_marker3"];
FFA_DELETE_MG=
{
	sleep 25;
	fmg removeAllEventHandlers "killed";
	fmg removeAllEventHandlers "fired";
	mgnest_pos = [];
	deleteVehicle fmg;
};
_mg_ammo = {_x == "100Rnd_762x54_PK"} count magazines player;
if (_mg_ammo == 0) exitWith {hint localize "STR_HINT_MG_AMMO"};
if (alive fmg) exitWith {hint localize "STR_HINT_MG_CREAT"};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 5;
WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith 
{
	mgnest_pos = [];
};
_posmg  = getdir player;
fmg = "RU_WarfareBMGNest_PK" createVehicle ([0,0,0]);
fmg setdir _posmg;
fmg setPos getPos player;
mgnest_pos = position fmg;
fmg SetVehicleInit "this addEventHandler [""killed"",""_this spawn FFA_DELETE_MG""]";
ProcessInitCommands;
fmg addAction [localize "STR_ACT_MG_DES", "ACT\ACT_removemg.sqf",[],0,false];
player moveInGunner fmg;
if (true) exitWith 
{
	player removeWeapon "PK";
	player removeMagazine "100Rnd_762x54_PK";
	player addEventHandler ["killed","_this spawn FFA_DELETE_MG"];
};