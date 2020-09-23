//Action: Lock/Unlock your vehicles

private["_veh","_name"];

_veh=_this select 0;

if (!(isNull _veh)) then
{
	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");

	if (local _veh) then
	{
		_veh lock !(locked _veh);
		if (locked _veh) then
		{
			hint format[localize "STR_HINT_Locked",_name];			
		}
		else
		{
			hint format[localize "STR_HINT_UnLocked",_name];
		};
	}
	else
	{
		FFA_LUVEHICLE=_veh;
		publicVariable "FFA_LUVEHICLE";
		hint format[localize "STR_HINT_LockProcess",_name];
	};
};