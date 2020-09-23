//Script adds and removes actions "Pick cargo" and "Drop cargo" to transport helicopters
private["_veh","_actadded","_cargo","_vehicle"];
_veh=vehicle player;
_actadded = 0;
_cargo = objNull;
FFA_WINCHCARGO=false;

ACT_WinchCargo=_veh addAction [format[localize "STR_ACT_PickCargo",_name], "ACT\ACT_WinchPick.sqf", _cargo];
_veh removeAction ACT_WinchCargo;

while{(alive _veh) && (canMove _veh) && ((_veh emptyPositions "driver")==0)} do
{
	if (!(FFA_WINCHCARGO) && (alive player) && ((_veh emptyPositions "driver")==0) && ((getPosATL _veh select 2)>5)) then
 	{
		_vehicle = nearestObject [_veh, "LandVehicle"];
		if !(isNull _vehicle) then
 		{
			if ((_vehicle distance _veh) > 17) then
 			{
				_veh removeAction ACT_WinchCargo;
				_actadded = 0;
			}
			else
			{
				if ((_vehicle!=_cargo) && (_actadded == 1)) then
				{
					_veh removeAction ACT_WinchCargo;
					_actadded = 0;
				};
				if(_actadded==0) then
 				{
					_actadded = 1;
					_cargo = _vehicle;
					_name=gettext(configFile >> "CfgVehicles" >> (typeof _cargo) >> "displayName");
					ACT_WinchCargo=_veh addAction [format[localize "STR_ACT_PickCargo",_name], "ACT\ACT_WinchPick.sqf", _cargo];
				};			
			};		
		};	
	}	
	else	
	{		
		_veh removeAction ACT_WinchCargo;
		_actadded = 0;
	};
	sleep 0.5;
};
_veh removeAction ACT_WinchCargo;
_actadded = 0;
exit;