if ! isServer exitWith {};
private["_veh", "_tm"];  
_veh=_this select 0;  

While {alive _veh} do {// ����������� ���� 
WaitUntil {! isNull (driver _veh)}; //������� ������� ������ 
sleep 0.1; 
WaitUntil {isNull (driver _veh)}; // ������ ������� ������, ��� 60 ���. 
_tm = time + 180;  
WaitUntil {(_tm < time) || !( isNull (driver _veh))}; 

if (isNull (driver _veh)) exitWith {}; // ���� ������ ��� � �� ��������, ����� �� �����. 

}; 

_veh setDammage 1;  

_veh removeAllEventHandlers "killed";  
_veh removeAllEventHandlers "IncomingMissile";  
_veh removeAllEventHandlers "HandleDamage";  
_veh removeAllEventHandlers "Hit";  
_veh removeAllEventHandlers "GetOut";  
_veh removeAllEventHandlers "Init";  

deleteVehicle _veh;