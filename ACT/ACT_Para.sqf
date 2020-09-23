private["_unit","_caller","_pos","_chute"];

_caller=_this select 1;
_unit=_this select 3;
	
if ((((getPosATL _unit) select 2) > 16) && (_unit == _caller)) then
{

	if (!(local _unit)) exitWith{};
	
	_unit action ['GetOut',vehicle _unit];
	
	sleep 1;

	if (((vehicle _unit)!=_unit) && ((vehicle _unit) isKindOf "ParachuteBase")) then
	{
		deleteVehicle vehicle _unit;
	};

	if ((((getPosATL  (vehicle _unit)) select 2) > 100) && (alive _unit) && !(isNull _unit)) then
	{
		_unit switchMove "HaloFreeFall_non";

		waitUntil{(((getPosATL _unit) select 2) < 100) || !(alive _unit) || (isNull _unit)};
	};

	if ((alive _unit) && !(isNull _unit) && (((getPosATL _unit) select 2) > 12)) then
	{
		waitUntil{(((getPosATL _unit) select 2) < 85)};	
	
		_unit switchMove "";

		_pos=getPosATL _unit;
		_chute="Parachute" createVehicle [0,0,0];
		_chute setPos [_pos select 0,_pos select 1,(_pos select 2)+5];
		_chute setDir (getDir _unit);
		_unit moveInDriver _chute;
		_chute setPosATL _pos;
		waitUntil{(((getPosATL _unit) select 2) < 12) || !(alive _unit) || (isNull _unit)};
		sleep 5;
		deleteVehicle _chute;
	};
};