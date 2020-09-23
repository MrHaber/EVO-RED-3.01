//Action: First aid a friendly unit

private["_unit"];

_unit=nearestObject [[(getposATL player select 0)+1.5*sin(getDir player), (getPosATL player select 1)+1.5*cos(getDir player), 0],"Man"];
if  !(isNull _unit) then
{



	if (_unit getVariable "FFA_DRAGGED") exitWith {hint localize "STR_HINT_FirstAidDrag"};
	if ( ((player getVariable "MedPack")>0) || ((paramsArray select 5)==0) ) then 
	{
		player setvariable ["MedPack",((player getVariable "MedPack")-1),false];
	
		FFA_MEDIC=player;
		FFA_INJURED=_unit;
		FFA_DRAGREQUIRED=true;
		publicVariable "FFA_MEDIC";
		publicVariable "FFA_INJURED";
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		_unit playMove "AinvPknlMstpSlayWrflDnon_healed2";
		sleep 5;
		WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		_unit setDamage 0;
		FFA_DRAGREQUIRED=false;

		if ((paramsArray select 5)!=0) then 
		{
			hint format[localize "STR_HINT_HealPackets",(player getVariable "MedPack")];
		};
	} else {
		hint format[localize "STR_HINT_HealPackets",(player getVariable "MedPack")];
	};
};