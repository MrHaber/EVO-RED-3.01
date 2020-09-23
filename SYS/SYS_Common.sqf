#include "defines.sqf"
//AI and Players`s "Incomingmissile" eventhandler
FFA_FUNC_MISSILEDEFENCE=
{
	private["_air","_ammo","_ammotype","_antiair","_dist","_mindist","_zerodist","_activatedist","_chance","_flares"];
	_air=_this select 0;
	_ammotype=_this select 1;
	_antiair=_this select 2;
	_zerodist=_this select 3;
	_ammo=nearestObject [_antiair,_ammotype];
	_dist=_ammo distance _air;
	_mindist=200;
	_activatedist=100;
	if ((side _air)==east) then
	{
		_activatedist=200;
		_flares=_air getVariable "FFA_FLARESLEFT";
		_air setVariable ["FFA_FLARESLEFT",_flares-1,true];
		if (((typeOf _air) in FFA_MI24CHOPPERS) && (_ammotype in FFA_AASAIR)) then
		{
			_zerodist=_zerodist*0.80;
		};
		if (((typeOf _air) in FFA_MI24CHOPPERS) && (_ammotype in FFA_AASHOULDER)) then
		{
			_zerodist=_zerodist*0.65;
		};
	}
	else
	{
		if (_ammotype in FFA_AASHOULDER) then
		{
			_zerodist=_zerodist*0.60;
		};
	};
	if (_dist>_mindist) then
	{
		_chance=(1 min (_dist/_zerodist));
		if ((random 1)<_chance) then
		{
			waitUntil{((_ammo distance _air)<=_activatedist) || (isNull _ammo)};
			switch (side _air) do
			{
				case west:
				{
					deleteVehicle _ammo;
				};
				case east:
				{
					if (_flares > 0) then
					{
						deleteVehicle _ammo;
					}
				};
				default{};
			};
		};
	};
	[_air] call FFA_FUNC_DROPFLARES;
};
//Long-jump from aircraft
FFA_FUNC_ACTPARA=
{
	private["_unit","_pos","_chute"];

	_unit=_this select 0;

	if (!(local _unit)) exitWith{};

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
		if (isPlayer _unit) then
		{
			waitUntil{(((getPosATL _unit) select 2) < 80)};	
	
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
		}
		else
		{
			_pos=getPos _unit;
			_chute="Parachute" createVehicle [0,0,0];
			_chute setPos [_pos select 0,_pos select 1,(_pos select 2)+5];
			_chute setDir (getDir _unit);
			_unit moveInDriver _chute;
			waitUntil{(((getPosATL _unit) select 2) < 12) || !(alive _unit) || (isNull _unit)};
			sleep 5;
			deleteVehicle _chute;
		};
	};
};
//Players`s vehicles "Killed" eventhandler
FFA_FUNC_CUSTOMVEHICLEKILLED=
{
	private ["_object","_killer"];
	_object=_this select 0;
	_killer=_this select 1;
	
	if ( (side _killer==east) || (isPlayer _killer) ) then 
	{
		if (!(isPlayer _killer)) then 
		{
			(leader _killer) setVariable ["FFA_VEHICLEKILLED",_object,true]
		}
		else 
		{
			_killer setVariable ["FFA_VEHICLEKILLED",_object,true]
		};
	};
};
//Add "incomingmissile" to a friendly aircraft
//friendly trancport choppers, except mi17_ins_med - 2000m; friendly combat choppers - 2500m; friendly planes - 3000m
FFA_FUNC_HANDLEMISSILEDEFENCE=
{
	private["_veh"];
	_veh=_this select 0;
	if(_veh isKindOf "Air") then
	{
		_veh setVariable ["FFA_FLARESLEFT",FFA_DEFAULTFLARES,true];
		_veh setVariable ["FFA_FLARESTIME",0,true];
		if (_veh isKindOf "helicopter") then
		{
			if ((typeOf _veh) in FFA_TROOPCHOPPERS) then
			{
				_veh addEventHandler["IncomingMissile",{if ((_this select 1) in FFA_AAWEAPONS) then	{FFA_MISSILETARGET=driver(_this select 0);publicVariable "FFA_MISSILETARGET";private ["_flares"];_flares=(_this select 0) getVariable "FFA_FLARESLEFT";if (_flares>0) then {[_this select 0,_this select 1,_this select 2,1200] spawn FFA_FUNC_MISSILEDEFENCE};};}];
			}
			else
			{
				_veh addEventHandler["IncomingMissile",{if ((_this select 1) in FFA_AAWEAPONS) then	{FFA_MISSILETARGET=driver(_this select 0);publicVariable "FFA_MISSILETARGET";private ["_flares"];_flares=(_this select 0) getVariable "FFA_FLARESLEFT";if (_flares>0) then {[_this select 0,_this select 1,_this select 2,2500] spawn FFA_FUNC_MISSILEDEFENCE};};}];
			};
		}
		else
		{
			_veh addEventHandler["IncomingMissile",{if ((_this select 1) in FFA_AAWEAPONS) then	{FFA_MISSILETARGET=driver(_this select 0);publicVariable "FFA_MISSILETARGET";private ["_flares"];_flares=(_this select 0) getVariable "FFA_FLARESLEFT";if (_flares>0) then {[_this select 0,_this select 1,_this select 2,2500] spawn FFA_FUNC_MISSILEDEFENCE};};}];
		};
	};
};
//AI and Players`s aircrafts launchflares, when "incoingmissile" activates
FFA_FUNC_DROPFLARES=
{
	private["_launcher","_period","_to_delete","_i","_flare","_sm","_sp","_li"];
	
	if (!local player) exitWith{};
	
	_launcher=_this select 0;
	
	_period=_launcher getVariable "FFA_FLARESTIME";
	if ((time-_period)>3) then
	{		
		if (!(local player) || (isPlayer (driver _air))) exitWith{};
		_launcher setVariable ["FFA_FLARESTIME",time,true];
	};
	
	_to_delete = [];
        for [{_i = 0},{_i < ((random 3)+1)},{_i = _i + 1}] do
        {         
	        _flare="FlareCountermeasure" createVehicleLocal (_launcher modelToWorld [0, -3, -2]);
        	_flare SetVelocity [-(vectorDir _launcher select 0)*30 + (velocity _launcher select 0),-(vectorDir _launcher select 1)*30 + (velocity _launcher select 1),-(vectorDir _launcher select 2)*30 +(velocity _launcher select 2)]; 
  
		_sm = "#particlesource" createVehicleLocal getpos _flare;
		_sm setParticleRandom [0.5, [0.3, 0.3, 0.3], [0.5, 0.5, 0.5], 0, 0.3, [0, 0, 0, 0], 0, 0,360];
		_sm setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8,0],
		"", "Billboard", 1, 3, [0, 0, 0],
		[0,0,0], 1, 1, 0.80, 0.5, [1.3,4],
		[[0.9,0.9,0.9,0.6], [1,1,1,0.3], [1,1,1,0]],[1],0.1,0.1,"","",_flare];	
		_sm setdropinterval 0.02;

		_sp = "#particlesource" createVehicleLocal getpos _flare;
		_sp setParticleRandom [0.03, [0.3, 0.3, 0.3], [1, 1, 1], 0, 0.2, [0, 0, 0, 0], 0, 0,360];
		_sp setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 13, 2,0],
		"", "Billboard", 1, 0.1, [0, 0, 0],
		[0,0,0], 1, 1, 0.80, 0.5, [1.5,0],
		[[1,1,1,-4], [1,1,1,-4], [1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","",_flare,360];	
		_sp setdropinterval 0.001;

		_li = "#lightpoint" createVehicleLocal getpos _flare;
		_li setLightBrightness 0.1;
		_li setLightAmbient[0.8, 0.6, 0.2];
		_li setLightColor[1, 0.5, 0.2];
		_li lightAttachObject [_flare, [0,0,0]];
		_to_delete = _to_delete + [_flare, _sm, _sp, _li];
		Sleep (0.1 + (random 0.25));
	};
	Sleep 4;
	{deleteVehicle _x} forEach _to_delete;
};
//Standard ARMA2 tank smoke script. Modified a bit. 
FFA_FUNC_LAUNCHSMOKES=
{	
	private["_key","_v","_isPlayer","_exit","_smokes","_lasttime","_dir","_px","_py","_useTDir","_num","_vel","_angle","_dir","_deltaDir","_arc","_initDist","_posV","_Vdir","_vH","_vV","_Hdir","_Gvel","_pH","_pV","_shells"];
	
	_v=_this select 0;	
	_key=_this select 1;
	_isPlayer=_this select 2;
	_launcher=_this select 3;
  if ((!(_v isKindOf "Tank")) && (!(_v isKindOf "Wheeled_APC"))) exitWith {};
	if (((typeOf _v) in ["BMP2_Ambul_INS","ZSU_CDF"])) exitWith {};
	
	_exit=false;
	
	switch (side _v) do
	{
		case east:
		{
			if (_key!=19) exitWith {_exit=true};//R-key
	
			_smokes=_v getVariable "FFA_SMOKESLEFT";
			if (_smokes <= 0) exitWith {_v vehicleChat localize "STR_RADIO_TankSmokeEmpty";_exit=true};

			_lasttime=_v getVariable "FFA_SMOKETIME";
			if ((_lasttime-time)>0) exitWith {_exit=true};
			_v setVariable ["FFA_SMOKETIME",time+5,true];
			_v setVariable ["FFA_SMOKESLEFT",_smokes-1,true];
			
			_v vehicleChat format[localize "STR_RADIO_TankSmokeLeft",_smokes-1];
		};
		case west:
		{
			_lasttime=_v getVariable "FFA_SMOKETIME";
			if ((_lasttime-time)>0) exitWith {_exit=true};
		};
		case resistance:
		{
			_lasttime=_v getVariable "FFA_SMOKETIME";
			if ((_lasttime-time)>0) exitWith {_exit=true};
		};
		default{_exit=true};
	};
	
	if (_exit) exitWith {};
		
	_v say "ffa_sound_smokeshot";
	
	_shells=[];

	//Read values from config

	_num=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherGrenadeCount");
	_vel=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherVelocity");	
	_angle=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherAngle");
	_useTDir=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherOnTurret");

	_dir = direction _v;	
	if ((_useTDir==1) && (count weapons _v > 0)) then
	{
		if (_isPlayer) then
		{
			_dir=screenToWorld [0.5,0.5];
		}
		else
		{
			/*
			_dir = _v weaponDirection ((weapons _v) select 0);
			_dir = (((_dir select 0) atan2 (_dir select 1))+360)%360;
			*/	
			_dir=getPosATL _launcher;
		};
		
		_px=_dir select 0;
		_py=_dir select 1;
		_dir=getPosATL _v;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);
		
		_dir = _px atan2 _py;
	};
		
	if (_num>0) then
	{		
		_deltaDir = _angle/_num;			//degrees between grenades.
		_arc = _deltaDir*(_num-1);		//total arc to cover, in degrees

		//distance from vehicle center where grenades are created; base it on vertical height
		_initDist = (((boundingBox _v) select 1) select 2)-(((boundingBox _v) select 0) select 2);

		//sleep 0.25;
		_posV = getpos _v;
		_Vdir = 30;	                     //angle of elevation. Temporary: launch all grenades at same angle
		//derive velocity
		_vH = _vel * cos _Vdir;          //horizontal component of velocity
		_vV = _vel * sin _Vdir;          //vertical component


		for "_i" from 0 to (_num - 1) do
		{
			//find starting parameters
			_Hdir = ((_i*_deltaDir)+_dir) - _arc/2; //relative direction around vehicle
			_Gvel = [_vH *sin(_Hdir), _vH*cos (_Hdir), _vV]; //initial grenade velocity

			//find starting position for grenades
			_pH = _initDist * cos _Vdir;     //initial distance horizontally away from vehicle center to create grenade
			_pV = _initDist * sin _Vdir;     //vertical distance

			//create / launch the grenade
			
			_smokeg=objNull;
			if (_isPlayer) then
			{
				_smokeg="SmokeShellVehicle" createVehicle ([(_pH * sin _Hdir) + (_posV select 0), (_pH * cos _Hdir)+ (_posV select 1), _pV+ (_posV select 2)]);
			}
			else
			{
				_smokeg="SmokeShellVehicle" createVehicleLocal ([(_pH * sin _Hdir) + (_posV select 0), (_pH * cos _Hdir)+ (_posV select 1), _pV+ (_posV select 2)]);
			};
						
			_smokeg setVelocity _Gvel;
			_smokeg setVectorDir _Gvel;
			_shells=_shells+[_smokeg];
		};

		if (_isPlayer) then
		{
			FFA_SMOKESHELLS=_shells;
			publicVariable "FFA_SMOKESHELLS";
		}
		else
		{
			{[_x] spawn FFA_FUNC_SPAWNSMOKESHELLS} foreach _shells;
		};
	};
};
//Function locally spawns tank smokeshells for each client, when it is necessary
FFA_FUNC_SPAWNSMOKESHELLS=
{
	private["_sh","_source2","_source3"];
	
	if (!local player) exitWith{};
	
	_sh=_this select 0;

	sleep 0.7;
	_source2 = "#particlesource" createVehicleLocal getpos _sh;
	_source2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 10, [0, 0, 0],
			[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 0.7],[1, 1, 1, 0.5], [1, 1, 1, 0.25], [1, 1, 1, 0]],
			[0.2], 1, 0.04, "", "", _sh];
	_source2 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
	_source2 setDropInterval 0.2;

	_source3 = "#particlesource" createVehicleLocal getpos _sh;
	_source3 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 7, 0], "", "Billboard", 1, 15, [0, 0, 0],
			[0, 0, 0.5], 0, 1.277, 1, 0.025, [0.5, 8, 12, 15], [[1, 1, 1, 1],[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 0]],
			[0.2], 1, 0.04, "", "", _sh];
	_source3 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
	_source3 setDropInterval 0.15;

	sleep (10+random 3);
	
	deletevehicle _source2;
	deletevehicle _source3;
	deletevehicle _sh;
};
//AI and Players`s tanks "incomingmissile" eventhandler
FFA_FUNC_ATGMDEFENCE=
{
	private["_veh","_ammo","_launcher","_rocket","_shells","_vel","_dist","_zerodist","_chance","_exit","_dir","_px","_py"];
	
	_veh=_this select 0;
	_ammo=_this select 1;
	_launcher=_this select 2;
	_exit=false;
	
	if (!(_ammo in FFA_ATGM)) exitWith {};

	_rocket=nearestObject [_launcher,_ammo];	
	_zerodist=1000;
		
	if (((side _veh)==resistance) || ((side _veh)==west)) then
	{		
		_dist=_veh distance _launcher;
		if (_ammo in FFA_ATGMSHOULDER) then 
		{
			_zerodist=700;
		}
		else
		{
			if (_ammo in FFA_ATGMAIR) then 
			{
				_zerodist=4000;
			}
			else
			{
				_exit=true;
			};
		};
		
		_chance=(1 min (_dist/_zerodist));		
						
		waitUntil{((_veh distance _rocket < 500) || (isNull _rocket))};
			
		[_veh,0,false,_launcher] spawn FFA_FUNC_LAUNCHSMOKES;			
			
		if (_exit) exitWith{};
				
		waitUntil{((_veh distance _rocket < 150) || (isNull _rocket))};
			
		if (((_veh distance _launcher)>300) && !(_launcher isKindOf "air")) then
		{
			_veh reveal _launcher;
		};
			
		if ((random 1)<_chance) then
		{
			_vel=velocity _rocket;
			_rocket setVelocity[_vel select 0,_vel select 1,-75];
		}
	}
	else
	{
		_dir=getPosATL _launcher;	
		_px=_dir select 0;
		_py=_dir select 1;
		_dir=getPosATL _veh;
		_px=_px - (_dir select 0);
		_py=_py - (_dir select 1);		
		_dir = _px atan2 _py;
		if (_dir < 0) then {_dir=_dir+360};
		
		_dir = _dir - (getDir _veh);
		_dir = round (_dir/30);
		if (_dir==0) then {_dir = 12};
		
		_veh setVariable ["FFA_ATGMDIR",_dir,true];
		FFA_ATGMTARGET=effectiveCommander _veh; 
		publicVariable "FFA_ATGMTARGET";

		waitUntil{((_veh distance _rocket < 150) || (isNull _rocket))};

		if (!(isNull _rocket)) then
		{	
			_shells=(getPos _veh) nearObjects["SmokeShellVehicle",50];
			if ((count _shells) > 0) then
			{		
				if (({(_rocket distance _x) < (_rocket distance _veh)} count _shells)>0) then 
				{
					_vel=velocity _rocket;
					_rocket setVelocity[_vel select 0,_vel select 1,-100];
				};
			};
		};
	};
};
//Add "incomingmissile" to a friendly armor
FFA_FUNC_HANDLEATGMDEFENCE=
{
	private ["_v"];
	
	_v=_this select 0;
	_global=_this select 1;
	
	if (((typeOf _v) in ["BMP2_Ambul_INS"])) exitWith {};
	
	if (GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherGrenadeCount")>0) then
	{
		_veh setVariable ["FFA_SMOKETIME",0,true];
		_veh setVariable ["FFA_SMOKESLEFT",FFA_DEFAULTSMOKES,true];		
		if (_global) then
		{
			_veh SetVehicleInit "this addEventHandler [""IncomingMissile"",""_this spawn FFA_FUNC_ATGMDEFENCE""]";
			ProcessInitCommands;
		}
		else
		{
			 _veh addEventHandler ["IncomingMissile",{_this spawn FFA_FUNC_ATGMDEFENCE}];
		}
	};
};