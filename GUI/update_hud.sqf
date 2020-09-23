//Inmission GUI with players names and airstrike target icon

private["_i","_name","_unitname","_unit","_lifestate","_text","_control","_pos","_veh","_dst"];

if (!(local player)) exitWith{};

sleep 1;

disableSerialization;
_currentCutDisplay = _this select 0;

while {(alive player) && !((vehicle player) isKindOf "BIS_Steerable_Parachute")} do
{
	sleep 0.03;
	if ((FFA_MARKERS_DISTANCE > 0) || ((currentWeapon player)=="LaserDesignator") || ((typeOf (vehicle player)) in FFA_ASSAULTAIR)) then
	{
		if (FFA_MARKERS_DISTANCE > 0) then
		{
//			for [{_i=1},{_i<=40},{_i=_i+1}] do
      for "_i" from 1 to 40 step 1 do
			{
				if (!isNil {call compile format ["ES%1",_i]}) then
				{		
				  _unit=[] call compile format ["ES%1",_i];

				  _control=_currentCutDisplay displayCtrl (500+_i);
				
				  _veh=vehicle _unit;
				  _dst=round (_veh distance (vehicle player));
		
				  if ((isPlayer _unit) && (_unit!=player) && !(isNull _unit) && ((vehicle _unit)!=(vehicle player)) && (_dst<=FFA_MARKERS_DISTANCE) && ((_unit in (units player)) || (FFA_MARKERS_TYPE!=FFA_MARKERS_GROUP)) && !(visibleMap) && (alive player)) then
				  {
					 _unitname=_unit getVariable "FFA_SELFNAME";			
					 _pos=getPosATL _veh;				
					
					 if (_veh!=_unit)  then
					 {
						if (((_unit==(effectiveCommander _veh)) && (FFA_MARKERS_TYPE!=FFA_MARKERS_INFANTRY)) || ((_unit in (units player)) && (FFA_MARKERS_TYPE==FFA_MARKERS_GROUP))) then
						{
							if (_dst<=((FFA_MARKERS_DISTANCE)/4)) then 
							{
								_text = gettext(configFile >> "CfgVehicles" >> (typeof _veh) >> "displayName");
								_mask="<t size='%4' shadow='true' align='center' color='%5'>%1</t><br/><t size='%4' shadow='true' align='center' color='%6'>[%2]</t><br/><t size='%4' shadow='true' align='center' color='%7'>%3m</t>";
								_name=parseText format[_mask,_unitname,_text,_dst,0.9,"#AAFFAA","#FFFFFF","#AAAAFF"];
								_pos=[_pos select 0,_pos select 1,(_pos select 2)+4];
							}
							 else 
							 {
								_mask="<t size='%1' shadow='true' align='center' color='%2'>.</t>";
								_name=parseText format[_mask,2.0,"#AAFFAA"];
								_pos=[_pos select 0,_pos select 1,(_pos select 2)+4];
							 };
						}
						else
						{
							_name=parseText "";
						};
					 }
					 else
					 {
						if ((FFA_MARKERS_TYPE!=FFA_MARKERS_VEHICLES)) then
						{
							_lifestate=_unit getVariable "FFA_LIFESTATE";				
							_pos=[_pos select 0,_pos select 1,(_pos select 2)+2.5];												
							_name=parseText "";
							
							if (_dst<=((FFA_MARKERS_DISTANCE)/4)) then 
						  {				
							  if (!isNil "_lifestate") then
				        {
								  switch (_lifestate) do
								  {
									  case FFA_LIFESTATE_HEALTHY:
									  {
										 _mask="<t size='%3' shadow='true' align='center' color='%4'>%1</t><br/><t size='%3' shadow='true' align='center' color='%5'>%2m</t><br/>";
										 _name=parseText format[_mask,_unitname,_dst,0.9,"#AAFFAA","#AAAAFF"];						
									  };
									  case FFA_LIFESTATE_INJURED:
									  {
										 _mask="<t size='%4' shadow='true' align='center' color='%5'>%1</t><br/><t size='%4' shadow='true' align='center' color='%6'>[%2]</t><br/><t size='%4' shadow='true' align='center' color='%7'>%3m</t>";
										 _name=parseText format[_mask,_unitname,localize "STR_MAP_Injured",_dst,0.9,"#AAFFAA","#FF0000","#AAAAFF"];
									  };
									  case FFA_LIFESTATE_DYING:
									  {
										 _mask="<t size='%4' shadow='true' align='center' color='%5'>%1</t><br/><t size='%4' shadow='true' align='center' color='%6'>[%2]</t><br/><t size='%4' shadow='true' align='center' color='%7'>%3m</t>";
										 _name=parseText format[_mask,_unitname,localize "STR_MAP_Dying",_dst,0.9,"#AAFFAA","#FF0000","#AAAAFF"];
									  };
									  case FFA_LIFESTATE_DEAD:
									  {
										 _mask="<t size='%4' shadow='true' align='center' color='%5'>%1</t><br/><t size='%4' shadow='true' align='center' color='%6'>[%2]</t><br/><t size='%4' shadow='true' align='center' color='%7'>%3m</t>";
										 _name=parseText format[_mask,_unitname,localize "STR_MAP_Dead",_dst,0.9,"#AAFFAA","#FF0000","#AAAAFF"];
									  };	
								  };
							  };
							}
							 else
							{
								_mask="<t size='%1' shadow='true' align='center' color='%2'>.</t>";
								_name=parseText format[_mask,2.0,"#AAFFAA"];
							};													
						}
						else
						{
							_name=parseText "";	
						};
					 };
					 _pos=worldToScreen _pos;		
					 if ((count _pos)!=0) then
					 {				
						ctrlShow[_control,true];				
						_control ctrlSetStructuredText _name;
						_control ctrlSetPosition [(_pos select 0)-0.125,_pos select 1];
						_control ctrlCommit 0;
						waitUntil {ctrlCommitted _control};
					 }
					 else
					 {
						ctrlShow[_control,false];
						_control ctrlSetStructuredText parseText "";
						_control ctrlCommit 0;
						waitUntil {ctrlCommitted _control};
					 };
				  }
				  else
				  {
					ctrlShow[_control,false];
					_control ctrlSetStructuredText parseText "";
					_control ctrlCommit 0;
					waitUntil {ctrlCommitted _control};
				  };
			  };
	    };
    };
		if (((currentWeapon player)=="LaserDesignator") || (((typeOf (vehicle player)) in FFA_ASSAULTAIR) && ((player==driver (vehicle player)) || (player==gunner (vehicle player))))) then
		{			
			if (count FFA_DESIGNATION_TARGET > 0) then
			{
				_dst=round((vehicle player) distance FFA_DESIGNATION_TARGET);
				_text=round(90+FFA_DESIGNATION_TIME-time);
				_mask="<t size='%4' shadow='true' align='center' color='%5'>%1</t><br/><t size='%4' shadow='true' align='center' color='%6'>%2sec</t><br/><t size='%4' shadow='true' align='center' color='%7'>%3m</t><br/><t><img image='gui\selector_selectedmission_ca.paa' align='center' color='%5' size='3.0'></t>";
				_name=parseText format[_mask,localize "STR_MAP_AirStrike",_text,_dst,1.0,"#FF0000","#FFFFFF","#AAAAFF"];
				_pos=worldToScreen FFA_DESIGNATION_TARGET;
				if (count _pos > 0) then
				{
					_control=_currentCutDisplay displayCtrl (541);			
					ctrlShow[_control,true];
					_control ctrlSetPosition [(_pos select 0)-0.125,(_pos select 1)-0.125];
					_control ctrlSetStructuredText _name;
					_control ctrlCommit 0;
					waitUntil {ctrlCommitted _control};				
				};
				if (_text <= 0) then
				{
					FFA_DESIGNATION_TARGET=[];
				};
			}
			else
			{
				_control=_currentCutDisplay displayCtrl (541);
				ctrlShow[_control,false];
				_control ctrlSetStructuredText parseText "";
				_control ctrlCommit 0;
				waitUntil {ctrlCommitted _control};
			};
		}
		else
		{
			_control=_currentCutDisplay displayCtrl (541);
			ctrlShow[_control,false];
			_control ctrlSetStructuredText parseText "";
			_control ctrlCommit 0;
			waitUntil {ctrlCommitted _control};
		};
	}
	else
	{		
//		for [{_i=1},{_i<=40},{_i=_i+1}] do
    for "_i" from 1 to 40 step 1 do
		{
			_control=_currentCutDisplay displayCtrl (500+_i);
			ctrlShow[_control,false];
			_control ctrlSetStructuredText parseText "";
			_control ctrlCommit 0;
			waitUntil {ctrlCommitted _control};
		};
		sleep 10+(random 10);
	};
};