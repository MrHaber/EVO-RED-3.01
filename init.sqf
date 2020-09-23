#include "defines.sqf"

if (isServer) then
{	

	[] execVM "INIT\INIT_Server.sqf";
	[] execVM "SYS\SYS_Server.sqf";
	[] execVM "SYS\SYS_ServerClear.sqf";
	[] execVM "SYS\SYS_ServerCheats.sqf";
	[] execVM "clearbombfrombase.sqf";
	[] execVM "clearenemyveh.sqf";
	[] execVM "SYS\CMD_ServerShop_init.sqf";

if (!(local player)) then
	{
		[] execVM "SYS\SYS_Common.sqf";
		[] execVM "INIT\INIT_Common.sqf";
		#ifdef __USE_ACE__	
	   [] execVM "INIT\INIT_ArraysACE.sqf";
    #else
	   [] execVM "INIT\INIT_Arrays.sqf";
    #endif
	};
	onPlayerConnected "[_name,_uid] spawn FFA_FUNC_PLAYERCONNECTED";
	onPlayerDisconnected "[_name,true,[]] spawn FFA_FUNC_PLAYERDISCONNECTED";
};

if(!isServer || local player) then
{
	cutRsc ["BackBlack","plain"];

	sleep 0.1;
	
	waitUntil{(player==player)};
	waitUntil{alive player};
	waitUntil{local player};
	//[] execVM "new_effects\init2.sqf";
	[] execVM "INIT\INIT_Client.sqf";
	[] execVM "ca\modules\btk\cargo_drop\start.sqf";
};
if (!(isDedicated)) then 
{
	waitUntil {!isNull player};
	waitUntil {player == player};
        [] execVM "scripts\LowGear\LowGear_Init.sqf";
};
//AntiTeamKill System 
if ((paramsArray select 7)>0) then
{
 [paramsArray select 7,900] execVM "TKL\TKL_Manager.sqf";
 TKL_Killed = compile preprocessFile "TKL\TKL_Killed.sqf";
 FN_GET_TKL_UnitSide = compile preprocessFile "TKL\FN_GET_TKL_UnitSide.sqf";
 TKL_Punishment = compile preprocessFile "TKL\TKL_Punishment.sqf";
};
EAST setFriend [RESISTANCE, 0];
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 1];
WEST setFriend [RESISTANCE, 1];
#ifdef __USE_ACE__
	if (isServer) then
	{
		ace_sys_wounds_enabled = true;
		publicVariable "ace_sys_wounds_enabled";
		ace_sys_aitalk_radio_enabled = true;
		publicVariable "ace_sys_aitalk_radio_enabled";
		ace_sys_tracking_markers_enabled_override = true;
		publicVariable "ace_sys_tracking_markers_enabled_override";
		ace_sys_tracking_markers_enabled = false;
		publicVariable "ace_sys_tracking_markers_enabled";
		
	};	
#endif

[] execVM "new_effects\init2.sqf";
as = [] execVM "time.sqf"