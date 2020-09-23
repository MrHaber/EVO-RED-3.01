//If someone wants to drag dying player, this sctipt is activated
private["_player","_dragger","_dir","_pos"];
_player=_this select 0;
_dragger=_player getVariable "FFA_DRAGGER";
hint format[localize "STR_HINT_Drag",_dragger getVariable "FFA_SELFNAME"];
_player playActionNow "grabDragged";
_dir=direction _dragger;
_pos=getPosAtl _dragger;
smokesave2="SmokeShell" createVehicle ([0,0,0]);
smokesave2 setPosAtl [(_pos select 0)+2.5*(sin _dir),(_pos select 1)+2.5*(cos _dir),_pos select 2];
while{(_player getVariable "FFA_DRAGGED") && (alive _player) && ((lifeState _dragger)=="ALIVE") && !(isNull _dragger) && ((vehicle _dragger)==_dragger)} do
{
	_dir=direction _dragger;
	_pos=getPosAtl _dragger;
	_player setDir (180+_dir);
	_player setPosAtl [(_pos select 0)+0.9*(sin _dir),(_pos select 1)+0.9*(cos _dir),_pos select 2];
	sleep 0.02;
};
//detach _player;
if (alive _player) then
{
	_player playAction "agonyStart";
}
else
{
	_player switchAction "released";
};
_player setVariable["FFA_DRAGGED",false,true];