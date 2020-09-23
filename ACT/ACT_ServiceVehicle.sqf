//Action: Technical service of a vehicle

#include "defines.sqf"

private["_veh","_i"];

_veh=vehicle player;

#ifdef __USE_ACE__
	if (_veh getVariable "ace_onfire") exitWith{hint localize "STR_HINT_ServiceOnFire"};
#endif

hint localize "STR_HINT_ServiceProcess";

FFA_PROCESSREPAIR=true;

for [{_i=0},{(_i<10) && ((getDammage _veh>0.09) || (fuel _veh<0.91)) && (alive _veh) && (_veh==(vehicle player)) && (abs(speed _veh) < 5) && (alive player)},{_i=_i+1}] do
{	
	_veh setDammage (getDammage _veh)-0.1;	
	_veh setFuel (fuel _veh)+0.1;	
	titleText [localize "STR_HINT_ServiceProcess", "PLAIN DOWN",0.3];
	sleep 1;
};

if ((fuel _veh>=0.91) && (getDammage _veh<=0.09)) then
{
	_veh setVariable["FFA_REPAIRKITS",3,true];

#ifdef __USE_ACE__
	if ((_veh isKindOf "Tank") || (_veh isKindOf "Wheeled_APC")) then
	{	
		["ace_sys_repair_repair_full", [_veh]] call CBA_fnc_globalEvent;
		["ace_sys_repair_refuel", [_veh, 1]] call CBA_fnc_globalEvent;
	}
	else
	{
		_veh setDammage 0;
		_veh setFuel 1;
	};
	if (_veh isKindOf "air") then
	{
		_veh setVariable["ACE_Flares",12,true];
	};
#else
	_veh setDammage 0;
	_veh setFuel 1;
	if (_veh isKindOf "air") then
	{
		_veh setVariable ["FFA_FLARESLEFT",FFA_DEFAULTFLARES,true];
	};
#endif
		
	if (_veh isKindOf "air") then
	{
		titleText [format [localize "STR_HINT_ServiceCompleteAir",3,FFA_DEFAULTFLARES], "PLAIN DOWN",0.3];
		hint format[localize "STR_HINT_ServiceCompleteAir",3,FFA_DEFAULTFLARES];
	}
	else
	{
		if (GetNumber (configFile >> "CfgVehicles" >> typeof _veh >> "smokeLauncherGrenadeCount")>0) then
		{		
			_veh setVariable ["FFA_SMOKESLEFT",FFA_DEFAULTSMOKES,true];
			titleText [format [localize "STR_HINT_ServiceCompleteTank",3,FFA_DEFAULTSMOKES], "PLAIN DOWN",0.3];
			hint format[localize "STR_HINT_ServiceCompleteTank",3,FFA_DEFAULTSMOKES];
		}
		else
		{
			titleText [format [localize "STR_HINT_ServiceCompleteLand",3], "PLAIN DOWN",0.3];
			hint format[localize "STR_HINT_ServiceCompleteLand",3];	
		}		
	};
}
else
{
	hint localize "STR_HINT_ServiceCanceled";
	titleText [localize "STR_HINT_ServiceCanceled", "PLAIN DOWN",0.3];
};

FFA_PROCESSREPAIR=false;

exit;