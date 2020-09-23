waitUntil{not(isNil "BIS_Effects_Init")};
sleep 5;

player groupChat localize 'STR_Loading_Graphic_Fixes';


BIS_Effects_AirDestructionStage2=compile preprocessFileLineNumbers "new_effects\AirDestructionStage2.sqf";
