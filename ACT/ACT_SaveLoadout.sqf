//Action: Save your weapon loadout

#include "defines.sqf"

private["_weapons","_magazines","_backweapon","_ruckweapons","_ruckmagazines","_hasruck","_ear","_eye","_identity"];

_weapons=weapons player;
_magazines=magazines player;

#ifdef __USE_ACE__
	_backweapon=player getVariable "ACE_weapononback";

	_hasruck=player call ace_sys_ruck_fnc_hasRuck;

	if (_hasruck) then
	{
		_ruckweapons=player getVariable "ACE_RuckWepContents";
		_ruckmagazines=player getVariable "ACE_RuckMagContents";
	
		{_weapons=_weapons+[_x select 0]} forEach _ruckweapons;
		{_magazines=_magazines+[_x select 0]} forEach _ruckmagazines;		
	};
	if (!isNil "_backweapon") then
	{
		if (_backweapon != "") then
		{
			_weapons=_weapons+[_backweapon];
		};
	};
#endif

if (({_x in FFA_AVALIABLE_W} count _weapons==count _weapons) && ({_x in FFA_AVALIABLE_M} count _magazines==count _magazines)) then
{
	
	FFA_LOADOUT_W=weapons player;
	FFA_LOADOUT_M=magazines player;

#ifdef __USE_ACE__
	FFA_LOADOUT_B=_backweapon;

	FFA_LOADOUT_EARPROT=player getVariable "ACE_Ear_Protection";	
	FFA_LOADOUT_EYEPROT=player getVariable "ACE_Eye_Protection";
	FFA_LOADOUT_EARWEAR=player getVariable "ACE_EarWear";
	FFA_LOADOUT_EYEWEAR=player getVariable "ACE_EyeWear";
	FFA_IDENTITY=player getVariable "ACE_Identity";

	if (_hasruck) then
	{
		FFA_LOADOUT_RW=_ruckweapons;
		FFA_LOADOUT_RM=_ruckmagazines;
	};
#endif
	hint localize "STR_HINT_LoadoutSaved";	
}
else
{
	hint localize "STR_HINT_LoadoutNotSaved";
};