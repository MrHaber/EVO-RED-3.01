//take medpack

//private ["_veh"];

while {!(FFA_GAMEENDED)} do
{
sleep 1.0;


WaitUntil {sleep 0.2;(local player) && (alive player) && ((vehicle player)==player) && ((player distance nearestObject[player,"MASH"])<10) && (alive nearestObject[player,"MASH"]) && !(isNull nearestObject[player,"MASH"])};

//_veh=nearestObject[player,'Camp_base'];
ACT_BuyMed=player addAction [localize "STR_ACT_BuyMedPack","ACT\ACT_BuyMedPack.sqf",1];

WaitUntil {sleep 0.2;!(local player) || !(alive player) || ((vehicle player)!=player) || ((player distance nearestObject[player,"MASH"])>10) || !(alive nearestObject[player,"MASH"]) || (isNull nearestObject[player,"MASH"])};

player removeAction ACT_BuyMed;
};

