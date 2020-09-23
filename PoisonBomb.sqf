DISTANCE = 25;
DAMMAGE = 0.1;

_unit = _this select 0;
_weapon = _this select 1;
_muzzle = _this select 2;
_mode = _this select 3;
_ammo = _this select 4;
_mag = _this select 5;
_proj = _this select 6;
if (_mag != "1Rnd_SmokeYellow_M203") exitWith {};

sleep 3;
while {alive _proj} do {
    _ppos = getpos _proj;
    sleep 0.5;
    
    _mas = nearestObjects [_ppos,["Man"], DISTANCE];
    {
        if (side _x != east) then {_x setDamage (damage _x + DAMMAGE)};
    } foreach _mas;  
};
hint "Xum Dblm pozveyalsya";

