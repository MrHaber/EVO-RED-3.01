private["_Killer","_Punishment","_LinkedToPlayer","_numkiller","_namekiller","_n"];
_Killer = _This Select 0;
_Punishment = _This Select 1;
_LinkedToPlayer = _This Select 2;

_numkiller = GetPlayerUID _Killer;
_namekiller = Name _Killer;
Punish_YES = false;
_n = 15;
 
If (_LinkedToPlayer) Then 
{
  Sleep 1;
//	_Act = (vehicle Player) AddAction ['<t color="#00FF00">' + format [ localize "STR_TKL_ACT_FORGIVE_KILLER:_%1",_namekiller] + '</t>', "TKL\TKL_VoteAction_Punish.sqf",[],25,false];
        _Act = (vehicle Player) AddAction ['<t color="#00FF00">' + format [ localize "STR_TKL_ACT_PUNISH_KILLER:_%1",_namekiller] + '</t>', "TKL\TKL_VoteAction_Punish.sqf",[],25,false];
	While {(!Punish_YES) && (_n > 0)} Do
		{
			if (((player getVariable "FFA_LIFESTATE") == FFA_LIFESTATE_DYING) || (!(alive player))) then
			 {
			 	(vehicle Player) RemoveAction _Act;
			 	waitUntil {sleep 0.2;alive player;((player getVariable "FFA_LIFESTATE") < FFA_LIFESTATE_DYING)};
			 	sleep 0.2;
//			 	_Act = (vehicle Player) AddAction ['<t color="#00FF00">' + format [ localize "STR_TKL_ACT_FORGIVE_KILLER:_%1",_namekiller] + '</t>', "TKL\TKL_VoteAction_Punish.sqf",[],25,false];
                    _Act = (vehicle Player) AddAction ['<t color="#00FF00">' + format [ localize "STR_TKL_ACT_PUNISH_KILLER:_%1",_namekiller] + '</t>', "TKL\TKL_VoteAction_Punish.sqf",[],25,false];
			 };
//		TitleText [format[ localize "STR_TKL_FORGIVE_KILLER",_n],"Plain"];
            TitleText [format[ localize "STR_TKL_PUNISH_KILLER",_n],"Plain"];
		Sleep 1;
		_n = _n - 1;
		If (Punish_YES) Then {_n==0;((_numkiller)+"_Side") SetMarkerPos [(GetMarkerPos ((_numkiller)+"_Side") Select 0)+_Punishment,0];Player CommandChat format [localize "STR_TKL_NAME_PUNISH_%1",_namekiller];};
		};
	TitleText ["","Plain"];
	(vehicle Player) RemoveAction _Act;
	Controlteamatk=true;
};
Controlteamatk=true;
 
//If (!Punish_YES) Then {((_numkiller)+"_Side") SetMarkerPos [(GetMarkerPos ((_numkiller)+"_Side") Select 0)+_Punishment,0];Player CommandChat format [localize "STR_TKL_NAME_PUNISH_%1",_namekiller];};
