//City captured message
while {!(FFA_GAMEENDED)} do
{
	sleep 0.5;
	WaitUntil {sleep 0.2;(local player) && (FFA_CLIENTREPORTOBJDONE) && (FFA_SERVERSTARTED) && (FFA_CLIENTSTARTED)};
	[] call FFA_FUNC_CLOSETASK;
	WaitUntil {sleep 0.2;!(local player) || !(FFA_CLIENTREPORTOBJDONE) || !(FFA_SERVERSTARTED) || !(FFA_CLIENTSTARTED)};
};