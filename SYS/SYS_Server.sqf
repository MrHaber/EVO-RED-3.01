#include "defines.sqf"
//when new player joins the server
FFA_FUNC_PLAYERCONNECTED=
{
	private["_name","_unit","_unituid","_nameunituid","_uidscore","_scoreunit","_i"];
	_name=_this select 0;
	_unituid=_this select 1;
	_unit=objNull;
	while {isNull _unit} do
	{
		{if (((name _x) == _name) && ((GetPlayerUID _x) == _unituid)) then {_unit = _x};} ForEach playableUnits;
	};
	if ((count units (group _unit)) > 1) then 
	{
		[_unit] join grpNull;
	};
	waitUntil{FFA_SERVERSTARTED};
	sleep 1;
  if (!(_unituid in FFA_JIPCLIENTS)) then
   {
   	_nameunituid=[_name,_unituid];
    _scoreunit=format ["%1",FFA_STARTPOINTS];
    _uidscore=[_unituid,_scoreunit];
    FFA_GAMELOGIC setVariable [format["SVE_%1",_unituid],toString FFA_UNLOCKEDWEAPONS,true];
    FFA_JIPCLIENTS=FFA_JIPCLIENTS + [_unituid];
    publicVariable "FFA_JIPCLIENTS";
    _unit addScore FFA_STARTPOINTS;
    {
     if ((_x select 0) == _name) then
     {
      while {((score _unit) < 0)} do 
     	 {
  	    _unit addscore 1;
  	   };
      while {((score _unit )> 0)} do 
     	 {
  	    _unit addscore -1;
  	   };
      _unit addscore FFA_STARTPOINTS;
     };
    } foreach FFA_JIPCLIENTSa;
    
    FFA_JIPCLIENTSa set [count FFA_JIPCLIENTSa,_nameunituid];
    FFA_JIPCLIENTSb set [count FFA_JIPCLIENTSb,_uidscore];
   }
   else
   {
	  while {((score _unit) < 0)} do
	  {
		 _unit addscore 1;
	  };
	  while {((score _unit) > 0)} do
	  {
	   _unit addscore -1;
	  };
	  {
	   if ((_x select 0) == _unituid) then
	    {
	     for "_i" from (-30) to 9000 step 1 do
       {
	      _scoreunit=format ["%1",_i];
	      if ((_x select 1)== _scoreunit) then
		    {
		     _unit addscore _i;
		     _i=9000;
		    };
	     };
	    }; 
    } foreach FFA_JIPCLIENTSb;
   };

   [] call FFA_FUNC_REFRESHMARKERS;
   if (local player) then
   {
	  FFA_GAMELOGIC globalChat format[localize "STR_RADIO_DedicatedConnect",_name];
   };
};
//when player leaves the server
FFA_FUNC_PLAYERDISCONNECTED=
{
	private["_name","_list","_i","_cnt","_unit","_useTotalArea","_marker","_body"];
	_name=_this select 0;
	_useTotalArea=_this select 1;
	_array=_this select 2;
	_list=[];
	
	if (_useTotalArea) then
	{
		_list=(list TotalArea);
	}
	else
	{
		_list=_this select 2;
	};
	
	_cnt=count _list;

	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{	
		_unit=_list select _i;
		_body=nearestObject[_unit,"Man"];
		if (alive _unit) then
		{
			if (_unit isKindof "Man") then
			{
				if (({isPlayer _x} count units (group _unit))==0) then
				{
					{_x setDammage 1} forEach units (group _unit);
					{_x setPos [0,0,0]} forEach units (group _unit);
				};
			}
			else
			{
				[_name,false,(crew _unit)] call FFA_FUNC_PLAYERDISCONNECTED;
			};
		};
		if (!isNull _body) then
		{
			if (!alive _body) then
			{
				_body removeAllEventHandlers "killed";
	      _body removeAllEventHandlers "IncomingMissile";
	      _body removeAllEventHandlers "HandleDamage";
	      _body removeAllEventHandlers "Hit";
	      _body removeAllEventHandlers "GetOut";
	      _body removeAllEventHandlers "Init";
	      _body setPos [0,0,0];
				deleteVehicle _body;
			};
		};
	};
	if (local player) then
	{
		FFA_GAMELOGIC globalChat format[localize "STR_RADIO_DedicatedDisconnect",_name];
	};
};
//refresh memory score
FFA_FUNC_REMEMSCORE=
{
 private["_unit","_unituid","_scoreunit"];
 _unit=_this select 0;
 if (isPlayer _unit) then
  {
   _unituid=GetPlayerUID _unit;
   _scoreunit=format ["%1",score _unit];
	  {
 	   if ((_x select 0) == _unituid) then
 		  {
 		   _x set [1,_scoreunit];
 		  };
	  } foreach FFA_JIPCLIENTSb;
	};
};
//clear server
FFA_FUNC_DESTROYALL=
{
	//kill all units on map
	{ 
	if (((side _x) == west) || ((side _x) == resistance)) 
	then {_x setdamage 1.0;} 
	} 
 	foreach allunits;

};

//add periodic income to players
FFA_FUNC_ADDINCOME=
{
	private["_unit","_i","_income","_players"];
	
	_players=playersNumber east;

  for "_i" from 1 to 40 step 1 do
	{
		if (!isNil {call compile format ["ES%1",_i]}) then
		{
		  _unit=[] call compile format ["ES%1",_i];
		  if (!(isNull _unit) && (isPlayer _unit)) then
		  {
   		 _income=FFA_PLAYERINCOME_A;

			 if ((score _unit) >= 20) then
			 {
				if (_players <= 24) then
				{ 
					_income=FFA_PLAYERINCOME_B;
				}
				else
				{
					_income=FFA_PLAYERINCOME_F;
				};
			 };
			 if ((score _unit) >= 30) then
			 {
				if (_players <= 21) then
				{ 
					_income=FFA_PLAYERINCOME_C;
				}
				else
				{
					_income=FFA_PLAYERINCOME_F;
				};
			 };
			 if ((score _unit) >= 40) then
			 {
				if (_players <= 18) then
				{ 
					_income=FFA_PLAYERINCOME_D;
				}
				else
				{
					_income=FFA_PLAYERINCOME_F;
				};
			 };
			 if ((score _unit) >= 50) then
			 {
				if (_players <= 15) then
				{ 
					_income=FFA_PLAYERINCOME_E;
				}
				else
				{
					_income=FFA_PLAYERINCOME_F;
				};
			 };
			 if ((score _unit) >= 60) then
			 {
				 _income=FFA_PLAYERINCOME_F;
			 };
			 _unit addScore _income;
			 [_unit] spawn FFA_FUNC_REMEMSCORE;
		  };
	  };
  };
	FFA_LASTINCOMETIME=time+FFA_INCOMETIMEOUT;
};
//Add waypoints to enemy group
FUNC_AddWaypoint=
{
	private["_group","_place","_radius","_checkradio","_w"];	

	_group=_this select 0;
	_place=_this select 1;
	_radius=_this select 2;
	_checkradio=_this select 3;

	_w=_group addWaypoint [_place,_radius];
	_w=_group addWaypoint [_place,_radius];
	_w=_group addWaypoint [_place,_radius];
	_w=_group addWaypoint [_place,_radius];
	if (({(vehicle _x) isKindOf "Air"} count units _group)>0) then {_w=_group addWaypoint [getMarkerPos "respawn_east",_radius];};
	if (_checkradio) then {_w=_group addWaypoint [getposATL FFA_RADIO,50];};
	_w=_group addWaypoint [_place,_radius];
	_w setWaypointType "cycle";
	_group setCombatMode "Red";	
};
//when player joins the server, set markers on the map for him
FFA_FUNC_REFRESHMARKERS=
{
	if (!FFA_CURRENTTOWNCAPTURED) then
	{
		"EnemyArea" setMarkerSize [500,500];
		"EnemyArea" setMarkerPos getMarkerPos FFA_CURRENTTOWNMARKER;
		if (alive FFA_RADIO) then
		{
			"RadioMarker" setMarkerPos getPosATL FFA_RADIO;
		};
	};	
};
//set dynamic weather on the server
FFA_FUNC_DYNAMICWEATHER=
{
	private ["_Weather","_ForeCast","_TimeToStayIdle","_time"];

	while{!(FFA_GAMEENDED)}do
	{
		_TimeToStayIdle=FFA_WEATHERCHANGEPERIOD+random(FFA_WEATHERCHANGEPERIOD);
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};

		_TimeToStayIdle=FFA_WEATHERCHANGEPERIOD+random(FFA_WEATHERCHANGEPERIOD*2);		
		_ForeCast=(1-FFA_WEATHERCHANGEVALUE)+random(FFA_WEATHERCHANGEVALUE);
		_TimeToStayIdle setOverCast _ForeCast;

		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};

		_TimeToStayIdle=FFA_WEATHERCHANGEPERIOD+random(FFA_WEATHERCHANGEPERIOD);
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};
		_TimeToStayIdle=FFA_WEATHERCHANGEPERIOD+random(FFA_WEATHERCHANGEPERIOD*2);
		_ForeCast=random(FFA_WEATHERCHANGEVALUE);
		_TimeToStayIdle setOverCast _ForeCast;		
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 1;
		};
	};
};
//transmit current weather state to clients
FFA_FUNC_WEATHERBROADCAST=
{
	sleep(1+random(1));
	while{!(FFA_GAMEENDED)}do
	{
		sleep 10;
		FFA_WEATHER=[time,fog,overcast,rain];
		publicVariable "FFA_WEATHER";
	};
};
//call attack to the base
FFA_FUNC_ATTACKBASE=
{
	private["_marker"];

	_marker=FFA_BASEATTACKSPAWNS select (round (random ((count FFA_BASEATTACKSPAWNS)-1)));
	
	[2+(round(random 2)),getMarkerpos "respawn_east",[_marker],150,200,0,0,true,true,false] call FFA_FUNC_CALLREINFORCEMENT;
};
//call reinforcement to the city
FFA_FUNC_CALLREINFORCEMENT=
{
	private["_waves","_destination","_spawnpoints","_infantryWPrange","_armorWPrange","_heliWPrange","_airWPrange","_enableArmor","_enableInfantry","_enableAir"];

	_waves=_this select 0;	
	_destination=_this select 1;
	_landspawnpoints=_this select 2;
	_infantryWPrange=_this select 3;
	_armorWPrange=_this select 4;
	_heliWPrange=_this select 5;
	_airWPrange=_this select 6;
	_enableArmor=_this select 7;
	_enableInfantry=_this select 8;
	_enableAir=_this select 9;
	
	if (_enableArmor && _enableInfantry) then
	{
		for [{_i=0},{_i<_waves},{_i=_i+1}] do	
		{
			_rnd=(round(random 6));
			if (_rnd >= 3) then
			{
				[objnull,_destination,_landspawnpoints,_infantryWPrange] call FFA_FUNC_REINFORCEINFANTRY;
			}
			else
			{
				[FFA_ENEMYARMOR,_destination,_landspawnpoints,_armorWPrange] call FFA_FUNC_REINFORCEARMOR;
			};
		};
	}
	else
	{
		if (_enableArmor) then
		{
			for [{_i=0},{_i<_waves},{_i=_i+1}] do	
			{
				[FFA_ENEMYARMOR,_destination,_landspawnpoints,_armorWPrange] call FFA_FUNC_REINFORCEARMOR;
			};
		};
		if (_enableInfantry) then
		{
			for [{_i=0},{_i<_waves},{_i=_i+1}] do	
			{
				[objnull,_destination,_landspawnpoints,_infantryWPrange] call FFA_FUNC_REINFORCEINFANTRY;
			};
		};
	};
		
	if ( (("Air" countType list WestAir)<(4+(floor ((playersNumber east)/5)))) && (_enableAir)) then
	{
		if  (_waves>0) then {
		for [{_i=0},{_i<_waves},{_i=_i+1}] do	
		{

			if ((random 10) < 5.0) then
			{
				[objnull,_destination,objnull,_airWPrange] call FFA_FUNC_REINFORCEAIR;
			};
			if ((random 10) < 10) then
			{
				[objnull,_destination,objnull,_heliWPrange] call FFA_FUNC_REINFORCEHELI;
			};
		};
		} else {

			if ((random 10) < 5.0) then
			{
				[objnull,_destination,objnull,_airWPrange] call FFA_FUNC_REINFORCEAIR;
			};
			if ((random 10) < 10) then
			{
				[objnull,_destination,objnull,_heliWPrange] call FFA_FUNC_REINFORCEHELI;
			};

		};

	};
};
//infantry reinforcements leaves their vehicle, when they are close enough to the destination point
FFA_FUNC_INFANTRYLEAVEAPC=
{	
	private["_veh","_group","_distance","_pos"];

	_veh=_this select 0;
	_group=_this select 1;
	_pos=_this select 2;

	_distance=350;

	while{(canMove _veh) && (alive _veh) && ((_veh distance _pos)>_distance)} do
	{
		sleep 5.0;
	};

	if ((_veh distance _pos)>_distance) exitWith{};

	(units _group) orderGetIn false;
	{unAssignVehicle _x} forEach (units _group);
};
//spawn AI defenders of the city
FFA_FUNC_TOWNGUARDS=
{
	
};
//create ENEMY units
FUNC_CreateUnit=
{
	private["_group","_location","_type","_radius","_skill","_new"];

	_group=_this select 0;	
	_location=_this select 1;	
	_type=_this select 2;	
	_radius=_this select 3;

	_new=_group createUnit [_type,_location,[],_radius,"NONE"];	
	_new setSkill 1;	
	_new addEventHandler ["killed","FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_this select 0,time]];[_this select 1]spawn FFA_FUNC_REMEMSCORE"];
	_new;
};
//create ENEMY vehicles
FUNC_CreateVehicle=
{	
	private["_group","_location","_type","_radius","_new","_veh","_crew"];	

	_group=_this select 0;	
	_location=_this select 1;	
	_type=_this select 2;	
	_radius=_this select 3;	
		
	_veh=createVehicle [_type, _location, [], _radius, "FLY"];
		
  FFA_CLEARENEMYVEH=FFA_CLEARENEMYVEH+[_veh];
	FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_veh,0]];
	_veh setVariable ["FFA_OWNER","",true];
	_veh setVariable ["FFA_REPAIRKITS",1,true];
	_veh addEventHandler ["killed","[_this select 1]spawn FFA_FUNC_REMEMSCORE"];
	if (_veh isKindOf "MtvrRepair") then
	{
		_veh setRepairCargo 0;
	};

#ifndef __USE_ACE__
	[_veh,true] call FFA_FUNC_HANDLEATGMDEFENCE;
#endif
	
	_crew = getText (configFile >> "CfgVehicles" >> _type >> "crew");		

	if((_veh emptyPositions "commander") > 0) then 	
	{		
		_new=_group createUnit [_crew,_location,[],0,"NONE"];		
		_new moveinCommander _veh;		
		_new setSkill 1;
		_new addEventHandler ["killed","FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_this select 0,time]];[_this select 1]spawn FFA_FUNC_REMEMSCORE"];
	};

	if((_veh emptyPositions "gunner") > 0) then
 	{
		_new=_group createUnit [_crew,_location,[],0,"NONE"];
		_new moveinGunner _veh;
		_new setSkill 1;
		_new addEventHandler ["killed","FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_this select 0,time]];[_this select 1]spawn FFA_FUNC_REMEMSCORE"];
	};

	if((_veh emptyPositions "driver") > 0) then 	
	{
		_new=_group createUnit [_crew,_location,[],0,"NONE"];
		_new moveinDriver _veh;
		_new setSkill 1;
		_new addEventHandler ["killed","FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_this select 0,time]];[_this select 1]spawn FFA_FUNC_REMEMSCORE"];
	};

	_veh	
};
//base shelling
FFA_FUNC_SHELLING=
{
	private["_pos","_cnt","_range","_px","_py","_shell","_i"];

	_pos=_this select 0;
	_cnt=_this select 1;
	_range=_this select 2;
	_ammo=_this select 3;

	_px=_pos select 0;
	_py=_pos select 1;

	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{
		_shell=createVehicle [_ammo,[_px,_py,100],[],_range,""];
		_shell setVectorUp [0, -90, 0];
		_shell setVelocity [0,0,-100];
		//[_shell] spawn FFA_FUNC_SPAWNSHELLTRAIL;
		//sleep (random 2);
		sleep (random 1);
	};
};
FFA_FUNC_SPAWNSHELLTRAIL=
{
	private ["_shell","_trail"];

	if (isNull(player)) exitWith {};

	_shell = _this select 0;

	_trail = "#particlesource" createVehicleLocal getposATL _shell;
	_trail setParticleRandom [0.25, [0.25, 0.002, 0.25], [0.1, 0, 0.1], 0, 0, [0, 0, 0, 0.2], 0.5, 0.5];
       	_trail setDropInterval 0.0012;
	_trail setParticleParams [
		["\ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48],
		"", "Billboard", 1, 1, 
		[0,0,0], [0,0,0], 
		0, 0.3, 0.1, 0.3, 
		[0.75, 1.3], 
		[[1, 1, 1, 0.06],[1, 1, 1, 0.08],[1, 1, 1, 0.04],[1, 1, 1, 0]], [100], 100, 0, "", "", _shell, 0];

	_trail attachTo [_shell, [0,0,0]];

	while{!(isNull _shell)} do
	{
		sleep 1;
	};

	deleteVehicle _trail;	
};
//airborne attack to players base
FFA_FUNC_CALLAIRBORNE=
{
	private["_count","_cnt","_ingroup","_group","_where","_i","_unittype","_typecount"];
	
	_where=getMarkerPos "air_03";

	_group = createGroup (west);	
	_veh=[_group,_where,"MV22",50] call FUNC_CreateVehicle;
	_veh setPos [getposATL _veh select 0,getPosATL _veh select 1, 500];
	
	_veh setVelocity[0,500,0];
	
#ifdef __USE_ACE__
	if (!ACE_Countermeasures) then
	{
		_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,500] spawn FFA_FUNC_MISSILEDEFENCE}]";
		processInitCommands;
	};
#else
	_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,500] spawn FFA_FUNC_MISSILEDEFENCE}]";
	processInitCommands;
#endif
	
	_group SetBehaviour "careless";
	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];

	_count=2;
	_typecount=(count FFA_ENEMYINFANTRY)-1;
	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
	{
		_ingroup=7+(random 3);
		_group = createGroup (west);		
		for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
		{
			_unittype=FFA_ENEMYINFANTRY select (round random _typecount);
			[_group,_where,_unittype,50] call FUNC_CreateUnit;
			sleep 0.25;
		};
		[_group,getMarkerPos "respawn_east",250,false] call FUNC_AddWaypoint;
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
		{_x moveInCargo _veh} forEach (units _group);
		sleep 0.25;	
	};	
	_where=getMarkerPos "airborne";
	_veh setPos [_where select 0,_where select 1,200];	
	_veh setDir 320;
	_veh flyInHeight 150;
	_where=getMarkerPos "airbornewp1";	
	(group _veh) addWaypoint [_where,50];
	(group _veh) addWaypoint [getMarkerPos "airbornewp2",50];
	
	waitUntil{((_veh distance _where)<550) || !(alive _veh)};

	if (alive _veh) then
	{
		_crew=crew _veh-[driver _veh];		
		{
			_x action ["eject",_veh];
			unAssignVehicle _x;
		//	[_x] spawn FFA_FUNC_ACTPARA;
			sleep 0.25;
		}forEach _crew;
	};
	
	sleep 30;

	_veh setDammage 1;
};
FFA_FUNC_CALLAIRBORNE_CITY=
{
	private["_count","_cnt","_ingroup","_group","_where","_i","_unittype","_typecount","_veh","_group1","_group2"];
	
	_where=getMarkerPos (["air_01","air_02","air_03"] select (round (random 1)));

	_group = createGroup (west);
	
	if ((random 10)>9) then
{	
	_veh=[_group,_where,"MV22",50] call FUNC_CreateVehicle;
}
	else
{	
	_veh=[_group,_where,"C130J",50] call FUNC_CreateVehicle;
};

	_veh setPos [getposATL _veh select 0,getPosATL _veh select 1, 700];
	
	_veh setVelocity[0,300,0];
	
	_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,500] spawn FFA_FUNC_MISSILEDEFENCE}]";
	processInitCommands;
	
	_group SetBehaviour "careless";
	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	FFA_ENEMYCREWCHECK=FFA_ENEMYCREWCHECK+(crew _veh);

	_typecount=(count FFA_ENEMYINFANTRY)-1;

		_ingroup=7+(random 3);
		_group1 = createGroup (west);		
		for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
		{
			_unittype=FFA_ENEMYINFANTRY select (round random _typecount);
			[_group1,_where,_unittype,50] call FUNC_CreateUnit;
			sleep 0.25;
		};
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group1];
		{_x moveInCargo _veh} forEach (units _group1);
		sleep 0.1;	

		_ingroup=7+(random 3);
		_group2 = createGroup (west);		
		for [{_i=0},{_i<_ingroup},{_i=_i+1}] do
		{
			_unittype=FFA_ENEMYINFANTRY select (round random _typecount);
			[_group2,_where,_unittype,50] call FUNC_CreateUnit;
			sleep 0.25;
		};
		FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group2];
		{_x moveInCargo _veh} forEach (units _group2);
		sleep 0.1;	



	_veh flyInHeight (200+(random 200));

	(group _veh) addWaypoint [getMarkerpos "EnemyArea",100];
	
	waitUntil{((_veh distance (getPos FFA_WESTSENSOR))<1000) || !(alive _veh)};
	
	sleep 3;

	if (alive _veh) then
	{
		{
			_x action ["eject",_veh];
			unAssignVehicle _x;
			sleep 0.1;
		}forEach (units _group1);
		[_group1, (getMarkerpos "EnemyArea"), 350,false] call FUNC_AddWaypoint;

		{
			_x action ["eject",_veh];
			unAssignVehicle _x;
			sleep 0.1;
		}forEach (units _group2);
		[_group2, (getMarkerpos "EnemyArea"), 350,false] call FUNC_AddWaypoint;
	};

	sleep 5;

	(group _veh) addWaypoint [_where,100];

	sleep 15;

	_veh setDammage 1;
};
//call airplane reinforcement
FFA_FUNC_REINFORCEAIR=
{
	private["_position","_cnt","_group","_insertion","_type","_veh","_w0","_w1","_w2","_w3","_w4","_w5"];	

	_position=_this select 1;
	_patrolrange=_this select 3;

	_cnt=(count FFA_ENEMYAIR)-1;
	_cnt=(round random _cnt);

	_group = createGroup (west);
	_insertion=getMarkerPos (["air_01","air_02","air_03"] select (round (random 2)));

	_type=(FFA_ENEMYAIR select _cnt) select 0;

	_veh=[_group,_insertion,_type,50] call FUNC_CreateVehicle;
	_veh setPos [getposATL _veh select 0,getPosATL _veh select 1, 50];
	_veh setVelocity[0,100,0];
	
	_veh setVariable ["FFA_FLARESTIME",0,true];
	_veh setVariable ["FFA_ANTIAIR",[]];
	(driver _veh) addEventHandler ["HandleDamage",{private["_AA","_veh","_unit"];_unit=_this select 0;_AA=_this select 3;_projectile=_this select 4;_veh=vehicle _unit;_unit setHit [(_this select 1),(_this select 2)];if ((_veh!=_unit) && (isPlayer _AA)) then {if ((_AA isKindOf "man") && !(_projectile in FFA_ROCKETS)) exitWith{};_Attackers=_veh getVariable "FFA_ANTIAIR";if !(_AA in _Attackers) then {_veh setVariable ["FFA_ANTIAIR",_Attackers+[_this select 3]]};};}];

#ifdef __USE_ACE__
	if (!ACE_Countermeasures) then
	{
		_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,3500] spawn FFA_FUNC_MISSILEDEFENCE}]";
		processInitCommands;
	};
#else
	_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,3500] spawn FFA_FUNC_MISSILEDEFENCE}]";
	processInitCommands;
#endif

	{_veh removeWeapon _x} forEach (weapons _veh);
	{_veh removeMagazines _x} forEach (magazines _veh);
	{_veh addMagazine _x} forEach ((FFA_ENEMYAIR select _cnt) select 1);
	{_veh addWeapon _x} forEach ((FFA_ENEMYAIR select _cnt) select 2);

	_group setCombatMode "Red";
	if ((random 10)<5) then
	{
		_veh flyInHeight (200+(random 800));
	};
	[_group,_position,_patrolrange,false] call FUNC_AddWaypoint;

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	FFA_ENEMYHEIGHTCHECK=FFA_ENEMYHEIGHTCHECK+[_veh];
	FFA_ENEMYCREWCHECK=FFA_ENEMYCREWCHECK+(crew _veh);

	_veh
};
FFA_FUNC_REINFORCEARMOR=
{
	//Call armor reinforcement

	private["_armortypes","_position","_locations","_cnt","_group","_insertion","_type","_veh"];

	_armortypes=_this select 0;	
	_position=_this select 1;
	_locations=_this select 2;
	_patrolrange=_this select 3;

	_cnt=(count _armortypes)-1;

	_group=createGroup (west);
	_insertion=getMarkerPos (_locations select (round (random ((count _locations)-1))));
	_type=_armortypes select (round random _cnt);

	_veh=[_group,_insertion,_type,50] call FUNC_CreateVehicle;

	[_group,_position,_patrolrange,false] call FUNC_AddWaypoint;

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];

	_veh
};
//call helicopter reinforceent
FFA_FUNC_REINFORCEHELI=
{
	private["_position","_cnt","_group","_insertion","_type","_veh","_w0"];	

	_position=_this select 1;
	_patrolrange=_this select 3;

	_cnt=(count FFA_ENEMYHELI)-1;

	_group = createGroup (west);
	_insertion=getMarkerPos (["Heli_01","Heli_02","Heli_03","Heli_04","Heli_05","Heli_06"] select (round (random 5)));

	_type=FFA_ENEMYHELI select (round random _cnt);
	_veh=[_group,_insertion,_type,50] call FUNC_CreateVehicle;

	_veh setVariable ["FFA_FLARESTIME",0,true];
	_veh setVariable ["FFA_ANTIAIR",[]];
	(driver _veh) addEventHandler ["HandleDamage",{private["_AA","_veh","_unit"];_unit=_this select 0;_AA=_this select 3;_projectile=_this select 4;_veh=vehicle _unit;_unit setHit [(_this select 1),(_this select 2)];if ((_veh!=_unit) && (isPlayer _AA)) then {if ((_AA isKindOf "man") && !(_projectile in FFA_ROCKETS)) exitWith{};_Attackers=_veh getVariable "FFA_ANTIAIR";if !(_AA in _Attackers) then {_veh setVariable ["FFA_ANTIAIR",_Attackers+[_this select 3]]};};}];

#ifdef __USE_ACE__
	if (!ACE_Countermeasures) then
	{
		_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,3500] spawn FFA_FUNC_MISSILEDEFENCE}]";
		processInitCommands;
	};
#else
	_veh setVehicleInit "this addEventHandler [""incomingmissile"",{[_this select 0,_this select 1,_this select 2,3500] spawn FFA_FUNC_MISSILEDEFENCE}]";
	processInitCommands;
#endif

	_group selectLeader (driver _veh);

	_w0=_group addWaypoint [getPosATL _veh,500];

	(driver _veh) action ["EngineOn",_veh];

	[_group,_position,_patrolrange,false] call FUNC_AddWaypoint;

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
	FFA_ENEMYHEIGHTCHECK=FFA_ENEMYHEIGHTCHECK+[_veh];
	FFA_ENEMYCREWCHECK=FFA_ENEMYCREWCHECK+(crew _veh);

	_veh;
};
FFA_FUNC_REINFORCEINFANTRY=
{
	
//call infantry reinforcement

	private["_position","_veh","_cnt","_group","_type","_insertion"];
	
	_position=_this select 1;
	_locations=_this select 2;
	_patrolrange=_this select 3;

	//_veh=[FFA_ENEMYAPC,_position,_locations,300] call FFA_FUNC_REINFORCEARMOR;
	
//=========create an APC=========
	_cnt=(count FFA_ENEMYAPC)-1;

	_group=createGroup (west);
	_insertion=getMarkerPos (_locations select (round (random ((count _locations)-1))));
	_type=FFA_ENEMYAPC select (round random _cnt);

	_veh=[_group,_insertion,_type,50] call FUNC_CreateVehicle;

	[_group,_position,_patrolrange,true] call FUNC_AddWaypoint;

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];
//==============================

	_cnt=(count FFA_ENEMYINFANTRY)-1;	

	_group=createGroup (west);
	
	_type=FFA_ENEMYINFANTRY select (round random _cnt);	
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;
	_type=FFA_ENEMYINFANTRY select (round random _cnt);
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;
	_type=FFA_ENEMYINFANTRY select (round random _cnt);	
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;
	_type=FFA_ENEMYINFANTRY select (round random _cnt);
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;
	_type=FFA_ENEMYINFANTRY select (round random _cnt);
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;
	_type=FFA_ENEMYINFANTRY select (round random _cnt);
	[_group,getPosATL _veh,_type,50] call FUNC_CreateUnit;

	{_x moveInCargo _veh} forEach units _group;
	[_group,_position,_patrolrange,true] call FUNC_AddWaypoint;

	FFA_ENEMYGROUPCHECK=FFA_ENEMYGROUPCHECK+[_group];

	[_veh,_group,_position] spawn FFA_FUNC_INFANTRYLEAVEAPC;
};
FFA_FUNC_UNITREQUEST=
{
	//if player wants to buy a unit..

	private["_unit","_d1","_d2","_pX","_pY","_dir","_id","_leader"];	
	_d1=_this select 1;
	_d2=_this select 2;
	
	_pX=_this select 4;
	_pY=_this select 5;
	_dir=_this select 6;
	_id=_this select 7;

	_leader=[] call compile format ["ES%1",_id];

	_d1=_d1-1;
	_d2=_d2-1;

	_unit=(group _leader) createUnit [((((FFA_WEAPONS select _d1) select 3) select _d2) select 0),[0,0,0],[],5,"FORM"];
	_unit setPos [_px,_py,0];
	_unit setSkill 0.9;

	FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_unit,0]];
	
    _unit setVehicleInit  "This addEventHandler [""Killed"",""_this spawn TKL_Killed""]";
    processInitCommands;
    sleep 0.1;
    
	_unit setVariable["FFA_LIFESTATE",0,true];
};
FFA_FUNC_VEHICLEREQUEST=
{
	//if player wants to buy a vehicle

	private["_veh","_type","_pX","_pY","_dir","_name"];	

	_type=_this select 1;
	_pX=_this select 3;
	_pY=_this select 4;
	_dir=_this select 5;
	_name=_this select 6;

	_veh=createVehicle [((FFA_FRIENDLYVEHICLES select (_type-1)) select 0),[_px+15*sin _dir,_py+10*cos _dir,0],[],0,"None"];
	_veh setDir _dir+180;
	
	//=====
	_marker=createMarker[format["%1",_veh],position _veh];
	_marker setMarkerColor "ColorRed";
	_marker setMarkerSize [0.5, 0.5];
	FFA_MARKEREDVEHICLES set [count FFA_MARKEREDVEHICLES,[_veh,_marker]];
	FFA_OBJECTSTOCLEAR set [count FFA_OBJECTSTOCLEAR,[_veh,0]];
	//=====
	
	_veh setVehicleInit "this addEventHandler [""killed"",""_this spawn FFA_FUNC_CUSTOMVEHICLEKILLED""]";
	if (_veh isKindOf "Air") then
	{
		_veh setVehicleInit "this addEventHandler [""GetIn"",""_this spawn FFA_FUNC_ADDACTPARA""]";
	};
	if ((typeOf _veh) in FFA_CAMVEH) then 
	{
		_veh setVehicleInit "[this] execVM ""CamMissle\action_misslecam.sqf""";
	};
	processInitCommands;

#ifndef __USE_ACE__
	[_veh] call FFA_FUNC_HANDLEMISSILEDEFENCE;
	[_veh,false] call FFA_FUNC_HANDLEATGMDEFENCE;
#endif

	_veh setVariable ["FFA_OWNER",_name,true];
	_veh setVariable ["FFA_REPAIRKITS",3,true];
	
	

	if (_veh isKindOf "BMP2_HQ_INS") then
	{
		_veh setRepairCargo 0;
	};
	if (_veh isKindOf "MV22") then
	{
		_veh setRepairCargo 0;
	};
	if (_veh isKindOf "CH_47F_BAF") then
	{
		_veh setAmmoCargo 0;
	};
	if (_veh isKindOf "Mi24_V") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "GSh23L";
		_veh addWeapon "AT9Launcher";
		_veh addWeapon "S8Launcher";
		_veh addMagazine "520Rnd_23mm_GSh23L";
		_veh addMagazine "4Rnd_AT9_Mi24P";
		_veh addMagazine "40Rnd_80mm";
	};
	if (_veh isKindOf "Mi24_P") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "GSh302";
		_veh addWeapon "AT6Launcher";
		_veh addMagazine "750Rnd_30mm_GSh301";
		_veh addMagazine "4Rnd_AT6_Mi24V";	
	};
        if (_veh isKindOf "Su39") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "CMFlareLauncher";
	      _veh addWeapon "GSh301";
		_veh addWeapon "VikhrLauncher";
		_veh addWeapon "S8Launcher";
		_veh addWeapon "R73Launcher_2";
		_veh addMagazine "120Rnd_CMFlareMagazine";
		_veh addMagazine "180Rnd_30mm_GSh301";
		_veh addMagazine "12Rnd_Vikhr_KA50";
		_veh addMagazine "40Rnd_80mm";
		_veh addMagazine "40Rnd_80mm";
		_veh addMagazine "2Rnd_R73";
		_veh addMagazine "2Rnd_R73";
		_veh addMagazine "2Rnd_R73";
	};
	if (_veh isKindOf "Ka52") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "CMFlareLauncher";
	      _veh addWeapon "2A42";
		_veh addWeapon "VikhrLauncher";
		_veh addMagazine "120Rnd_CMFlareMagazine";
		_veh addMagazine "250Rnd_30mmHE_2A42";
		_veh addMagazine "250Rnd_30mmHE_2A42";
		_veh addMagazine "12Rnd_Vikhr_KA50";		
	};     
	if (_veh isKindOf "Ka52Black") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "CMFlareLauncher";
	      _veh addWeapon "2A42";
		_veh addWeapon "VikhrLauncher";
		_veh addWeapon "Igla_twice";
		_veh addMagazine "120Rnd_CMFlareMagazine";
		_veh addMagazine "250Rnd_30mmHE_2A42";
		_veh addMagazine "250Rnd_30mmHE_2A42";
		_veh addMagazine "12Rnd_Vikhr_KA50";
		_veh addMagazine "2Rnd_Igla";
		_veh addMagazine "2Rnd_Igla";
	}; 
	if (_veh isKindOf "C130J") then
	{
		{_veh removeWeapon _x} forEach (weapons _veh);
	    {_veh removeMagazines _x} forEach (magazines _veh);
	      _veh addWeapon "CMFlareLauncher";
	      _veh addWeapon "Mk82BombLauncher_6";
		_veh addWeapon "GAU8";
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
		_veh addWeapon "CMFlareLauncher";
	};
	if (_veh isKindOf "Old_bike_TK_CIV_EP1") then
	{
		_veh setVehicleInit " [this]execVM ""Bike_DEL.sqf"""; 
		processInitCommands;
	};
	if (_veh isKindOf "Old_moto_TK_Civ_EP1") then
	{
		_veh setVehicleInit " [this]execVM ""Bike_DEL.sqf"""; 
		processInitCommands;
	};
	if (_veh isKindOf "ATV_CZ_EP1") then
	{
		_veh setVehicleInit " [this]execVM ""Bike_DEL.sqf"""; 
		processInitCommands;
	};
	if (_veh isKindOf "Pchela1T") then
	{
		_veh addMagazine "60Rnd_CMFlareMagazine";
		_veh addWeapon "CMFlareLauncher";
	};
};