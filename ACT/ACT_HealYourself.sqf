//Action: First aid yourself


if ((player getVariable "MedPack")>0) then 
	{
		player setvariable ["MedPack",((player getVariable "MedPack")-1),false];
	
		player playMove "AinvPknlMstpSlayWrflDnon_medic";

		sleep 5;

		WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};

		player setDamage 0;
		
		[] call FFA_FUNC_RESETLIFESTATE;

		hint format[localize "STR_HINT_HealPackets",(player getVariable "MedPack")];
	} else {
		hint format[localize "STR_HINT_HealPackets",(player getVariable "MedPack")];
	};
