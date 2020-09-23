
_Unit = _This Select 0;
_Killer = _This Select 1;

if ((side _Killer == west) || (!(Controlteamatk))) exitWith {};

_Killer_Vehicle = ((Position _Unit) NearObjects ["landvehicle",10]) Select 0;
_Killer_Crew = Crew _Killer;
_Killer_Crew = _Killer_Crew - [AssignedDriver _Killer];
_Killer_Crew = _Killer_Crew - [AssignedCargo _Killer];

_Punish = false;
_Punish_No = 1;

If (Vehicle _Unit == Vehicle _Killer) Then
	{
	If (!isNil {(!IsNull _Killer_Vehicle) && (IsPlayer (Driver _Killer_Vehicle))}) Then
		{
		If ([_Unit] Call FN_GET_TKL_UnitSide == [Driver _Killer_Vehicle] Call FN_GET_TKL_UnitSide) Then
		  {
			If ((Round(Speed _Unit) != 0) && (Speed _Killer_Vehicle > 0)) Then
				{
				Controlteamatk=false;
				[Driver _Killer_Vehicle,_Punish_No,_Unit isKindOf "SoldierEB"] execVM "TKL\TKL_VoteAction.sqf";
				};
			};
		};
	_MEM_Killer_Side = markerText ((GetPlayerUID Player)+"_Side");
    (GetPlayerUID player)+"_Side" setMarkerText (name Player);
	Sleep 2;
	(GetPlayerUID player)+"_Side" setMarkerText _MEM_Killer_Side;
	}
	Else
	{
	if (GetPlayerUID _Killer in FFA_JIPCLIENTS) Then {_Punish = True;};	
	If ([_Unit] Call FN_GET_TKL_UnitSide == markerText ((GetPlayerUID _Killer)+"_Side")) Then {_Punish = True;};
	Sleep 1;
	If (markerText ((GetPlayerUID Leader _Unit)+"_Side") == markerText ((GetPlayerUID _Killer)+"_Side")) Then {_Punish = True;};
	If ((_Punish) && (isPlayer _Killer)) Then
	{
		Controlteamatk=false;
		While {Count _Killer_Crew > 0} Do
		{
			[_Killer_Crew Select 0,_Punish_No,_Unit isKindOf "SoldierEB"] execVM "TKL\TKL_VoteAction.sqf";
			_Killer_Crew = _Killer_Crew - [_Killer_Crew Select 0];
		};
	};
};
