//counteattack
		
[] call FFA_FUNC_DESTROYALL;

FFA_TOWNGUARDSSPAWNED=false;

private["_marker","_list","_enemy","_count","_cnt"];

{_x addScore 10} forEach (list FFA_EASTSENSOR);

sleep 0.5;

FFA_CAT=true;
publicVariable "FFA_CAT";

sleep (120 + random(120));

FFA_COUNTER_START=true;
publicVariable "FFA_COUNTER_START";
publicVariable "FFA_CURRENTTOWNMARKER";

_marker=getMarkerPos FFA_CURRENTTOWNMARKER;
_enemy=getMarkerpos "EnemyArea";
FFA_ENEMYATTACK1 setPos getMarkerPos FFA_CURRENTTOWNMARKER;

//arty
[_marker, 100, 400, "ARTY_Sh_105_HE"] spawn FFA_FUNC_SHELLING;
sleep 1;
[_marker, 100, 400, "ARTY_Sh_105_HE"] spawn FFA_FUNC_SHELLING;

sleep 20;

if ((playersNumber east)<15) then
{
	//airborne
	_count = 2 + (floor ((playersNumber east)/5));
	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
		{
    		[] spawn FFA_FUNC_CALLAIRBORNE_CITY;
		};

	sleep 30;

	//air
	[(1+(floor ((playersNumber east)/4))),_enemy,FFA_REINFORCEMENT,0,0,1500,5000,false,false,true] spawn FFA_FUNC_CALLREINFORCEMENT;

	sleep 20;

	//vehicles
	[(1+(floor ((playersNumber east)*1.2))),_marker,FFA_REINFORCEMENT,0,300,0,0,true,false,false] spawn FFA_FUNC_CALLREINFORCEMENT;

	sleep 5;

	//units
	[(1+(floor ((playersNumber east)/4))),_marker,FFA_REINFORCEMENT,250,0,0,0,false,true,false] spawn FFA_FUNC_CALLREINFORCEMENT;
}
else
{
	//airborne
	_count = 2 + (floor ((playersNumber east)/6));
	for [{_cnt=0},{_cnt<_count},{_cnt=_cnt+1}] do
		{
    		[] spawn FFA_FUNC_CALLAIRBORNE_CITY;
		};

	sleep 30;

	//air
	[(1+(floor ((playersNumber east)/5))),_enemy,FFA_REINFORCEMENT,0,0,1500,5000,false,false,true] spawn FFA_FUNC_CALLREINFORCEMENT;

	sleep 20;

	//vehicles
	[(1+(floor ((playersNumber east)*1.1))),_marker,FFA_REINFORCEMENT,0,300,0,0,true,false,false] spawn FFA_FUNC_CALLREINFORCEMENT;

	sleep 5;

	//units
	[(1+(floor ((playersNumber east)/5))),_marker,FFA_REINFORCEMENT,250,0,0,0,false,true,false] spawn FFA_FUNC_CALLREINFORCEMENT;	
};
//give time for enemies
sleep 300;

FFA_COUNTER_START_END=true;
publicVariable "FFA_COUNTER_START_END";

sleep 300;

//check counter attack results
FFA_CAT=false;
publicVariable "FFA_CAT";
FFA_COUNTER_START_END=false;
publicVariable "FFA_COUNTER_START_END";
FFA_COUNTER_START=false;
publicVariable "FFA_COUNTER_START";

_list = List FFA_ENEMYATTACK1; 
if ((("landVehicle" countType _list) > 1) or (("Man" countType _list) > 5)) 
then 
{FFA_TNDEF = 2}
else 
{FFA_TNDEF = 3};

publicVariable "FFA_TNDEF";

FFA_TOWNGUARDSSPAWNED=true;