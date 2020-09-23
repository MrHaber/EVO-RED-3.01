Controlteamatk=true;

TKL_Limit = _This Select 0;

_TKL_Remover_Delay = _This Select 1;

_TKL_Remover_Timer = Time + _TKL_Remover_Delay;

_m = GetPlayerUID Player;

If (isServer) Then
	{
	 Black_List = [];
   publicVariable "Black_List";
   TKL_Kills_One = [];
   publicVariable "TKL_Kills_One";
   TKL_Kills_Two = [];
   publicVariable "TKL_Kills_Two";
   TKL_Kills_Three = [];
   publicVariable "TKL_Kills_Three";
   TKL_Kills_Four = [];
   publicVariable "TKL_Kills_Four";
   
	 createMarker ["TKL_Log", [0,0]];
	"TKL_Log" setMarkerType "empty";
	}
	Else
	{
	waitUntil {player == player};
    sleep 0.5;
	};
	
FFA_CLIENTINITSTARTED = false;

sleep 7;

waitUntil{(FFA_SERVERSTARTED)};

((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)+1,0];

Sleep 1;

If ((MarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 0) Then
	{
	 createMarker [(GetPlayerUID Player)+"_Side", [0,0]];
	(GetPlayerUID Player)+"_Side" setMarkerType "empty";
	if  ((GetPlayerUID Player) in Black_List) Then {(GetPlayerUID Player)+"_Side" setMarkerText "BANNED";};
  if  ((GetPlayerUID Player) in TKL_Kills_One) then {((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)+1,0]; };
  if  ((GetPlayerUID Player) in TKL_Kills_Two) then {((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)+2,0]; };
  if  ((GetPlayerUID Player) in TKL_Kills_Three) then {((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)+3,0]; };
  if  ((GetPlayerUID Player) in TKL_Kills_Four) then {((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)+4,0]; };
 //   Player CommandChat format [ localize "STR_TKL_CREATING_A_NEW_RECORD"];
	}
	Else
	{
	((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)-1,0];
	Player CommandChat format [ localize "STR_TKL_RECORD_ALREADY_EXIST"];
	};                                        
Sleep 1;

If (MarkerText ((GetPlayerUID Player)+"_Side") != "BANNED") Then
	{
//	Player CommandChat format [ localize "STR_TKL_LIST_UPDATED"];
	(GetPlayerUID Player)+"_Side" setMarkerText ([player] Call FN_GET_TKL_UnitSide);
	Player CommandChat format [ localize "STR_TKL_LIMIT_%1/%2",(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0),TKL_Limit];
	waitUntil{(FFA_CLIENTINITSTARTED)};
	_n = (GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0);
	_TKL_Log_Timer = Time;
	While {(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) < TKL_Limit} Do
		{	
		 If ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) > _n) Then
		   {
		 	  _n = (GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0);
		 	
		 	  [] spawn TKL_Punishment;
			
   		  If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 1) then {TKL_Kills_One = TKL_Kills_One + [_m];publicVariableServer "TKL_Kills_One";sleep 0.2;};
        
		    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 2) then {TKL_Kills_Two = TKL_Kills_Two + [_m];publicVariableServer "TKL_Kills_Two";TKL_Kills_One = TKL_Kills_One - [_m];publicVariableServer "TKL_Kills_One";sleep 0.2;};

		    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 3) then {TKL_Kills_Three = TKL_Kills_Three + [_m];publicVariableServer "TKL_Kills_Three";TKL_Kills_One = TKL_Kills_One - [_m];publicVariableServer "TKL_Kills_One";TKL_Kills_Two = TKL_Kills_Two - [_m];publicVariableServer "TKL_Kills_Two";sleep 0.2;};

		    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 4) then {TKL_Kills_Four = TKL_Kills_Four + [_m];publicVariableServer "TKL_Kills_Four";TKL_Kills_Three = TKL_Kills_Three - [_m];publicVariableServer "TKL_Kills_Three";TKL_Kills_One = TKL_Kills_One - [_m];publicVariableServer "TKL_Kills_One";TKL_Kills_Two = TKL_Kills_Two - [_m];publicVariableServer "TKL_Kills_Two";sleep 0.2;};		
	     };
		
		// TK list will be copied every 5min
		 If (Time > _TKL_Log_Timer) Then {_TKL_Log_Timer = _TKL_Log_Timer + 300; CopyToClipboard ("TKL_Log: "+MarkerText "TKL_Log");};
		 If (Time > _TKL_Remover_Timer) Then
			{
			 _TKL_Remover_Timer = _TKL_Remover_Timer + _TKL_Remover_Delay;
			 If ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) > 0) Then
			  {
			 	 ((GetPlayerUID Player)+"_Side") SetMarkerPos [(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0)-1,0];
			 	  _n = _n - 1;
				  TKL_Kills_One = TKL_Kills_One - [_m];publicVariableServer "TKL_Kills_One";
				  TKL_Kills_Two = TKL_Kills_Two - [_m];publicVariableServer "TKL_Kills_Two";
				  TKL_Kills_Three = TKL_Kills_Three - [_m];publicVariableServer "TKL_Kills_Three";
				  TKL_Kills_Four = TKL_Kills_Four - [_m];publicVariableServer "TKL_Kills_Four";
				  sleep 0.2;
			    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 1) then {TKL_Kills_One = TKL_Kills_One + [_m];publicVariableServer "TKL_Kills_One";};
			    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 2) then {TKL_Kills_Two = TKL_Kills_Two + [_m];publicVariableServer "TKL_Kills_Two";};
			    If  ((GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0) == 3) then {TKL_Kills_Three = TKL_Kills_Three + [_m];publicVariableServer "TKL_Kills_Three";};
			    Player CommandChat format [ localize "STR_TKL_LIMIT_%1/%2",(GetMarkerPos ((GetPlayerUID Player)+"_Side") Select 0),TKL_Limit];
			  };				
			};
			sleep 1;
		};
	"TKL_Log" setMarkerText (MarkerText "TKL_Log")+name Player+"="+(GetPlayerUID Player)+",";
	(GetPlayerUID Player)+"_Side" setMarkerText "BANNED";
	Black_List = Black_List+[_m];publicVariableServer "Black_List";
	}
	Else
	{
	Player CommandChat format [ localize "STR_TKL_BANNED"];
	};

While {True} Do
	{
	DisableUserInput True;
	TitleText [ localize "STR_TKL_BLACK_FADED","BLACK FADED"];
	sleep 1;
	};
