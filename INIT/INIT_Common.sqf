//Both server and client initialization script
//don`t modify values of uncommented variables - they are related to mission system

#include "defines.sqf"
#include "mission.sqf"

FFA_DELETEBODIESTIMEOUT=180;//timeout of dead units deleting

FFA_LUVEHICLE=objNull;
FFA_LASTLUVEHICLE=objNull;
FFA_REPVEHICLE=objNull;
FFA_LASTREPVEHICLE=objNull;
FFA_SMOKESHELLS=[];
FFA_ATGMTARGET=objNull;
FFA_MISSILETARGET=objNull;
FFA_AWARDUNIT_TRANSPORT=objNull;
FFA_AWARDUNIT_MEDIC=objNull;
FFA_AWARDUNIT_RADIO=objNull;
FFA_TRANSFER_UNIT=objNull;
FFA_TRANSFER_TARGET=objNull;
FFA_TRANSFER_POINTS=0;
FFA_INJURED=objNull;
FFA_MEDIC=objNull;
FFA_WEATHER="";
FFA_DEFAULTFLARES=40;
FFA_DEFAULTSMOKES=15;

FFA_CAT=false;
FFA_COUNTER_START=false;
FFA_COUNTER_START_END=false;
FFA_ENEMY_PRES=false;
FFA_RERADIO=false;

FFA_DESTROYRADIOAWARD=50;//award for radio destruction
FFA_TRANSPORTAWARD=10;//basic award for units transportation
FFA_MEDICAWARD=10;//award for first aid to friendly
FFA_CAPTUREAWARD=20;//award for capture 
FFA_TRANSPORTAWARDDISTANCE=1000;//you receive FFA_TRANSPORTAWARD*<transported distance>/FFA_TRANSPORTAWARDDISTANCE for each transported unit
FFA_ANTIAIRAWARD=10;//basic award for shoting down an enemy

//FFA_CMD_VEHICLEREQUEST=1027;
FFA_CMD_VEHICLEREQUEST=1;
//FFA_CMD_UNITREQUEST=1028;
FFA_CMD_UNITREQUEST=2;
//FFA_CMD_INCOMEREQUEST=1029;
FFA_CMD_INCOMEREQUEST=3;
//FFA_CMD_OUTCOMEREQUEST=1030;
FFA_CMD_OUTCOMEREQUEST=4;
//FFA_CMD_TRANSFERREQUEST=1031;
FFA_CMD_TRANSFERREQUEST=5;

BIS_Effects_SmokeLauncher=compile preprocessFileLineNumbers "SYS\functions\ffa_func_blank.sqf";
