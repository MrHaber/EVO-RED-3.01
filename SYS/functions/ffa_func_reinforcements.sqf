	//performes timing of reinforcements to the city	
	private["_modifier","_man","_land","_currentman","_currentland","_enemy","_friendly"];
	_modifier=0.9;
	_man=("man" countType list FFA_WESTSENSOR)*_modifier;
	_land=("LandVehicle" countType list FFA_WESTSENSOR)*_modifier;
	_enemy=getMarkerpos "EnemyArea";
	_friendly=getMarkerPos "respawn_east";

	while {(alive FFA_RADIO) && !(FFA_CURRENTTOWNCAPTURED)} do
	{
		_lastTime=time;
		while {(time<(_lasttime+(FFA_BASEREINFORCEMENTSTIME*FFA_REINFORCEMENTSTIMEMODIFIER)/((playersNumber east)+1))) && (alive FFA_RADIO) && (!FFA_CURRENTTOWNCAPTURED)} do
		{
			sleep 15+(random 15);
		};
		_currentman=("man" countType list FFA_WESTSENSOR);
		_currentland=("LandVehicle" countType list FFA_WESTSENSOR);
		
		if (((_currentman < _man) || (_currentland < _land)) || !(alive FFA_RADIO) || FFA_CURRENTTOWNCAPTURED) then
		{	
			if (!(alive FFA_RADIO) || FFA_CURRENTTOWNCAPTURED) exitWith{};	
			if ((_currentman < _man) && (_currentland < _land))  then
			{
				[2+(floor ((playersNumber east)/10)),_enemy,FFA_REINFORCEMENT,250,300,0,0,true,true,false] call FFA_FUNC_CALLREINFORCEMENT;
			}
			else
			{
				if (_currentman < _man) then
				{
					[1+(floor ((playersNumber east)/8)) max 1,_enemy,FFA_REINFORCEMENT,250,0,0,0,false,true,false] call FFA_FUNC_CALLREINFORCEMENT;
				};
				if (_currentland < _land) then
				{
					[2+(floor ((playersNumber east)/5)) max 1,_enemy,FFA_REINFORCEMENT,0,300,0,0,true,false,false] call FFA_FUNC_CALLREINFORCEMENT;
				};
			};
			
			if ((random 10) < 4.0) then
			{ 			
			[1+(floor ((playersNumber east)/10)),_enemy,FFA_REINFORCEMENT,0,0,1500,5000,false,false,true] call FFA_FUNC_CALLREINFORCEMENT;
			};
			
			if (((random 10) < 2.0) && ((east countSide (list base))>1)) then
			{
				[] call FFA_FUNC_ATTACKBASE;
			};
			if (((random 10) < 4.0) && ((playersNumber east)>2)) then
			{
				[] call FFA_FUNC_CALLAIRBORNE_CITY;
			};
			if (((random 10) < 2.0) && ((west countSide (list base))<5)) then
			{
				[_friendly,10+(random 15),300,"ARTY_Sh_105_HE"] spawn FFA_FUNC_SHELLING;
			};
		};
	};