private ["_base","_bombP"];
_base = getMarkerPos "BaseNoBomb";
sleep 15;
while {!(FFA_GAMEENDED)} do 
{
sleep 0.5;
_bombP = (_base nearObjects ["PipeBomb",150])select 0;
sleep 0.5;
if (!isNil {_bombP}) then {deletevehicle _bombP};
};