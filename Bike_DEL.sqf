if ! isServer exitWith {};
private["_veh", "_tm"];  
_veh=_this select 0;  

While {alive _veh} do {// бесконечный цикл 
WaitUntil {! isNull (driver _veh)}; //сначала дождёмся седока 
sleep 0.1; 
WaitUntil {isNull (driver _veh)}; // водила покинул кабину, ждём 60 сек. 
_tm = time + 180;  
WaitUntil {(_tm < time) || !( isNull (driver _veh))}; 

if (isNull (driver _veh)) exitWith {}; // если водила так и не вернулся, выход из цикла. 

}; 

_veh setDammage 1;  

_veh removeAllEventHandlers "killed";  
_veh removeAllEventHandlers "IncomingMissile";  
_veh removeAllEventHandlers "HandleDamage";  
_veh removeAllEventHandlers "Hit";  
_veh removeAllEventHandlers "GetOut";  
_veh removeAllEventHandlers "Init";  

deleteVehicle _veh;