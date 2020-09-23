//Antiair award
while {!(FFA_GAMEENDED)} do
{
	sleep 0.5;
	WaitUntil {sleep 0.2;(local player) && (player getVariable 'FFA_ANTIAIRUNIT')};
	['#0000FF',localize 'STR_HINT_AwardHeader',localize 'STR_HINT_AntiAirAward'] call FFA_FUNC_MESSAGE;
	player setVariable ['FFA_ANTIAIRUNIT',false];
	WaitUntil {sleep 0.2;!(local player) || !(player getVariable 'FFA_ANTIAIRUNIT')};
};