//CAT message
while {!(FFA_GAMEENDED)} do
{
	sleep 0.5;
	WaitUntil {(local player) && (FFA_CAT) && (FFA_SERVERSTARTED) && (FFA_CLIENTSTARTED)};
	[east,'hq'] sideChat localize 'STR_RADIO_CAT';
//	player commandChat localize 'STR_RADIO_CAT';
	WaitUntil {!(local player) || !(FFA_CAT) || !(FFA_SERVERSTARTED) || !(FFA_CLIENTSTARTED)};
};