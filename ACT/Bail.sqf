//Bail Out
while {!(FFA_GAMEENDED)} do
{
	sleep 0.5;
	WaitUntil {sleep 0.2;(local player) && (alive player) && ((vehicle player)!=player) && (locked (vehicle player)) && !((vehicle player) isKindOf 'BIS_Steerable_Parachute')};
	VEH_LockedVehicle=vehicle player; 
	ACT_LockedVehicle=VEH_LockedVehicle addAction[localize 'STR_ACT_BailOut','ACT\ACT_BailOut.sqf',[],150,false]; 
	if ((VEH_LockedVehicle getVariable 'FFA_OWNER')!=name player) then {hint localize 'STR_HINT_WarningLocked'};
	WaitUntil {sleep 0.2;!(local player) || !(alive player) || ((vehicle player)==player) || !(locked (vehicle player)) || ((vehicle player) isKindOf 'BIS_Steerable_Parachute')};
	VEH_LockedVehicle removeAction ACT_LockedVehicle; 
	if ((player in VEH_LockedVehicle) && (alive VEH_LockedVehicle) && ((VEH_LockedVehicle getVariable 'FFA_OWNER')!=name player) && (alive player)) then {hint localize 'STR_HINT_WarningUnLocked'};
};