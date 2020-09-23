private ["_posmg","_mg_name"];
FFA_DELETE_fort=
{
	sleep 25;
	fort removeAllEventHandlers "killed";
	fort_pos = [];
	deleteVehicle fort;
};
if (alive fort) exitWith 
{
	_pxfort2 = getPos player select 0;
    _pyfort2 = getPos player select 1;
	_posfort2  = getdir player;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;
    WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
	if (!(alive player)) exitWith 
    {
		fort_pos = [];
	};
	fort setdir _posfort2 + 180;
	fort setPos [_pxfort2+1*sin _posfort2, _pyfort2+1*cos _posfort2, 0];
};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 10;
WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith 
{
	fort_pos = [];
};
_posfort = getdir player;
_pxfort = getPos player select 0;
_pyfort = getPos player select 1;
fort = "Land_BagFenceRound" createVehicle ([0,0,0]);
fort setdir _posfort + 180;
fort setPos [_pxfort+1*sin _posfort, _pyfort+1*cos _posfort, 0];
fort SetVehicleInit "this addEventHandler [""killed"",""_this spawn FFA_DELETE_fort""]";
ProcessInitCommands;
if (true) exitWith 
{
	player addEventHandler ["killed","_this spawn FFA_DELETE_fort"];
};