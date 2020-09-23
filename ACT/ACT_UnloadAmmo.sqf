//Action: Unload an ammocrate from MHQ/Truck
private["_veh","_pos","_posx","_posy","_posz","_ammo"];
_veh=(nearestObjects[player,["BTR90_HQ","BMP2_HQ_INS"],20]) select 0;
if (!(isNull _veh) && (alive _veh)) then
{
	_pos=getPosATL _veh;
	_dir=getDir _veh;
	_posx=_pos select 0;
	_posy=_pos select 1;
	_posz=_pos select 2;
	_posx=_posx-5*sin(_dir);
	_posy=_posy-5*cos(_dir);
	_pos=[_posx,_posy,_posz];
	_ammo="RUBasicWeaponsBox" createVehicleLocal _pos;
	_ammo setDir _dir;
	clearMagazineCargo _ammo;
	clearWeaponCargo _ammo;	
	hint localize "STR_HINT_AmmoUnloaded";
	[_ammo] spawn FFA_FUNC_HANDLEMOBILEAMMO;
	FFA_AMMOCRATES=FFA_AMMOCRATES+[_ammo];	
	[] call FFA_FUNC_REFRESHARMORY
};