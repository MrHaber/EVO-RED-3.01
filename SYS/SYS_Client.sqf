#include "defines.sqf"
//when player joins the game, perform some tasks
FFA_FUNC_INITPLAYER=
{
	private["_script"];
	showCinemaBorder false;
	
	FFA_AMMO0="RUVehicleBox" createVehicleLocal getMarkerPos "MKR_Ammo0";
	FFA_AMMO1="RUBasicWeaponsBox"createVehicleLocal getMarkerPos "MKR_Ammo1";
	FFA_AMMO2="RUBasicWeaponsBox"createVehicleLocal getMarkerPos "MKR_Ammo2";
	FFA_AMMO3="RUBasicAmmunitionBox"createVehicleLocal getMarkerPos "MKR_Ammo3";
	FFA_AMMO4="RUBasicWeaponsBox"createVehicleLocal getMarkerPos "MKR_Ammo4";

	FFA_AMMO3 setPosATL [getMarkerPos "MKR_Ammo3" select 0,getMarkerPos "MKR_Ammo3" select 1,0.55];
	
	FFA_AMMOCRATES=[FFA_AMMO0,FFA_AMMO1,FFA_AMMO2,FFA_AMMO3,FFA_AMMO4];	
	{_x allowDamage false} forEach FFA_AMMOCRATES;
	
	removeAllWeapons player;
	
	{player addMagazine _x;} forEach FFA_LOADOUT_M;
	{if (!(player hasWeapon _x)) then {player addWeapon _x;};} forEach FFA_LOADOUT_W;

	[] call FFA_FUNC_RESETLIFESTATE;
	cutRsc ["Hud","PLAIN",0];

	player selectWeapon (primaryWeapon player);

      player addEventHandler ["killed","_this spawn FFA_FUNC_REMOVEPLAYER;[] spawn FFA_FUNC_PLAYERRESPAWN"];
	player addEventHandler ["HandleDamage","_this call FFA_FUNC_DAMAGING"];
	//player addEventHandler ["fired",{_this execVM "PoisonBomb.sqf"}];
	
	if ((paramsArray select 7)>0) then
  {
	  player addEventHandler ["hit",{ if ((_this select 2) > 0.3) then { [_this select 0, _this select 1]  spawn TKL_Killed;};}];
	};

	player setVariable ["FFA_DRAGGED",false,false];
	player setVariable ["FFA_OWNER","",false];
	player setVariable ["FFA_FRIENDLYFIRE",objNull,true];
	player setVariable ["FFA_VEHICLEKILLED",objNull,true];
	player setVariable ["FFA_SELFNAME",name Player,true];
	player setvariable ["JumpTime",time,false];
	player setvariable ["MedPack",(paramsArray select 5),false];

	_script=[] execVM "MSC\ffa_func_markers.sqf";

	FFA_PLAYERSLOT=[player] call FFA_FUNC_GETCLIENTSLOT;

	_script=player createDiaryRecord["Diary",[localize "STR_DIARY_Overview",localize "STR_DIARY_Briefing"]];

	[] call FFA_FUNC_UPDATEARMORY;
	[] call FFA_FUNC_REFRESHARMORY;
#ifdef __USE_ACE__
	[] spawn FFA_FUNC_CHANGELIFESTATE;
#endif

	if ((paramsArray select 1)>-1) then
	{
		10 setOvercast (paramsArray select 1);
		10 setRain (paramsArray select 1);
	}
	else
	{
		if (!isServer) then
		{
			"FFA_WEATHER" addPublicVariableEventHandler{(_this select 1)call FFA_FUNC_SETWEATHER};
		};
	};
	[] execVM "ACT\TransportStatic.sqf";
	[] execVM "ACT\PK.sqf";
	[] execVM "ACT\PKP.sqf";
	[] execVM "ACT\Unload_Ammo.sqf";
	[] execVM "ACT\Metis.sqf";
  	[] execVM "ACT\fort.sqf";
	[] execVM "ACT\Igla.sqf";
	[] execVM "ACT\Smoke.sqf";
	[] execVM "ACT\Laser.sqf";
	[] execVM "ACT\Dragdying.sqf";
	[] execVM "ACT\Menu.sqf";
	[] execVM "ACT\Heal.sqf";
	[] execVM "ACT\Bail.sqf";
	[] execVM "ACT\Radioblow.sqf";
	[] execVM "ACT\Removedropped.sqf";
	[] execVM "ACT\Winch.sqf";
	[] execVM "ACT\Lockland.sqf";
	[] execVM "ACT\Lockair.sqf";
	[] execVM "ACT\Resethealth.sqf";
	[] execVM "ACT\Saveweapon.sqf";
	[] execVM "ACT\Crew.sqf";
	[] execVM "ACT\Crewalertland.sqf";
	[] execVM "ACT\Crewalertair.sqf";
	[] execVM "ACT\Firstaidmessage.sqf";
	[] execVM "ACT\Dragwoundedmessage.sqf";
	[] execVM "ACT\Medicawardmessage.sqf";
	[] execVM "ACT\Newtask.sqf";
	[] execVM "ACT\Transportawardmessage.sqf";
	[] execVM "ACT\Transportaward.sqf";
	[] execVM "ACT\Antiairaward.sqf";
	[] execVM "ACT\Radioaward.sqf";
	[] execVM "ACT\Transferpointsmessage.sqf";
	[] execVM "ACT\Radiodestoymessage.sqf";
	[] execVM "ACT\Radiominedmessage.sqf";
	[] execVM "ACT\Citycapturedmessage.sqf";
	[] execVM "ACT\Designatemessage.sqf";
	[] execVM "ACT\jump.sqf";
	[] execVM "ACT\CATmessage.sqf";
	[] execVM "ACT\Counterstart.sqf";
	[] execVM "ACT\Counterstartend.sqf";
	[] execVM "ACT\ReRadio.sqf";
	[] execVM "ACT\EnemyPres.sqf";
	[] execVM "ACT\StaticActions.sqf";
	[] execVM "ACT\mobiletp.sqf";
	

	if ((paramsArray select 5)!=0) then 
	{
		[] execVM "ACT\HealYourSelf.sqf";
		[] execVM "ACT\buyMedPack.sqf";
	};
	FFA_CLIENTINITSTARTED = true;
};

//refresh cargo in ammo crates at the base and etc
FFA_FUNC_REFRESHARMORY=
{
	private["_list","_base","_totalweapons","_parseweapons","_totalmagazines","_parsemagazines","_item"];	
	{
		_x setDammage 0;
		clearWeaponCargo _x;
		clearMagazineCargo _x;

		_totalweapons=(count FFA_AVALIABLE_W)-1;
		_totalmagazines=(count FFA_AVALIABLE_M)-1;
	
		_list=(_x in [FFA_AMMO0,FFA_AMMO1,FFA_AMMO2,FFA_AMMO3,FFA_AMMO4]);
		_base=((count nearestObjects [_x,["BTR90_HQ","BMP2_HQ_INS"],20]) > 0);		
		
		for [{_parseweapons=0},{_parseweapons<=_totalweapons},{_parseweapons=_parseweapons+1}] do
		{
			_item=FFA_AVALIABLE_W select _parseweapons;
			if (_list || !(_item in FFA_REMOVEFROMTRUCKS_W) || _base) then
			{
				_x addWeaponCargo [_item,FFA_AMMOAMMOUNT_W];
			};			
		}; 
		for [{_parsemagazines=0},{_parsemagazines<=_totalmagazines},{_parsemagazines=_parsemagazines+1}] do
		{
			_item=FFA_AVALIABLE_M select _parsemagazines;
			if (_list || !(_item in FFA_REMOVEFROMTRUCKS_M) || _base) then
			{
				_x addMagazineCargo [_item,FFA_AMMOAMMOUNT_M];
			};
		}; 
		player reveal _x;
	}forEach FFA_AMMOCRATES;
};
//when player unlocks a new weapon, update the list of unlocked weapons
FFA_FUNC_UPDATEARMORY=
{
	private["_totalweapons","_parseweapons","_totalmagazines","_parsemagazines","_unlocked","_magazine","_weapon"];	
	
	_totalweapons=count FFA_WEAPONS;

  _unlocked=toArray (FFA_GAMELOGIC getVariable format["SVE_%1",GetPlayerUID player]);
		
	for [{_parseweapons=0},{_parseweapons<_totalweapons},{_parseweapons=_parseweapons+1}] do
	{
		if ((_unlocked select _parseweapons)==1) then
		{
			_totalmagazines=count ((FFA_WEAPONS select _parseweapons) select 1);

			for [{_parsemagazines=0},{_parsemagazines<_totalmagazines},{_parsemagazines=_parsemagazines+1}] do
			{
				_magazine=((FFA_WEAPONS select _parseweapons) select 1) select _parsemagazines;
				if (!(_magazine in FFA_AVALIABLE_M) && (_magazine!="")) then
				{
					FFA_AVALIABLE_M=FFA_AVALIABLE_M+[_magazine];
				};
			};
			
			_weapon=(FFA_WEAPONS select _parseweapons) select 0;
			if (!(_weapon in FFA_AVALIABLE_W) && (_weapon!="")) then
			{
				FFA_AVALIABLE_W=FFA_AVALIABLE_W+[_weapon];
			};
		};
	};
};
//delete CraterLong
FFA_FUNC_DELETECRATER=
{
	private["_crater","_delcr"];
	_crater= _this select 0;

  sleep 360;
  
  while {(count _crater) > 0 } do
  {
  _delcr=_crater select 0;
  deleteVehicle _delcr;
  _crater=_crater-[_delcr];
  sleep 1;
  };
};  
//fills dialog: weapons
FFA_FUNC_FILLWEAPONLIST=
{	
	private["_totalweapons","_parseweapons","_name","_index","_type","_price","_unlocked"];

	lbClear 202;
	ctrlSetText[203,localize "STR_GUI_LIST_Weapons"];

	[] spawn FFA_FUNC_REFRESHSCORE;

	_totalweapons=count FFA_WEAPONS;

	_unlocked=toArray (FFA_GAMELOGIC getVariable format["SVE_%1",GetPlayerUID player]);

	for [{_parseweapons=0},{_parseweapons<_totalweapons},{_parseweapons=_parseweapons+1}] do
	{		
		if ((_unlocked select _parseweapons)==2) then
		{		
			_type=(FFA_WEAPONS select _parseweapons) select 0;
			_price=(FFA_WEAPONS select _parseweapons) select 2;

			_name=getText(configFile >> "CfgWeapons" >> _type >> "DisplayName");
			_name=format["%1$ %2",_price,_name];

			_index=lbAdd [202,_name];
			lbSetValue [202,_index,_parseweapons];
		};				
	};
};
//fills dialog: units
FFA_FUNC_FILLUNITLIST=
{	
	private["_totalunits","_parseunits","_name","_index","_type","_price","_parsetypes","_totaltypes","_data"];

	lbClear 202;
	ctrlSetText[203,localize "STR_GUI_LIST_Units"];

	[] spawn FFA_FUNC_REFRESHSCORE;

	_totalunits=count FFA_WEAPONS;

	_unlocked=toArray (FFA_GAMELOGIC getVariable format["SVE_%1",GetPlayerUID player]);

	for [{_parseunits=0},{_parseunits<_totalunits},{_parseunits=_parseunits+1}] do
	{		
		if ((_unlocked select _parseunits)==1) then
		{
			_totaltypes=count ((FFA_WEAPONS select _parseunits) select 3);
			for [{_parsetypes=0},{_parsetypes<_totaltypes},{_parsetypes=_parsetypes+1}] do
			{
				_type=(((FFA_WEAPONS select _parseunits) select 3) select _parsetypes) select 0;
				
				if (_type!="") then
				{
					_price=(((FFA_WEAPONS select _parseunits) select 3) select _parsetypes) select 1;
					_name=getText(configFile >> "CfgVehicles" >> _type >> "DisplayName");
					_name=format["%1$ %2",_price,_name];
					_index=lbAdd [202,_name];
					//lbSetValue [202,_index,_parseunits];
					_data=toString([_parseunits+1,_parsetypes+1]);
					lbSetData [202,_index,_data];
				};
			};
		};
	};
};
//fills dialog: vehicles
FFA_FUNC_FILLVEHICLELIST=
{	
	private["_totalunits","_parseunits","_name","_index","_type","_price"];

	lbClear 202;
	ctrlSetText[203,localize "STR_GUI_LIST_Vehicles"];

	[] spawn FFA_FUNC_REFRESHSCORE;

	_totalunits=count FFA_FRIENDLYVEHICLES;

	for [{_parseunits=0},{_parseunits<_totalunits},{_parseunits=_parseunits+1}] do
	{		
		_type=(FFA_FRIENDLYVEHICLES select _parseunits) select 0;
		_price=(FFA_FRIENDLYVEHICLES select _parseunits) select 1;
		_name=format["STR_NAME_VEH_%1",_type];
		_name=format[localize _name,_price];
		_index=lbAdd [202,_name];
		lbSetValue [202,_index,_parseunits];
	};

};
//fills dialog: transfer
FFA_FUNC_FILLTRANSFERLIST=
{	
	private["_name","_index","_unit","_i"];

	lbClear 208;
	lbClear 209;

//	for [{_i=1},{_i<=40},{_i=_i+1}]	do
  for "_i" from 1 to 40 step 1 do
	{
	 if (!isNil {call compile format ["ES%1",_i]}) then
	 {
		_unit = [] call compile format ["ES%1",_i];
		if (isPlayer _unit && (_unit != player)) then
		{
			_name=_unit getVariable "FFA_SELFNAME";
			_index=lbAdd [208,_name];
			lbSetValue [208,_index,_i];
		};
	 };
	};
	lbSetCurSel[208,0];

	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",1]];
	lbSetValue [209,_index,1];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",5]];
	lbSetValue [209,_index,5];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",10]];
	lbSetValue [209,_index,10];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",15]];
	lbSetValue [209,_index,15];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",20]];
	lbSetValue [209,_index,20];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",30]];
	lbSetValue [209,_index,30];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",50]];
	lbSetValue [209,_index,50];
	_index=lbAdd [209,format[localize "STR_GUI_RES_Points",100]];
	lbSetValue [209,_index,100];

	lbSetCurSel[209,0];
};
//fills dialog: players
FFA_FUNC_FILLPLAYERSLIST=
{	
	private["_name","_index","_unit","_i","_group"];

	lbClear 202;
	ctrlSetText[203,localize "STR_GUI_LIST_Squad"];
	ctrlSetText[205,format [localize "STR_GUI_MENU_PlayersNumber",playersNumber east]];

//	for [{_i=1},{_i<=40},{_i=_i+1}]	do
  for "_i" from 1 to 40 step 1 do
	{
		if (!isNil {call compile format ["ES%1",_i]}) then
		{	
		 _unit = [] call compile format ["ES%1",_i];				

		 if (!(isNull _unit) && (_unit==leader _unit) && (_unit != player)) then
		 {
		 _group=group _unit;
		 _name=_unit getVariable "FFA_SELFNAME";
		 _name=format["%1 %2",_group,_name];

		 _index=lbAdd [202,_name];
		 lbSetValue [202,_index,_i];
		
//			  for [{_j=1},{_j<=40},{_j=_j+1}]	do
        for "_j" from 1 to 40 step 1 do
			  {
				  if (_j!=_i) then
				  {
					  _soldier=[] call compile format ["ES%1",_j];
					  if (_unit==leader _soldier) then
					  {
						_index=lbAdd [202,_soldier getVariable "FFA_SELFNAME"];
						lbSetValue [202,_index,_j];
					  };
				  };
			  };
			}; 
		};
	};
};
//fills dialog: units in player squad
FFA_FUNC_FILLSQUADLIST=
{	
	private["_name","_i","_alive","_unit"];

	_alive=count (units group player);

	lbClear 202;
	ctrlSetText[205,format[localize "STR_GUI_MENU_SquadNumber",_alive]];

	if (player ==leader player) then
	{
		ctrlSetText[203,localize "STR_GUI_LIST_Kick"];
	}
	else
	{
		ctrlSetText[203,localize "STR_GUI_LIST_Leave"];
	};
		
	for [{_i=0},{_i<_alive},{_i=_i+1}] do
	{
		_unit=((units group player) select _i);
		if (((alive _unit) || (isPlayer _unit)) && (_unit != player)) then
		{
			_name="";
			if (isPlayer _unit) then
			{
				_name=_unit getVariable "FFA_SELFNAME";
			}
			else
			{
				_name=name _unit;
			};
			
			_index=lbAdd [202,format ["%1. %2",_i+1,_name]];
		};
	};
};
//fills dialog: marker settings
FFA_FUNC_FILLMARKERSLIST=
{	
	private["_index"];

	lbClear 211;
	lbClear 212;

	_index=lbAdd [211,localize "STR_GUI_MARK_No"];
	lbSetValue [211,_index,-1];
	_index=lbAdd [211,format["%1",100]];
	lbSetValue [211,_index,100];
	_index=lbAdd [211,format["%1",200]];
	lbSetValue [211,_index,200];
	_index=lbAdd [211,format["%1",500]];
	lbSetValue [211,_index,500];
	_index=lbAdd [211,format["%1",1000]];
	lbSetValue [211,_index,1000];
	_index=lbAdd [211,format["%1",2000]];
	lbSetValue [211,_index,2000];
	_index=lbAdd [211,format["%1",3000]];
	lbSetValue [211,_index,3000];
	_index=lbAdd [211,format["%1",5000]];
	lbSetValue [211,_index,5000];

	_index=lbAdd [212,localize "STR_GUI_MARK_Type1"];
	lbSetValue [212,_index,FFA_MARKERS_INFANTRY];
	_index=lbAdd [212,localize "STR_GUI_MARK_Type2"];
	lbSetValue [212,_index,FFA_MARKERS_VEHICLES];
	_index=lbAdd [212,localize "STR_GUI_MARK_Type3"];
	lbSetValue [212,_index,FFA_MARKERS_BOTH];	
	_index=lbAdd [212,localize "STR_GUI_MARK_Type4"];
	lbSetValue [212,_index,FFA_MARKERS_GROUP];

	lbSetCurSel[211,FFA_CURRENTMARKER_DISTANCE];
	lbSetCurSel[212,FFA_CURRENTMARKER_TYPE];
};
//fills dialog: EASA
FFA_FUNC_FILLEASALIST=
{
	private["_index","_total","_i","_text"];
	
	_index=FFA_EASAAIR find (typeOf (vehicle player));
	
	_total=count (FFA_EASALOADOUTS_W select _index);
	
	for [{_i=0},{_i<_total},{_i=_i+1}] do
	{		
		_text=lbAdd [221,localize (((FFA_EASALOADOUTS_W select _index) select _i) select 0)];
	};
	
	lbSetCurSel[221,0];
};
//player hit "apply" at the EASA dialog
FFA_FUNC_EASAAPPLY=
{
	private["_index","_number","_weapons","_magazines"];
	
	_index=FFA_EASAAIR find (typeOf (vehicle player));
	_number=lbCurSel 221;
	
	_weapons=((FFA_EASALOADOUTS_W select _index) select _number) select 1;
	_magazines=(FFA_EASALOADOUTS_M select _index) select _number;

	(vehicle player) setVariable ["FFA_EASALOADOUT_W",_weapons,true];
	(vehicle player) setVariable ["FFA_EASALOADOUT_M",_magazines,true];
	
	hint localize "STR_HINT_EasaReady";
};
//player hit "apply" at the buy dialog
FFA_FUNC_LISTAPPLY=
{
	private ["_index","_value","_data","_d1","_d2","_price","_type","_typeveh","_vehcnt","_unit","_text","_base"];

	[] spawn FFA_FUNC_DLGBUYDELAY;

	_index=(lbCurSel 202);
	if (_index>=0) then
	{
		if (FFA_DLG_ACTIVE_WEAPONS) then
		{
			_base={(((vehicle player) distance _x) < 50) && (alive _x)} count nearestObjects [(vehicle player),["BTR90_HQ","BMP2_HQ_INS"],55];			
			if (!(player in list Base) && !(player in list Base1) && !(player in list Base2) && !(player in list Base3) && (_base==0)) exitWith{hint localize "STR_HINT_OnlyAtBase"};
			
			_index=(lbCurSel 202);
			_value=lbValue [202,_index];
			_price=(FFA_WEAPONS select _value) select 2;

			if ((_price <= (score player)) && ( score player >0)) then
			{
				_unlocked=toArray (FFA_GAMELOGIC getVariable format["SVE_%1",GetPlayerUID player]);
				_unlocked set [_value,1];
				FFA_GAMELOGIC setVariable [format["SVE_%1",GetPlayerUID player],toString _unlocked,true];
				
				_text=getText (configFile >> "CfgWeapons" >> ((FFA_WEAPONS select _value) select 0) >> "DisplayName");
				
				if (count((FFA_WEAPONS select _value) select 3)==0) then
				{
					hint format[localize "STR_HINT_Weapon",_text];				
				}
				else
				{
					hint format[localize "STR_HINT_WeaponUnit",_text];
				};
	
				[] call FFA_FUNC_FILLWEAPONLIST;
				[] call FFA_FUNC_UPDATEARMORY;
				[] call FFA_FUNC_REFRESHARMORY;
				
				[FFA_CMD_OUTCOMEREQUEST,_price] call FFA_FUNC_PLAYERTOCLIENT;
			}
			else
			{
				hint localize "STR_HINT_ScoreLow";
			};
		};

		if (FFA_DLG_ACTIVE_UNITS) then
		{
			_base={(((vehicle player) distance _x) < 50) && (alive _x)} count nearestObjects [(vehicle player),["BTR90_HQ","BMP2_HQ_INS"],55];			
			if (!(player in list Base) && !(player in list Base1) && !(player in list Base2) && !(player in list Base3) && (_base==0)) exitWith{hint localize "STR_HINT_OnlyAtBase"};
      if (player in list RespawnZone) exitWith {hint localize "STR_HINT_OnlyDoNotSpawn"};
			_index=(lbCurSel 202);

			_data=toArray(lbdata [202,_index]);
			_d1=(_data select 0)-1;
			_d2=(_data select 1)-1;

			_price=(((FFA_WEAPONS select _d1) select 3) select _d2) select 1;

			if (leader player!=player) exitWith {hint localize "STR_HINT_UnableToRecruit"};

			if ((_price <= (score player)) && ( score player >0)) then
			{	
				_value=FFA_MAXUNITSINSQUAD-(0 max floor((playersNumber east)/10-1.1));
				if (({alive _x} count (units group player)) < _value) then
				{										
					_unit=getText (configFile >> "CfgVehicles" >> ((((FFA_WEAPONS select _d1) select 3) select _d2) select 0) >> "DisplayName");
					hint format[localize "STR_HINT_Unit",_unit,({alive _x} count (units group player))+1,_value];
					
					[FFA_CMD_UNITREQUEST,_data select 0,_data select 1,_price,getposATL player select 0,getposATL player select 1,getDir player] call FFA_FUNC_PLAYERTOCLIENT;				
				}
				else
				{
					hint localize "STR_HINT_FullSquad";
				};
			}
			else
			{
				hint localize "STR_HINT_ScoreLow";
			};
		};

		if (FFA_DLG_ACTIVE_VEHICLES) then
		{
			_base={(((vehicle player) distance _x) < 50) && (alive _x)} count nearestObjects [(vehicle player),["BTR90_HQ","BMP2_HQ_INS"],55];			
			if (!(player in list Base) && !(player in list Base1) && !(player in list Base2) && !(player in list Base3) && (_base==0)) exitWith{hint localize "STR_HINT_OnlyAtBase"};

			if (player in list Runway) exitWith{hint localize "STR_HINT_NotAtRunway"};
			
			if (player in list RespawnZone)	exitWIth {hint localize "STR_HINT_RespawnZone"};
	
			_index=(lbCurSel 202);
			_value=lbValue [202,_index];
			_price=(FFA_FRIENDLYVEHICLES select _value) select 1;

			if ((_price <= (score player)) && ( score player >0)) then
			{
				[FFA_CMD_VEHICLEREQUEST,_value+1,_price,getposATL player select 0,getposATL player select 1,getDir player] call FFA_FUNC_PLAYERTOCLIENT;
				_unit=getText (configFile >> "CfgVehicles" >> ((FFA_FRIENDLYVEHICLES select _value) select 0) >> "DisplayName");
				hint format[localize "STR_HINT_Vehicle",_unit];				
			}
			else
			{
				hint localize "STR_HINT_ScoreLow";
			};
		};


		if (FFA_DLG_ACTIVE_PLAYERS) then
		{
			_index=(lbCurSel 202);
			_value=lbValue [202,_index];

			_unit = [] call compile format ["ES%1",_value];			

			if (_unit!=player) then
			{
				if (_unit==(leader _unit)) then
				{
					if ((player==leader player) && ({alive _x} count (units group player)>1)) then
					{
						hint localize "STR_HINT_AliveSquad";
					}
					else
					{
						[player] join (group _unit);
						//WaitUntil{(player!=(leader player))};
						hint format[localize "STR_HINT_JoinedSquad",_unit getVariable "FFA_SELFNAME"];
						[] call FFA_FUNC_FILLPLAYERSLIST;
					};
				}
				else
				{
					hint localize "STR_HINT_UnableToJoin";
				};
			};
		};
		if (FFA_DLG_ACTIVE_SQUAD) then
		{
			_index=(lbCurSel 202);

			if (player==leader player) then
			{
				_unit=lbText[202,_index];
				if (_unit!=name player) then
				{
					_value=count (units group player);
					_text=false;
					for [{_index=0},{_index<_value},{_index=_index+1}] do
					{
						if (format ["%1. %2",_index+1,name ((units group player) select _index)]==_unit) then
						{
							_type=(units group player) select _index;
							[_type] join grpNull;
							hint format[localize "STR_HINT_UnitLeftSquad",_unit];														
							_text=true;
						};
						if (!isPlayer _type) then
						{
							_type setPos [0,0,0];
							_type setDammage 1;							
						};
					};
					if (!_text) then
					{
						[] call FFA_FUNC_FILLSQUADLIST;
					};
				};
			}
			else
			{
				[player] join grpnull;
				hint localize "STR_HINT_PlayerLeftSquad";
				[] call FFA_FUNC_FILLSQUADLIST;
			};
		};
	};	
};
//transfer points to another player
FFA_FUNC_TRANSFER=
{
	private[];
	_target=lbValue[208,lbCurSel 208];
	_ammount=lbValue[209,lbCurSel 209];
	[] spawn FFA_FUNC_DLGTRANSFDELAY;
	
  if ( score player <=0) exitWith{hint localize "STR_HINT_ScoreNull";};
	if (_ammount > score player) exitWith{hint localize "STR_HINT_ScoreLow";};
	if (_target==FFA_PLAYERSLOT) exitWith{hint localize "STR_HINT_SameSlot";}; 
	_unit=[] call compile format ["ES%1",_target];
	
	if (isPlayer _unit) then
	{
		if (alive _unit) then
		{
			if ((name _unit)=="<null>") exitWith {hint localize "STR_HINT_TryAgain";};
			[FFA_CMD_TRANSFERREQUEST,_target,_ammount] call FFA_FUNC_PLAYERTOCLIENT;
			hint format[localize "STR_HINT_TransferTransmit",_ammount,_unit getVariable "FFA_SELFNAME"];
		}
		else
		{
			hint localize "STR_HINT_TransferDead";
		};
	}
	else
	{
		[] call FFA_FUNC_FILLTRANSFERLIST;	
	};
};
//when main menu is active, update player score in it
FFA_FUNC_REFRESHSCORE=
{
	while {(dialog)} do
	{		
		ctrlSetText[205,format[localize "STR_GUI_MENU_Score",score player]];
		ctrlSetText[206,format[localize "STR_GUI_MENU_Score",score player]];
		sleep 1;
	};
};
//hint "Award"/"Penalty"/"Missile attack"/"Hints"
FFA_FUNC_MESSAGE=
{
	private["_headcolor","_head","_body","_plaintext","_parsedtext","_msg","_txt"];	

	_headcolor = _this select 0;
	_head = _this select 1;
	_body = _this select 2;
	_plaintext = format["%1: %2",_head,_body];
	_parsedtext = parseText format["<t color='%1'>%2</t><br/><br/>%3",_headcolor,_head,_body];
	_msg = [_parsedtext];
	_txt = composeText _msg;
	hint _txt;
};
//Transmit a message to server
FFA_FUNC_PLAYERTOCLIENT=
{
	private["_cmd","_ptcVarName"];

	_cmd=toString _this;

	_ptcVarName = "PTC_" + format["%1",player];

	call compile format["%1 = _cmd",_ptcVarName];

	publicVariableServer _ptcVarName;
};
//Determine the number of slot player takes
FFA_FUNC_GETCLIENTSLOT=
{
	private["_i","_unit","_player","_result"];

	_player=_this select 0;

	_result=0;

//	for [{_i=1},{_i<=40},{_i=_i+1}]	do
  for "_i" from 1 to 40 step 1 do
	{
		if (!isNil {call compile format ["ES%1",_i]}) then
		{
		 _unit = [] call compile format ["ES%1",_i];

		 if (isPlayer _unit) then
		  {
			  if (_unit==_player) exitWith
			  {
				 _result=_i;
			  };
		  };
	  };
  };	
	_result
};
FFA_FUNC_ADDACTPARA=
{
	private ["_veh","_unit","_actpara"];
	_unit=_this select 2;
	if (_unit == player) then
	{
	  _veh=nearestObject[player,"Air"];
	  if ((!(isNull _veh)) && !(_veh in FFA_VEHPARA)) then
	  {
		 {if (!(alive _x) || (isNull _x)) then {FFA_VEHPARA=FFA_VEHPARA-[_x]} } ForEach FFA_VEHPARA;
	   _actpara=_veh addAction [localize "STR_ACT_ACTPARA","ACT\ACT_Para.sqf",player];
	   FFA_VEHPARA=FFA_VEHPARA+[_veh];
	  };
  };
};
//to award driver, when cargo leaves his vehicle; "long-jump" with opening para near ground
FFA_FUNC_GETOUTEVENTHANDLER=
{
	private["_veh","_place","_unit","_location","_distance","_award"];

	_veh=_this select 0;
	_place=_this select 1;
	_unit=_this select 2;
	
	_location=getPosATL _unit;

	if (((_location select 2) < 5) && (_unit==player) && (_place=="cargo") && !(_veh isKindOf "Mi17_medevac_Ins")) then
	{
		_driver=driver _veh;
		if ((isPlayer _driver) && (isPlayer _unit)) then
		{
			_distance=_location distance VEH_TransportPos;
			if (_distance > FFA_TRANSPORTAWARDDISTANCE) then
			{
				if (FFA_AWARDUNIT_TRANSPORT!=_driver) then
				{
					FFA_AWARDUNIT_TRANSPORT=_driver;
					publicVariable "FFA_AWARDUNIT_TRANSPORT";
				};				
				_driver=[_driver] call FFA_FUNC_GETCLIENTSLOT;
				if (_veh isKindOf "helicopter") then
				{
					_award=FFA_TRANSPORTAWARD*(floor(_distance/FFA_TRANSPORTAWARDDISTANCE));
				}
				else
				{
					_award=FFA_TRANSPORTAWARD;					
				};
				[FFA_CMD_INCOMEREQUEST,_driver,_award] call FFA_FUNC_PLAYERTOCLIENT;
			};
		};
	};	
};
//when there is a new town to attack
FFA_FUNC_UPDATETASK=
{
	FFA_PLAYERTASK=player createSimpleTask [FFA_CURRENTTOWNMARKER];
	FFA_PLAYERTASK setsimpletaskdescription [format[localize "STR_DIARY_Task01",localize FFA_CURRENTTOWNNAME],format[localize "STR_DIARY_Task02",localize FFA_CURRENTTOWNNAME],localize "STR_DIARY_Task03"];
	FFA_PLAYERTASK setSimpleTaskDestination getMarkerPos FFA_CURRENTTOWNMARKER;
	FFA_PLAYERTASK setTaskState "Created";

	player setCurrentTask FFA_PLAYERTASK;
	
	[east,"hq"] sideChat format [localize "STR_RADIO_ObjActive",localize FFA_CURRENTTOWNNAME];
};
//when the town is taken
FFA_FUNC_CLOSETASK=
{
	FFA_PLAYERTASK setTaskState "Succeeded";

	[east,"hq"] sideChat format [localize "STR_RADIO_ObjDone",localize FFA_CURRENTTOWNNAME];
};
//when another player heals local player
FFA_FUNC_BEINGFIRSTAIDED=
{
	private["_slot"];

	if (FFA_HITBYENEMY) then
	{
		FFA_AWARDUNIT_MEDIC=FFA_MEDIC;
		publicVariable "FFA_AWARDUNIT_MEDIC";

		_slot=[FFA_MEDIC] call FFA_FUNC_GETCLIENTSLOT;
		[FFA_CMD_INCOMEREQUEST,_slot,FFA_MEDICAWARD] call FFA_FUNC_PLAYERTOCLIENT;
	};

	hint format[localize "STR_HINT_FirstAid",FFA_MEDIC getVariable "FFA_SELFNAME"]; 
	FFA_INJURED=objNull; 
	FFA_MEDIC=objNull; 
	
	player playMove "AinvPknlMstpSlayWrflDnon_healed2";
};
//only in ACE - check ACE injury state, which is a local variable, and assign a global variable to it
#ifdef __USE_ACE__
FFA_FUNC_CHANGELIFESTATE=
{
	private["_state"];

	_state=player getVariable "ace_w_state";

	while {(true)} do
	{
		waitUntil{(player getVariable "ace_w_state")!=_state};

		_state=player getVariable "ace_w_state";

		switch (player getVariable "ace_w_state") do
		{
			case 0:
			{
				player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_HEALTHY,true];
			};
			case 800:
			{
				player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_INJURED,true];
			};
			case 801:
			{
				player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_INJURED,true];
			};
			case 802:
			{
				player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_DYING,true];
			};			
			default
			{
				player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_DEAD,true];
			};
		};
	};
};
#endif
//when player respawns or being healed, reset player`s injury state
FFA_FUNC_RESETLIFESTATE=
{
	player setVariable ["FFA_LIFESTATE",FFA_LIFESTATE_HEALTHY,true];

#ifdef __USE_ACE__
	player setVariable ["ace_w_state",0,false];
#endif
	FFA_PLAYERINAGONY=false;
	FFA_HITBYENEMY=false;
	FFA_DAMAGEHEAD_HIT=0;
	FFA_DAMAGEBODY=0;
	FFA_DAMAGELEGS=0;
	FFA_DAMAGEHANDS=0;
	FFA_DAMAGE=0;
};
//player`s HandleDamage eventhandler
FFA_FUNC_DAMAGING=
{
	private["_unit","_part","_damage","_var","_veh","_role","_source","_sWeap","_cWeap"];

	_unit=_this select 0;
	_part=_this select 1;
	_damage=_this select 2;
	_source=_this select 3;
	_sWeap = secondaryWeapon _unit;
	_cWeap = currentWeapon _unit;

#ifndef __USE_ACE__
	if ((((vehicle player)!=player) && (("Parachute" countType [vehicle player])==0)) && (_part=="")) then
	{
		[] call compile format["FFA_DAMAGE%1=FFA_DAMAGE%1+%2",_part,_damage*0.05];
	}
	else
	{
		[] call compile format["FFA_DAMAGE%1=FFA_DAMAGE%1+%2",_part,_damage];
	};

	_var=[] call compile format["FFA_DAMAGE%1",_part];

	if (((side _source)==west) && !(FFA_HITBYENEMY)) then
	{
		FFA_HITBYENEMY=true;
	};
#endif
	if ( ( ((side _source)==east) || (isPlayer _source) ) && (_source!=_unit) && ((vehicle _source)!=(vehicle _unit))) then
	{	
		_veh=vehicle _source;
		if (!(_veh isKindOf "man")) then
		{
			_role=gunner _veh;
			if (isPlayer _role) then
			{
				_source=_role;
			}
			else
			{
				_source=effectiveCommander _veh;
			};
		};		
		if (isPlayer _source) then
		{			
			if (isNull(_source getVariable "FFA_FRIENDLYFIRE")) then
			{
				_unit groupChat format[localize "STR_RADIO_AttackedSelf",_source getVariable "FFA_SELFNAME"];
			};
			_source setVariable["FFA_FRIENDLYFIRE",_unit,true];	
		}
		else
		{
			if (isNull((leader _source) getVariable "FFA_FRIENDLYFIRE")) then
			{
				_unit groupChat format[localize "STR_RADIO_AttackedUnit",(leader _source) getVariable "FFA_SELFNAME"];
			};
			(leader _source) setVariable["FFA_FRIENDLYFIRE",_unit,true];
		};
	};
#ifndef __USE_ACE__
	if ((_var > 0.05) && ((_unit getVariable "FFA_LIFESTATE") <= FFA_LIFESTATE_HEALTHY)) then
	{
		_unit setVariable["FFA_LIFESTATE",FFA_LIFESTATE_INJURED,true];
	};

	if (_part in [""]) then 
	{
		_unit setDammage (0.89 min _var);
	}
	else
	{
		_unit setHit[_part, (0.89 min _var)];
	};

	if ( (((_part=="body") && (_var > 16)) || ((_part=="head_hit") && (_var > 12)) || ((_part=="") && (_var > 20)) || !(alive (vehicle _unit))) && (alive _unit) ) then
	{
		//_unit sideChat format ["%1 %2",_part,_var];
		//_unit setVariable["FFA_LIFESTATE",FFA_LIFESTATE_DEAD,true];
		[] spawn compile format["%1 setDammage 1",_unit];
	};

	if (!(alive _unit))exitWith{};

	if ( (!(FFA_PLAYERINAGONY) && ((vehicle _unit)==_unit) && ((getPosATL (vehicle _unit) select 2) < 5) && (((_part=="body") && (_var > 4)) || ((_part=="head_hit") && (_var > 3)) || ((_part=="") && (_var > 5)))) && (alive _unit) ) then
	{
		if ( _cWeap == _sWeap) then
		{
			[] spawn compile format["%1 setDammage 1",_unit];
		}
		else
		{
			FFA_PLAYERINAGONY=true;
			_unit setVariable["FFA_LIFESTATE",FFA_LIFESTATE_DYING,true];
			[_unit] spawn FFA_FUNC_AGONY;
		};
	};
#endif
};
//apply click at markers setup dialog
FFA_FUNC_MARKERSAPPLY=
{
	FFA_CURRENTMARKER_DISTANCE=lbCurSel 211;
	FFA_MARKERS_DISTANCE=lbValue [211,FFA_CURRENTMARKER_DISTANCE];
	FFA_CURRENTMARKER_TYPE=lbCurSel 212;
	FFA_MARKERS_TYPE=lbValue [212,FFA_CURRENTMARKER_TYPE];
	hint localize "STR_HINT_MarkersChanged";
};
//public messages, when somebody shoots friendly
FFA_FUNC_LAW=
{
	private["_unit","_victim","_msg","_veh","_name","_attackveh"];
	_unit=_this select 0;
	
	_name=_unit getVariable "FFA_SELFNAME";
	_attackveh=vehicle _unit;
	if (isNil "_name") exitWith {};
	if (_attackveh!=_unit) then
	{
		_name=_name+" <"+getText(configFile >> "CfgVehicles" >> typeOf _attackveh >> "DisplayName")+">";
	};
	
	_victim=_unit getVariable "FFA_FRIENDLYFIRE";
	if (isNil "_victim") exitWith {};
	_veh=vehicle _victim;
	if ((!isNull _victim) && (_veh==_victim)) then
	{
		_msg=localize "STR_RADIO_FriendlyFire";
		if ((_attackveh in list Base) || (_veh in list Base)) then
		{
			_msg=_msg+" "+localize "STR_RADIO_AtBase";
		};
		player commandChat format [_msg,_name];
		_unit setVariable ["FFA_FRIENDLYFIRE",objNull,false];
	};
	if ((!isNull _victim) && (_veh!=_victim)) then
	{
		_msg=localize "STR_RADIO_FriendlyFireVeh";
		if ((_attackveh in list Base) || (_veh in list Base)) then
		{
			_msg=_msg+" "+localize "STR_RADIO_AtBase";
		};
		player commandChat format [_msg,_name,getText (configFile >> "CfgVehicles" >> typeOf _veh >> "DisplayName")];
		_unit setVariable ["FFA_FRIENDLYFIRE",objNull,false];
	};
	_victim=_unit getVariable "FFA_VEHICLEKILLED";
	if (!isNull _victim) then
	{
		_msg=localize "STR_RADIO_VehKilled";
		if ((_attackveh in list Base) || (_victim in list Base)) then
		{
			_msg=_msg+" "+localize "STR_RADIO_AtBase";
		};
		player commandChat format [_msg,_name,_victim getVariable "FFA_OWNER"];
		_unit setVariable ["FFA_VEHICLEKILLED",objNull,false];
	};
};
//set weather like at the server
FFA_FUNC_SETWEATHER=
{
	10 setOvercast(_this select 2);
	10 setRain(_this select 3);
};
//handle ammo crates, unloaded from ammotrucks and MHQ
FFA_FUNC_HANDLEMOBILEAMMO=
{
	private["_ammo"];

	_ammo=_this select 0;

	while { (({((alive _x) && !(isNull _x))} count nearestObjects [_ammo,["BTR90_HQ","BMP2_HQ_INS"],10])>0) && (alive _ammo) } do
	{
		sleep 10;
	};

	deleteVehicle _ammo;
	FFA_AMMOCRATES=FFA_AMMOCRATES-[_ammo];
};

//remove player`s dead body
FFA_FUNC_REMOVEPLAYER=
{
	private["_unit"];

	_unit=_this select 0;
	
//sleep FFA_DELETEBODIESTIMEOUT;	
     sleep 10;

	_unit removeAllEventHandlers "killed";
	_unit removeAllEventHandlers "IncomingMissile";
	_unit removeAllEventHandlers "HandleDamage";
	_unit removeAllEventHandlers "Hit";
	_unit removeAllEventHandlers "GetOut";
	_unit removeAllEventHandlers "Init";

//sleep FFA_DELETEBODIESTIMEOUT;
     sleep 5;

	_unit setPos [0,0,0];
	sleep 0.1;
	deleteVehicle _unit;
};
//rearm player when he respawns
FFA_FUNC_PLAYERRESPAWN=
{
	closeDialog 0;
	player setVariable["FFA_LIFESTATE",FFA_LIFESTATE_DEAD,true];
	//enableRadio false;

	private["_camera"];

	_camera = "camera" CamCreate [0,0,0];
	_camera cameraEffect ["internal","back"];
	_camera camCommand "inertia on";

	_camera camSetTarget player;
	_camera camSetRelPos [0.5,0.5,5];
	_camera camSetFOV 0.700;
	_camera camCommitPrepared 0;
	WaitUntil {camCommitted _camera};

	_camera camSetTarget player;
	_camera camSetRelPos [0.5,0.5,25];
	_camera camSetFOV 0.700;
	_camera camCommitPrepared 30;

	sleep 15.0;

	titleCut ["","black out",2];

	WaitUntil {alive player};

	//===============
	removeAllWeapons player;
	removeAllItems player;
	
	{player addMagazine _x;} forEach FFA_LOADOUT_M;
	{if (!(player hasWeapon _x)) then {player addWeapon _x;};} forEach FFA_LOADOUT_W;

	[] call FFA_FUNC_REFRESHARMORY;

	player selectWeapon (primaryWeapon player);

	player addEventHandler ["killed","_this spawn FFA_FUNC_REMOVEPLAYER;[] spawn FFA_FUNC_PLAYERRESPAWN"];
	player addEventHandler ["HandleDamage","_this call FFA_FUNC_DAMAGING"];
	
	if ((paramsArray select 7)>0) then
  {
	  player addEventHandler ["hit",{ if ((_this select 2) > 0.3) then { [_this select 0, _this select 1]  spawn TKL_Killed;};}];
	};
	
	player setVariable ["FFA_DRAGGED",false,false];
	player setVariable ["FFA_OWNER","",false];
	player setVariable ["FFA_FRIENDLYFIRE",objNull,true];
	player setVariable ["FFA_VEHICLEKILLED",objNull,true];
	player setVariable ["FFA_SELFNAME",name Player,true];
	player setvariable ["JumpTime",time,false];
	player setvariable ["MedPack",(paramsArray select 5),false];

#ifdef __USE_ACE__	
	player setVariable ["ACE_weapononback",FFA_LOADOUT_B];

	if (player call ace_sys_ruck_fnc_hasRuck) then
	{
		player setVariable ["ACE_RuckMagContents",FFA_LOADOUT_RM];
		player setVariable ["ACE_RuckWepContents",FFA_LOADOUT_RW];
	};

	if (FFA_LOADOUT_EARWEAR) then
	{
		player setVariable ["ACE_EarWear",FFA_LOADOUT_EARWEAR,false];	
		player setVariable ["ACE_Ear_Protection",FFA_LOADOUT_EARPROT,false];
	};
	
	if (FFA_LOADOUT_EYEWEAR) then
	{		
		["ace_sys_goggles_setident2", [player, FFA_IDENTITY]] call CBA_fnc_globalEvent;

		_special=(getArray(configFile >> "CfgIdentities" >> FFA_IDENTITY >> "ace_special")) select 0;;
		player setVariable [_special,true,false];
		player setVariable ["ACE_Identity",FFA_IDENTITY,false];	
		player setVariable ["ACE_EyeWear",FFA_LOADOUT_EYEWEAR,false];
		player setVariable ["ACE_Eye_Protection",FFA_LOADOUT_EYEPROT,false];

		player spawn ace_sys_goggles_fnc_rsc_mask;
	};
#endif
	[] call FFA_FUNC_RESETLIFESTATE;
	
	player setCaptive false;
	
	FFA_SMOKESHELLS=[];
	FFA_MISSILETARGET=objNull;
	FFA_ATGMTARGET=objNull;
	FFA_PENALTYUNIT=objNull;
	FFA_AWARDUNIT_TRANSPORT=objNull;
	FFA_AWARDUNIT_RADIO=objNull;
	FFA_AWARDUNIT_MEDIC=objNull;
	FFA_TRANSFER_TARGET=objNull;
	FFA_INJURED=objNull;
	FFA_MEDIC=objNull;	
	//===============
	player cameraEffect ["terminate","back"];
	camDestroy _camera;
	titleCut ["","black in",2];
	sleep 2.0;
	//enableRadio true;
	cutRsc ["Hud","PLAIN"];
};
//when player is heavily injured
FFA_FUNC_AGONY=
{
	private["_unit","_timetolive","_timetodie","_animation"];
	_unit=_this select 0;
	_timetolive=120+(random 120);
	_timetodie=time+_timetolive;
	_animation="GestureSpasm1weak";
	_unit playAction "agonyStart";
	_unit setDammage 0.8;
	_unit setUnconscious true;
	sleep 4;
	if !(alive _unit) exitWith{};
	hint localize "STR_HINT_Injured";
	_unit playAction _animation;
	waitUntil{!(alive _unit) || ((getDammage _unit) < 0.10) || (time>_timetodie) || ((vehicle _unit)!=_unit)};
	if ((time>_timetodie) || ((vehicle _unit)!=_unit)) then {_unit setDammage 1};
	FFA_PLAYERINAGONY=false;
	sleep 2;
	_unit setUnconscious false;
	_unit playAction "GestureNod";
	_unit playAction "agonyStop";
};
//disable "Buy" button for some seconds
FFA_FUNC_DLGBUYDELAY=
{
	ctrlenable[207,false];
	sleep 5.0;
	ctrlEnable[207,true];
};
//transfer pause
FFA_FUNC_DLGTRANSFDELAY=
{
	 ctrlenable[210,false];
   sleep 15;
   ctrlenable[210,true];
};
//Check, if player is a vehicle`s owner
FFA_FUNC_LOCKUNLOCK=
{
	private["_param","_veh","_name","_id"];
	_param=_this select 0;
	_veh=nearestObject[player,_param];
	if (!(isNull _veh) && !(_veh in FFA_PRIVATEVEHICLES)) then
	{
		{if (!(alive _x) || (isNull _x)) then {FFA_PRIVATEVEHICLES=FFA_PRIVATEVEHICLES-[_x]} } ForEach FFA_PRIVATEVEHICLES;
		_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");

//		_id=_veh addAction [format[localize "STR_ACT_KickVeh",_name],"ACT\ACT_kick_f_Veh.sqf",[],95,false,true,"", "(local player) && (alive player) && ((vehicle player)!=player) && ((vehicle player)==_target) && (local (vehicle player)) && ((getPosATL (vehicle player) select 2) < 5) && ((name player)==(_target getVariable ""FFA_OWNER""))"];
		_id=_veh addAction [localize "STR_ACT_KickVeh","ACT\ACT_kick_f_Veh.sqf",[],0,false,true,"", "(alive _target) && ((name player)==(_target getVariable ""FFA_OWNER""))"];
		_id=_veh addAction [format[localize "STR_ACT_Lock",_name],"ACT\ACT_Lock.sqf",[],99,false,true,"", "(alive _target) && !(locked _target) && ((name player)==(_target getVariable ""FFA_OWNER""))"];
//		_id=_veh addAction [format[localize "STR_ACT_Unlock",_name],"ACT\ACT_Lock.sqf",[],98,false,true,"", "(alive _target) && (locked _target) && ( ((name player)==(_target getVariable ""FFA_OWNER"")) || (({(_x getVariable ""FFA_SELFNAME"")==(_target getVariable ""FFA_OWNER"")} count FFA_CURRENTPLAYERS)==0) )"];
		_id=_veh addAction [format[localize "STR_ACT_Unlock",_name],"ACT\ACT_Lock.sqf",[],98,false,true,"", "(alive _target) && (locked _target) && ( ((name player)==(_target getVariable ""FFA_OWNER"")) )"];
		_id=_veh addAction [format[localize "STR_ACT_FieldRepair",_name],"ACT\ACT_FieldRepair.sqf",[],97,false,true,"", "(alive _target) && (({alive _x} count crew _target)==0) && (!(canMove _target) || ((getDammage _target)>0.1) || ((fuel _target)==0)) && !FFA_PROCESSREPAIR && !(locked _target)"];
		_id=_veh addAction [format[localize "STR_ACT_Repair",_name],"ACT\ACT_ServiceVehicle.sqf",[],80,false,true,"", "(local player) && (alive player) && ((vehicle player)!=player) && ((vehicle player)==_target) && (local (vehicle player)) && (speed (vehicle player)<5) && (((getPosATL (vehicle player) select 2) < 5) || ((vehicle player)isKindOf 'StaticWeapon')) && ((_target in list Base) || (_target in list Base1) || (_target in list Base2) || (_target in list Base3) || ({((_target distance _x) < FFA_REPAIRVEHICLERANGE) && (alive _x)} count nearestObjects [_target,FFA_REPAIRVEHICLES,FFA_REPAIRVEHICLERANGE]>0)) && !(FFA_PROCESSREPAIR) && !((typeOf _target) in FFA_NOSERVICEVEHICLES)"];
		_id=_veh addAction [format[localize "STR_ACT_Rearm",_name],"ACT\ACT_Rearm.sqf",[],81,false,true,"", "(local player) && (alive player) && ((vehicle player)!=player) && ((vehicle player)==_target) && ((local (vehicle player)) || (player==(gunner (vehicle player)))) && (speed (vehicle player)<5) && (((getPosATL (vehicle player) select 2) < 5) || ((vehicle player)isKindOf 'StaticWeapon')) && (((vehicle player) in list Base) || ((vehicle player) in list Base1) || ((vehicle player) in list Base2) || (_target in list Base3) || ({(((vehicle player) distance _x) < FFA_REPAIRVEHICLERANGE) && (alive _x)} count nearestObjects [(vehicle player),FFA_REARMVEHICLES,FFA_REPAIRVEHICLERANGE]>0)) && !(FFA_PROCESSREPAIR) && (((count GetArray (configFile >> 'CfgVehicles' >> typeOf (vehicle player) >> 'Turrets' >> 'MainTurret' >> 'Magazines'))>0) || ((count GetArray (configFile >> 'CfgVehicles' >> typeOf (vehicle player) >> 'Magazines'))>0)) && !((typeOf _target) in FFA_NOSERVICEVEHICLES)"];
		_id=_veh addAction [format[localize "STR_ACT_Easa",_name],"DLG\DLG_Easa.sqf",[],91,false,true,"", "((vehicle player)!=player) && ((vehicle player)==_target) && (local (vehicle player)) && (speed (vehicle player)<5) && (alive (vehicle player)) && ((getPosATL (vehicle player) select 2) < 5) && ((((_target in list Base) || (_target in list Base1) || (_target in list Base2))) || (_target in list Base3) || ({((_target distance _x) < FFA_REPAIRVEHICLERANGE) && (alive _x)} count nearestObjects [_target,FFA_REARMVEHICLES,FFA_REPAIRVEHICLERANGE]>0)) && !FFA_PROCESSREPAIR && ((typeOf (vehicle player)) in FFA_EASAAIR)"];
		_id=_veh addAction [localize "STR_ACT_BuyMedPack","ACT\ACT_BuyMedPack.sqf",[],97,false,true,"", "(local player) && (alive player) && ((vehicle player)==player) && ((player distance _target)<10) && ((typeOf _target) in FFA_HEALBASE)"];

		FFA_PRIVATEVEHICLES=FFA_PRIVATEVEHICLES+[_veh];
	};
};

FFA_FUNC_JUMP=
{
	private["_pl","_dr","_vl","_key","_timejump","_cWeap","_pWeap"];
	_pl=_this select 0;
	_key=_this select 1;
	_timejump=_pl getVariable "JumpTime";
	if ((_key!=20) || !(alive _pl) || !(local player) || ((vehicle player) != player) || ((player getVariable 'FFA_LIFESTATE') > FFA_LIFESTATE_INJURED) || ((animationState player) =='AinvPknlMstpSlayWrflDnon_medic') || ((animationState player)=='AmovPpneMstpSrasWrflDnon_healed') || ((animationState player)=='AinvPknlMstpSlayWrflDnon_healed') || ((animationState player)=='AinvPknlMstpSlayWrflDnon_healed2') || ((animationState player) =='aidlppnemstpsraswrfldnon0s') || (FFA_DRAGREQUIRED) || ((_timejump-time)>0)) exitWith {};
	_pl setvariable ["JumpTime",time+2];
	_dr = getDir _pl;
	_pWeap = primaryWeapon player;
	_cWeap = currentWeapon player;
	if ((speed _pl >= 0) && (speed _pl <= 15))then
	{
		_vl = [3.5*sin _dr, 3.5*cos _dr, 4.0];
	};
	if ((speed _pl > 15) && (speed _pl <= 24))then
	{
			_vl = [4.5*sin _dr, 4.5*cos _dr, 4.5];
	};
	if ((speed _pl > 24) && (speed _pl <= 32))then
	{
		_vl = [6.0*sin _dr, 6.0*cos _dr, 4.5];
	};
	if ((speed _pl < 0))then
	{
		_vl = [-3.0*sin _dr, -3.0*cos _dr, 4.0];
	};
	_pl setVelocity _vl;
	if (_cWeap == _pWeap) then
	{
		_pl switchMove "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutLow";
		sleep 0.9;
		_pl switchMove "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutLow";
		sleep 0.9;
	}
	else
	{
		sleep 1.8;
	};
};