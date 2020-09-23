//Action: start dragging a dying teammate
private["_body","_scr"];
FFA_DRAGGEDUNIT=nearestObject [[(getposATL player select 0)+1.5*sin(getDir player), (getPosATL player select 1)+1.5*cos(getDir player), 0],"Man"];
if (!isNull FFA_DRAGGEDUNIT) then
{
	if ((animationState FFA_DRAGGEDUNIT)=="AinvPknlMstpSlayWrflDnon_healed2") exitWith {hint localize "STR_HINT_DragFirstAid"};
	_body=player;
	FFA_DRAGGEDUNIT setVariable ["FFA_DRAGGER",_body,true];
	FFA_DRAGGEDUNIT setVariable ["FFA_DRAGGED",true,true];
	FFA_DRAGREQUIRED=true;
	_body playActionNow "grabDrag";
	smokesave="SmokeShell" createVehicle ([0,0,0]);
	smokesave setPosAtl [(getposATL player select 0)+2.5*sin(getDir player), (getPosATL player select 1)+2.5*cos(getDir player), 0];
	ACT_DragStop=_body addAction [localize "STR_ACT_DragStop","ACT\ACT_DragStop.sqf"];
	waitUntil{!(FFA_DRAGREQUIRED) || ((lifeState _body)!="ALIVE") ||!(alive FFA_DRAGGEDUNIT) || (isNull FFA_DRAGGEDUNIT) || ((vehicle _body)!=_body)};
	if (alive _body) then
	{
		_body playAction "released";
	};
	_body removeAction ACT_DragStop;
	FFA_DRAGREQUIRED=false;
};