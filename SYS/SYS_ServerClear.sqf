//Server thread that deletes dead bodies, deletes empty groups, explodes landed enemy choppers, gives anti-air awards, reveals enemy aircrafts to players

private["_marker","_i","_cnt","_item","_veh","_deathtime","_value","_AA","_endtime","_currenttime","_baselist","_currenttown","_crew"];
waitUntil{(FFA_SERVERSTARTED)};
while {!(FFA_GAMEENDED)} do
{
	sleep 10;
	{
		if ((count units _x)<1) then
		{			
			if (!(isNull _x)) then
			{
				deleteGroup _x;
			};
			if (isNull _x) then
			{
				FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK-[_x];
			};
		};
	}forEach FFA_ENEMYGROUPCHECK;

	{
		if( (((side  _x) != west) || !(isEngineOn _x) || !(alive _x)) && (((getPosATL _x) select 2)<5) ) then
		{
			if ((random 10) < 5.5) then
			{
				_x setDammage 1;
			};
			FFA_ENEMYHEIGHTCHECK=FFA_ENEMYHEIGHTCHECK-[_x];
			
			_item=_x getVariable "FFA_ANTIAIR";
			_cnt=count _item;
			if (_cnt > 0) then
			{							
				_value=((FFA_ANTIAIRAWARD-1*(_cnt-1)) max 1);
				for [{_i=0},{_i<_cnt},{_i=_i+1}] do
				{
					_AA=_item select _i;
					if (_AA isKindOf "man") then
					{
						_AA addScore _value;
						_AA setVariable ["FFA_ANTIAIRUNIT",true,true];
						[_x] spawn FFA_FUNC_REMEMSCORE;
					}
					else
					{
						if (!((typeOf _AA) in FFA_TOOGOODANTIAIR)) then {_value=_value+5;};
						{_x addScore _value; _x setVariable ["FFA_ANTIAIRUNIT",true,true]; [_x] spawn FFA_FUNC_REMEMSCORE;} forEach (crew _AA);
					};
				};							
			};
		};
	}forEach FFA_ENEMYHEIGHTCHECK;

	_cnt=count FFA_ENEMYCREWCHECK;
	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{
		_item=FFA_ENEMYCREWCHECK select _i;
		if(((vehicle  _item) == _item) || !(alive _item)) then
		{			
			_item setDammage 1;
			FFA_ENEMYCREWCHECK set [_i,objNull];
		}
		else
		{
			{_item reveal _x} forEach list TotalArea;
		};
	};
	FFA_ENEMYCREWCHECK=FFA_ENEMYCREWCHECK-[objNull];
	
	_currenttime=time;
	_baselist=list Base;
	_currenttown=getMarkerPos FFA_CURRENTTOWNMARKER;
	
	_cnt=count FFA_MARKEREDVEHICLES;
	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{	
		sleep 0.3;
		_item=FFA_MARKEREDVEHICLES select _i;

		_veh=_item select 0;
		_marker=_item select 1;

		_owner=_veh getVariable "FFA_OWNER";
		_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");
		
		_marker setMarkerPos position _veh;
		
		if (!(isNull _veh)) then
		{
			if (alive _veh) then
			{
				_crew=crew _veh;
				if ((({alive _x} count _crew))==0) then
				{
					if ((_veh in _baselist) || ((_veh distance _currenttown)<=1300) || (_veh isKindOf "BTR90_HQ")) then
					{
						_veh setVariable ["FFA_LASTUSEDTIME",_currenttime,false];
					}
					else
					{
						if ((_currenttime-(_veh getVariable "FFA_LASTUSEDTIME")) > (paramsArray select 4)) then
						{
							_veh setDamage 1;
						};
					};
				}
				else
				{
					_veh setVariable ["FFA_LASTUSEDTIME",_currenttime,false];
				};
				
				if (({(isPlayer _x) && (alive _x)} count _crew)==0) then
				{										
					if (_veh isKindOf "tank") then {_marker setMarkerType "o_armor";};
					if (_veh isKindOf "air") then {_marker setMarkerType "o_air";};
					if (_veh isKindOf "car") then {_marker setMarkerType "o_motor_inf";};
					if (_veh isKindOf "BTR90_HQ") then {_marker setMarkerType "City";_marker setMarkerSize [1, 1];};
					if (canMove _veh) then 
					{
						_marker setMarkerText format["%1 - %2",_name,_owner];
					}
					else
					{			
						_marker setMarkerText format["%1 - %2 [%3]",_name,_owner,localize "STR_MAP_Damaged"];
					};					
				}
				else
				{					
					_marker setMarkerType "Empty";
				};
			}
			else
			{				
				_marker setMarkerText format["%1 - %2 [%3]",_name,_owner,localize "STR_MAP_Destroyed"];							
			};
		}
		else
		{
			FFA_MARKEREDVEHICLES set [_i,objNull];
			deleteMarker _marker;
		};
	};
	FFA_MARKEREDVEHICLES=FFA_MARKEREDVEHICLES-[objNull];
		
	_cnt=count FFA_OBJECTSTOCLEAR;
	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{		
		_item=FFA_OBJECTSTOCLEAR select _i;
	
		_veh=_item select 0;
		if !(alive _veh) then
		{
			_deathtime=_item select 1;
			if (_deathtime==0) then
			{
				_deathtime=time;
				FFA_OBJECTSTOCLEAR set [_i,[_veh,_deathtime]];
			};
		
			if ((time-_deathtime)>FFA_DELETEBODIESTIMEOUT) then
			{
				_veh setPos [0,0,0];
				_veh removeAllEventHandlers "killed";
				_veh removeAllEventHandlers "IncomingMissile";
				_veh removeAllEventHandlers "HandleDamage";
				_veh removeAllEventHandlers "Hit";
				_veh removeAllEventHandlers "GetOut";
				_veh removeAllEventHandlers "Init";
				deleteVehicle _veh;
				FFA_OBJECTSTOCLEAR set [_i,objNull];
			};
		};		
	};	
	FFA_OBJECTSTOCLEAR=FFA_OBJECTSTOCLEAR-[objNull];
};