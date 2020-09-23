//Action: Buy Medpack

if ((paramsArray select 6) <= (score player)) then
{
	player setvariable ["MedPack",(paramsArray select 5),false];
	if ((paramsArray select 6) != 0) then
	{
	 [FFA_CMD_OUTCOMEREQUEST,FFA_PLAYERSLOT,(paramsArray select 6)] call FFA_FUNC_PLAYERTOCLIENT;
  };
	hint format[localize "STR_HINT_HealPackets",(paramsArray select 5)];	
	if ((paramsArray select 6)>0) then
	{
		sleep 3;
		hint format[localize "STR_HINT_MinusPoints",(paramsArray select 5)];	
	};
}
else
{
	hint localize "STR_HINT_ScoreLow";
};
exit;