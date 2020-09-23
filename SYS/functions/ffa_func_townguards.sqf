	#include "defines.sqf"
	
	private["_dir","_py","_px","_i","_x","_y","_town","_marker","_typecount","_typecountaa","_typecountrep","_typecountinf","_Loc1","_Loc2","_Loc3","_Loc4","_count","_cnt","_ingroup","_group","_where","_veh","_vehObs","_location1"];

	_town=_this select 0;
	_marker=getMarkerpos _town;

	_typecount=(count FFA_ENEMYINFANTRY)-1;

	_Loc1 = [(_marker select 0)+100,(_marker select 1), 0];
	_Loc2 = [(_marker select 0),(_marker select 1)+100, 0];
	_Loc3 = [(_marker select 0)-100,(_marker select 1), 0];
	_Loc4 = [(_marker select 0),(_marker select 1)-100, 0];
	_Loc=[_Loc1,_Loc2,_Loc3,_Loc4];

#ifdef __USE_ACE__
	_count=2+(floor ((playersNumber east)/6));
#else
	_count=1+(floor ((playersNumber east)/6));
#endif

	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
	{
		_ingroup=4+(random 4);
		_group = createGroup (west);
		_where=_Loc select (round (random ((count _Loc)-1)));
		for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
		{
			_unittype=FFA_ENEMYINFANTRY select (round random _typecount);
			[_group,_where,_unittype,50] call FUNC_CreateUnit;
			sleep 0.25;
		};
		[_group,_marker,320,true] call FUNC_AddWaypoint;
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
		sleep 0.25;
	};

#ifdef __USE_ACE__
	_count=3+(floor ((playersNumber east)/6));
#else
	_count=5+(floor ((playersNumber east)/5));
#endif
	
	_typecount=(count FFA_ENEMYVEHICLES)-1;
	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
	{
		_group = createGroup (west);
		_where=_Loc select (round (random ((count _Loc)-1)));
		_unittype=FFA_ENEMYVEHICLES select (round random _typecount);
		[_group,_where,_unittype,50] call FUNC_CreateVehicle;
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
		[_group,_marker,400,false] call FUNC_AddWaypoint;
		sleep 0.25;
	};
//---------------------------Антены фейковые ---------------------
 _count=1;

	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
 	{
		_veh= createVehicle ["Land_Antenna", [((_marker select 0)+(random 700)-250),((_marker select 1)+(random 700)-250)], [], 0, "FLY"];
		_location1 = GetPosATL _veh;

		while {surfaceIsWater _location1} do
		{
			_x=(_location1 select 0) - 25;
			_y=(_location1 select 1) + 25;
			_location1 set [0, _x];
			_location1 set [1, _y];
		};
	
		_location1 set [0, ((_location1 select 0) - 25)];
		_location1 set [1, ((_location1 select 1) + 25)];

		_veh SetPosATL _location1;
	
		sleep 0.1;
		_veh setDir (round random 360);
		_veh allowDamage true;
		FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_veh];
	};
	
 _count=1;

	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
 	{
		_veh= createVehicle ["Land_Antenna", [((_marker select 0)+(random 600)-150),((_marker select 1)+(random 600)-150)], [], 0, "FLY"];
		_location1 = GetPosATL _veh;

		while {surfaceIsWater _location1} do
		{
			_x=(_location1 select 0) - 25;
			_y=(_location1 select 1) + 25;
			_location1 set [0, _x];
			_location1 set [1, _y];
		};
	
		_location1 set [0, ((_location1 select 0) - 25)];
		_location1 set [1, ((_location1 select 1) + 25)];

		_veh SetPosATL _location1;
	
		sleep 0.1;
		_veh setDir (round random 360);
		_veh allowDamage true;
		FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_veh];
	};

 _count=1;

	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
 	{
		_veh= createVehicle ["Land_Antenna", [((_marker select 0)+(random 400)-100),((_marker select 1)+(random 200)-100)], [], 0, "FLY"];
		_location1 = GetPosATL _veh;

		while {surfaceIsWater _location1} do
		{
			_x=(_location1 select 0) - 25;
			_y=(_location1 select 1) + 25;
			_location1 set [0, _x];
			_location1 set [1, _y];
		};
	
		_location1 set [0, ((_location1 select 0) - 25)];
		_location1 set [1, ((_location1 select 1) + 25)];

		_veh SetPosATL _location1;
	
		sleep 0.1;
		_veh setDir (round random 360);
		_veh allowDamage true;
		FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_veh];
	};
 _count=1;

	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
 	{
		_veh= createVehicle ["Land_Antenna", [((_marker select 0)+(random 500)-150),((_marker select 1)+(random 500)-150)], [], 0, "FLY"];
		_location1 = GetPosATL _veh;

		while {surfaceIsWater _location1} do
		{
			_x=(_location1 select 0) - 25;
			_y=(_location1 select 1) + 25;
			_location1 set [0, _x];
			_location1 set [1, _y];
		};
	
		_location1 set [0, ((_location1 select 0) - 25)];
		_location1 set [1, ((_location1 select 1) + 25)];

		_veh SetPosATL _location1;
	
		sleep 0.1;
		_veh setDir (round random 360);
		_veh allowDamage true;
		FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_veh];
	};
// _-------------------AVENDGERS____________________________________	
_count=2+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"HMMWV_Avenger",0] call FUNC_CreateVehicle;
      _veh setFuel 0 ;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
	sleep 0.1;

_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [0,9,-1]) select 0,(_veh modelToWorld [0,9,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [-7,3.1,-1]) select 0,(_veh modelToWorld [-7,3.1,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+100);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [7,3.1,-1]) select 0,(_veh modelToWorld [7,3.1,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+260);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;	
};
	//___________________________STATIC 2__________________________________________
_count=1+(floor ((playersNumber east)/10));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"DSHKM_TK_GUE_EP1",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
	//___________________________STATIC 3__________________________________________
_count=1+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"SPG9_TK_GUE_EP1",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
	//___________________________STATIC 4__________________________________________
_count=1+(floor ((playersNumber east)/10));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"MK19_TriPod",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
	//___________________________STATIC 5__________________________________________
_count=1+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"TOW_TriPod",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
//___________________________STATIC 6__________________________________________
_count=2+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"Stinger_Pod",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
	sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
		_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
//___________________________STATIC 7__________________________________________
_count=2+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"ZU23_TK_GUE_EP1",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
//___________________________STATIC 8__________________________________________
_count=1+(floor ((playersNumber east)/15));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"M2StaticMG_US_EP1",0] call FUNC_CreateVehicle;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
		sleep 0.1;
_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,1,1]) select 0,(_veh modelToWorld [0,1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [-2,-1,1]) select 0,(_veh modelToWorld [-2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+80);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [2,-1,1]) select 0,(_veh modelToWorld [2,-1,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+280);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_vehObs=createVehicle ["Land_BagFenceRound", [(_veh modelToWorld [0,-3,1]) select 0,(_veh modelToWorld [0,-3,1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+360);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
	
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;
};
//___________________________URAL ZU__________________________________________
_count=2+(floor ((playersNumber east)/5));

for [{_cnt=1},{_cnt<_count},{_cnt=_cnt+1}] do
{
	_group = createGroup (west);
	_veh=[_group,[((_marker select 0)+(random 850)-500),((_marker select 1)+(random 850)-500)],"Ural_ZU23_GUE",0] call FUNC_CreateVehicle;
      _veh setFuel 0 ;
		_px=_marker select 0;
		_py=_marker select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		_dir = (_dir - (getDir _veh))+180;
		_veh setDir _dir;
	sleep 0.1;

_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [0,9,-1]) select 0,(_veh modelToWorld [0,9,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+180);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [-7,3.1,-1]) select 0,(_veh modelToWorld [-7,3.1,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+100);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;

	_vehObs=createVehicle ["Land_fort_rampart", [(_veh modelToWorld [7,3.1,-1]) select 0,(_veh modelToWorld [7,3.1,-1]) select 1], [], 0, "CAN_COLLIDE"];
	_vehObs setDir ((getDir _veh)+260);
	_vehObs allowDamage false;
	FFA_FORTSTOCLEAR=FFA_FORTSTOCLEAR+[_vehObs];
	sleep 0.1;
		
	_where=getPosATL _veh;
	_typecountinf=(count FFA_ENEMYINFANTRY)-1;	

	_ingroup=1+(random 2);
	for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
	{
		_unittype=FFA_ENEMYINFANTRY select (round random _typecountinf);			
		[_group,_where,_unittype,50] call FUNC_CreateUnit;
		sleep 0.1;
	};

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	sleep 0.2;	
};
	//------------------------------------------------------------------------
#ifdef __USE_ACE__
	_count=2+(floor ((playersNumber east)/6));
#else
	_count=3+(floor ((playersNumber east)/5));
#endif
    FFA_ENEMYAMMOCHECK=[];
	_typecount=(count FFA_ENEMYINFANTRY)-1;	
	_typecountaa=(count FFA_ENEMYAA)-1;	
	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
	{
		_group = createGroup (west);
		_unittype=FFA_ENEMYAA select (round random _typecountaa);
		_veh=[_group,_marker,_unittype,800] call FUNC_CreateVehicle;
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
		FFA_ENEMYAMMOCHECK=FFA_ENEMYAMMOCHECK+[_veh];
	
		_where=getPosATL _veh;

		_ingroup=1+(random 2);
		for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
		{
			_unittype=FFA_ENEMYINFANTRY select (round random _typecount);			
			[_group,_where,_unittype,50] call FUNC_CreateUnit;
			sleep 0.25;
		};
	};
	
	FFA_TOWNGUARDSSPAWNED=true;
