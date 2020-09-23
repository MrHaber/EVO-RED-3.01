sleep 15;
while {!(FFA_GAMEENDED)} do
{
	sleep 10;
 _currenttime=time;
 _baselist=list Base;
 _currenttown=getMarkerPos FFA_CURRENTTOWNMARKER;

 _cnt=count FFA_CLEARENEMYVEH;
 for [{_i=0},{_i<_cnt},{_i=_i+1}] do
 {
	sleep 0.3;
	_veh=FFA_CLEARENEMYVEH select _i;
	
  if (!(isNull _veh)) then
	{
		if (alive _veh) then
		{
		 _crew=crew _veh;
				if ((({alive _x} count _crew))==0) then
				{
					if ((_veh in _baselist) || ((_veh distance _currenttown)<=1300)) then
					{
						_veh setVariable ["FFA_CLEARENEMYVEHTIME",_currenttime,false];
					}
					else
					{
					  if ((_currenttime-(_veh getVariable "FFA_CLEARENEMYVEHTIME")) > 2400) then
					  {
							_veh setDamage 1;
							FFA_CLEARENEMYVEH set [_i,objNull];
						};
					};
				}
				else
				{
					_veh setVariable ["FFA_CLEARENEMYVEHTIME",_currenttime,false];
				};				
	  };
	}
	else
	{
	FFA_CLEARENEMYVEH set [_i,objNull];
  };	
 };
 FFA_CLEARENEMYVEH=FFA_CLEARENEMYVEH-[objNull];
};