//Action: Reload vehicle ammo at base e.t.c.
private["_veh","_mag","_weap","_i","_percent"];
_veh=vehicle player;
_percent=0;
if ((typeOf _veh)!="2S6M_Tunguska") then
{
	{_veh RemoveMagazine _x} ForEach Magazines _veh;
}
else
{
	_veh setVehicleAmmo 0.1;
};
hint localize "STR_HINT_RearmProcess";
FFA_PROCESSREPAIR=true;
for [{_i=0},{(_i<8) && (alive _veh) && (_veh==(vehicle player)) && (abs(speed _veh) < 5) && (alive player)},{_i=_i+1}] do
{	
	sleep 1;
	_percent=_percent+12;
	titleText [localize "STR_HINT_RearmProcess", "PLAIN DOWN",0.3];	
	hint format[localize "STR_HINT_RearmPercent",_percent];
};
if (_i<8) exitWith
{
	hint localize "STR_HINT_RearmCanceled";
	titleText [localize "STR_HINT_RearmCanceled", "PLAIN DOWN",0.3];
	FFA_PROCESSREPAIR=false;
};
if ((typeOf _veh)!="2S6M_Tunguska") then
{
	_mag=_veh getVariable "FFA_EASALOADOUT_M";
	_weap=_veh getVariable "FFA_EASALOADOUT_W";
	
	if ((format["%1",_mag]=="<null>") || (format["%1",_weap]=="<null>")) then
	{		
		_mag=GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
		_mag=_mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach Magazines _veh;
		{_veh addMagazine _x} ForEach _mag;
	}
	else
	{
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach magazines _veh;
		{_veh removeWeapon _x} ForEach weapons _veh;
		{_veh addMagazine _x} ForEach _mag;
		{_veh addWeapon _x} ForEach _weap;
	};
}
else
{
	_veh setVehicleAmmo 1;
};
if (_veh isKindOf "Mi24_V") then
{
	_mag=_veh getVariable "FFA_EASALOADOUT_M";
	_weap=_veh getVariable "FFA_EASALOADOUT_W";
	
	if ((format["%1",_mag]=="<null>") || (format["%1",_weap]=="<null>")) then
	{		
		_mag=GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
		_mag=_mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach Magazines _veh;
		_veh addMagazine "520Rnd_23mm_GSh23L";
		_veh addMagazine "4Rnd_AT9_Mi24P";
		_veh addMagazine "80Rnd_S8T";
	}
	else
	{
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach magazines _veh;
		{_veh removeWeapon _x} ForEach weapons _veh;
		{_veh addMagazine _x} ForEach _mag;
		{_veh addWeapon _x} ForEach _weap;
	};
};
if (_veh isKindOf "Mi24_P") then
{
	_mag=_veh getVariable "FFA_EASALOADOUT_M";
	_weap=_veh getVariable "FFA_EASALOADOUT_W";
	
	if ((format["%1",_mag]=="<null>") || (format["%1",_weap]=="<null>")) then
	{		
		_mag=GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
		_mag=_mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach Magazines _veh;
		_veh addMagazine "750Rnd_30mm_GSh301";
		_veh addMagazine "4Rnd_AT6_Mi24V";
		_veh addMagazine "80Rnd_S8T";
	}
	else
	{
		_veh setVehicleAmmo 1;
		{_veh removeMagazine _x} ForEach magazines _veh;
		{_veh removeWeapon _x} ForEach weapons _veh;
		{_veh addMagazine _x} ForEach _mag;
		{_veh addWeapon _x} ForEach _weap;
	};
};
if (_veh isKindOf "Su39") then
{
	{_veh removeMagazine _x} ForEach magazines _veh;
	_veh addMagazine "12Rnd_Vikhr_KA50";
	_veh addMagazine "180Rnd_30mm_GSh301";
	_veh addMagazine "2Rnd_R73";
	_veh addMagazine "2Rnd_R73";
	_veh addMagazine "2Rnd_R73";
	_veh addMagazine "40Rnd_80mm";
	_veh addMagazine "40Rnd_80mm";
	_veh addMagazine "120Rnd_CMFlareMagazine";
	_veh addMagazine "120Rnd_CMFlareMagazine";
};
if (_veh isKindOf "Ka52") then
{
	{_veh removeMagazine _x} ForEach magazines _veh;
	_veh addMagazine "12Rnd_Vikhr_KA50";
	_veh addMagazine "250Rnd_30mmHE_2A42";
	_veh addMagazine "250Rnd_30mmHE_2A42";
	_veh addMagazine "120Rnd_CMFlareMagazine";
};
if (_veh isKindOf "Ka52Black") then
{
	{_veh removeMagazine _x} ForEach magazines _veh;
      _veh addMagazine "12Rnd_Vikhr_KA50";
	_veh addMagazine "250Rnd_30mmHE_2A42";
	_veh addMagazine "250Rnd_30mmHE_2A42";
	_veh addMagazine "2Rnd_Igla";
	_veh addMagazine "2Rnd_Igla";
	_veh addMagazine "120Rnd_CMFlareMagazine";
};
if (_veh isKindOf "C130J") then
{
	{_veh removeMagazine _x} ForEach magazines _veh;
      _veh addMagazine "120Rnd_CMFlareMagazine";
      _veh addMagazine "120Rnd_CMFlareMagazine";
 	_veh addMagazine "120Rnd_CMFlareMagazine";
	_veh addMagazine "6Rnd_Mk82";
	_veh addMagazine "6Rnd_Mk82";
	_veh addMagazine "6Rnd_Mk82";
	_veh addMagazine "6Rnd_Mk82";
	_veh addMagazine "6Rnd_Mk82";
	_veh addMagazine "1350Rnd_30mmAP_A10";
	_veh addMagazine "1350Rnd_30mmAP_A10";
	_veh addMagazine "1350Rnd_30mmAP_A10";
};
if (_veh isKindOf "L39_TK_EP1") then
{
	_veh addMagazine "60Rnd_CMFlareMagazine";
	_veh addMagazine "60Rnd_CMFlareMagazine";
	_veh addMagazine "60Rnd_CMFlareMagazine";
	_veh addMagazine "60Rnd_CMFlareMagazine";
};
if (player==(gunner _veh)) then
{
	hint localize "STR_HINT_RearmCompleteGunner";
}
else
{
	hint localize "STR_HINT_RearmComplete";
};
titleText [localize "STR_HINT_RearmCompleteGunner", "PLAIN DOWN",0.3];
FFA_PROCESSREPAIR=false;
exit;