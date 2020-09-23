//Client initialization script
//don`t modify values of uncommented variables - they are related to mission system
#include "defines.sqf"
#include "INIT_Common.sqf"
FFA_CLIENTSTARTED=false;
FFA_GAMEENDED=false;
FFA_TERAINGRID=50;//basic terrain level

setViewDistance 2500;//basic viewdistance
setTerrainGrid FFA_TERAINGRID;

FFA_DLG_ACTIVE_WEAPONS=false;
FFA_DLG_ACTIVE_UNITS=false;
FFA_DLG_ACTIVE_VEHICLES=false;
FFA_DLG_ACTIVE_PLAYERS=false;
FFA_DLG_ACTIVE_SQUAD=false;
/*
FFA_CAT=false;
FFA_COUNTER_START=false;
FFA_COUNTER_START_END=false;
FFA_ENEMY_PRES=false;
FFA_RERADIO=false;
*/
FFA_PRIVATEVEHICLES=[];
//FFA_TOTALPLAYERS= {[ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20,ES21,ES22,ES23,ES24,ES25,ES26,ES27,ES28,ES29,ES30,ES31,ES32,ES33,ES34,ES35,ES36,ES37,ES38,ES39,ES40]};//list of players slots
//FFA_TOTALPLAYERS= {["ES1","ES2","ES3","ES4","ES5","ES6","ES7","ES8","ES9","ES10","ES11","ES12","ES13","ES14","ES15","ES16","ES17","ES18","ES19","ES20","ES21","ES22","ES23","ES24","ES25","ES26","ES27","ES28","ES29","ES30","ES31","ES32","ES33","ES34","ES35","ES36","ES37","ES38","ES39","ES40"]};//list of players slots
//FFA_CURRENTPLAYERS=[];

#ifdef __USE_ACE__
	FFA_USEACE=true;
	FFA_REPAIRVEHICLES=["Mi17_Civilian","BMP2_HQ_INS","BTR90_HQ"];//Vehicles which can repair you
	FFA_REPAIRVEHICLES_WEST=["Mi17_Civilian","BMP2_HQ_INS","BTR90_HQ"];
	FFA_TRANSPORTHELI=["Mi17_Civilian","Mi17_medevac_RU","Mi17_rockets_RU","Mi17_Ins","Mi17_medevac_Ins","UH1Y","MV22","UH60M_EP1","Mi17_TK_EP1"];//choppers that can pick land vehicles
	FFA_ASSAULTAIR=["AH64D","AH1Z","Mi17_rockets_RU","Mi171Sh_rockets_CZ_EP1","Mi24_D","Mi24_P","Mi24_V","Ka52","Ka52Black","L39_TK_EP1","Su25_TK_EP1","UH60M_EP1","AH6J_EP1","Su39","Su34","F35B","A10","MQ9PredatorB_US_EP1","AV8B2","AW159_Lynx_BAF","AH64D_Sidewinders","C130J"];//choppers that see f designation target	
	FFA_EASAAIR=[];
	FFA_EASALOADOUTS_W=[];
	FFA_EASALOADOUTS_M=[];
#else
	FFA_USEACE=false;
	FFA_BASEVEHICLES=["BTR90_HQ","BMP2_HQ_INS"];
	FFA_REPAIRVEHICLES=["Mi17_Civilian","BAF_Merlin_HC3_D","BMP2_HQ_INS","BTR90_HQ"];
	FFA_REPAIRVEHICLES_WEST=["Mi17_Civilian","BAF_Merlin_HC3_D","BMP2_HQ_INS","BTR90_HQ"];
	FFA_REARMVEHICLES=["KamazReammo","BAF_Merlin_HC3_D","BMP2_HQ_INS","BTR90_HQ","Mi17_Civilian"];
	FFA_REARMVEHICLES_WEST=["KamazReammo","BAF_Merlin_HC3_D","BMP2_HQ_INS","BTR90_HQ","Mi17_Civilian"];
	FFA_NOSERVICEVEHICLES=["MtvrReammo"];
	FFA_TRANSPORTHELI=["Mi17_Civilian","BAF_Merlin_HC3_D","Mi17_medevac_RU","Mi17_rockets_RU","Mi17_Ins","Mi17_medevac_Ins","Mi17_TK_EP1","CH_47F_EP1"];
	FFA_TURNINGSTATIC=["2b14_82mm","D30_RU","AGS_RU","DSHKM_Ins","KORD_high","ZU23_Ins","SearchLight_RUS"];
	FFA_TRANSPORTTRUCK=["KamazOpen","Kamaz","KamazReammo","BMP2_HQ_INS","MtvrReammo","MtvrRepair","UralCivil","UralCivil2","V3S_Civ"];
	FFA_ASSAULTAIR=["AH64D","AH1Z","Mi17_rockets_RU","Mi171Sh_rockets_CZ_EP1","Mi24_D","Mi24_P","Mi24_V","Ka52","Ka52Black","L39_TK_EP1","Su25_TK_EP1","UH60M_EP1","AH6J_EP1","Su39","Su34","F35B","A10","MQ9PredatorB_US_EP1","AV8B2","AW159_Lynx_BAF","AH64D_Sidewinders","C130J"];//choppers that see f designation target
	FFA_EASAAIR=["Su34","Su25_TK_EP1","Mi24_V","F35B","A10","Mi24_P","AV8B2","L39_TK_EP1","D30_RU","M119_US_EP1","M252_US_EP1","2b14_82mm","AH64D"];
	FFA_HEALBASE=["BTR90_HQ","BMP2_Ambul_INS","GAZ_Vodnik_MedEvac","Mi17_medevac_Ins","Mi17_medevac_RU","Mi17_INS","BMP2_HQ_INS"];
	FFA_EASALOADOUTS_W=
	[
		//Su34
		[["STR_PRESET_Su34_00",["GSh301","Ch29Launcher_Su34","80mmLauncher","R73Launcher_2","CMFlareLauncher"]],
		["STR_PRESET_Su34_01",["GSh301","Ch29Launcher_Su34","80mmLauncher","R73Launcher_2","CMFlareLauncher"]],
		["STR_PRESET_Su34_02",["GSh301","VikhrLauncher","Ch29Launcher_Su34","80mmLauncher","R73Launcher_2","CMFlareLauncher"]],
		["STR_PRESET_Su34_03",["GSh301","R73Launcher_2","80mmLauncher","CMFlareLauncher"]],
                ["STR_PRESET_Su34_04",["GSh301","R73Launcher_2","CMFlareLauncher"]],
                ["STR_PRESET_Su34_05",["GSh301","Ch29Launcher_Su34","CMFlareLauncher"]],
                ["STR_PRESET_Su34_06",["GSh301","80mmLauncher","CMFlareLauncher"]],
                ["STR_PRESET_Su34_07",["GSh301","80mmLauncher","CMFlareLauncher"]],
                ["STR_PRESET_Su34_08",["GSh301","AirBombLauncher","R73Launcher_2","CMFlareLauncher"]],
                 ["STR_PRESET_Su34_09",["GSh301","AirBombLauncher","CMFlareLauncher"]]],
		//Su25_TK_EP1
                [["STR_PRESET_Su25_TK_EP1_00",["GSh301","Ch29Launcher_Su34","S8Launcher","R73Launcher_2","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_01",["GSh301","Ch29Launcher_Su34","S8Launcher","R73Launcher_2","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_02",["GSh301","Ch29Launcher_Su34","S8Launcher","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_03",["GSh301","S8Launcher","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_04",["GSh301","S8Launcher","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_05",["GSh301","AirBombLauncher","S8Launcher","R73Launcher_2","CMFlareLauncher"]],
                ["STR_PRESET_Su25_TK_EP1_06",["GSh301","AirBombLauncher","S8Launcher","CMFlareLauncher"]]],
		//Mi24_V
		[["STR_PRESET_Mi24V_00",["YakB","AT6Launcher","S8Launcher"]],
		["STR_PRESET_Mi24V_01",["GSh23L","AT9Launcher","Igla_twice","S8Launcher"]],
		["STR_PRESET_Mi24V_02",["GSh23L","Igla_twice","S8Launcher"]],
		["STR_PRESET_Mi24V_03",["GSh23L","AT9Launcher"]]],
                //F35B
                [["STR_PRESET_F35B_00",["GAU12",/*"MaverickLauncher",*/"SidewinderLaucher_AH64","CMFlareLauncher"]],
                ["STR_PRESET_F35B_01",["GAU12","MaverickLauncher","SidewinderLaucher_F35","CMFlareLauncher"]],
                ["STR_PRESET_F35B_02",["GAU12","MaverickLauncher","BombLauncherF35","CMFlareLauncher"]],
                ["STR_PRESET_F35B_03",["GAU12","HellfireLauncher","SidewinderLaucher_F35","CMFlareLauncher"]]],
                //A10
                [["STR_PRESET_A10_00",["GAU8","FFARLauncher_14","MaverickLauncher","SidewinderLaucher_AH1Z","CMFlareLauncher"]],
                ["STR_PRESET_A10_01",["GAU8","FFARLauncher_14","BombLauncherA10","BombLauncherF35","CMFlareLauncher"]],
                ["STR_PRESET_A10_02",["GAU8","FFARLauncher_14","MaverickLauncher","SidewinderLaucher_AH1Z","CMFlareLauncher"]],
                ["STR_PRESET_A10_03",["GAU8","FFARLauncher_14","HellfireLauncher","SidewinderLaucher_AH1Z","CMFlareLauncher"]]],
		//Mi24_P
		[["STR_PRESET_Mi24P_00",["GSh302","Igla_twice","AT6Launcher","S8Launcher"]],
		["STR_PRESET_Mi24P_01",["GSh302","AT9Launcher","S8Launcher"]]],
		//AV8B2
		[["STR_PRESET_AV8B2_00",["GAU12","FFARLauncher_14","MaverickLauncher","SidewinderLaucher","CMFlareLauncher"]],
		["STR_PRESET_AV8B2_01",["GAU12","FFARLauncher_14","HellfireLauncher","SidewinderLaucher_AH1Z","CMFlareLauncher"]],
                ["STR_PRESET_AV8B2_02",["GAU12","FFARLauncher_14","MaverickLauncher","SidewinderLaucher","CMFlareLauncher"]],
                ["STR_PRESET_AV8B2_03",["GAU12","FFARLauncher_14","MaverickLauncher","CMFlareLauncher"]],
                ["STR_PRESET_AV8B2_04",["GAU12","FFARLauncher_14","Mk82BombLauncher","CMFlareLauncher"]]],
		//L39_TK_EP1
		[["STR_PRESET_L39_TK_EP1_00",["GSh23L","57mmLauncher","CMFlareLauncher"]],
		["STR_PRESET_L39_TK_EP1_02",["GSh23L","R73Launcher_2","CMFlareLauncher"]]],
                //D30_RU
                [["STR_PRESET_D30_RU_00",["D30"]],
                ["STR_PRESET_D30_RU_01",["D30"]],
                ["STR_PRESET_D30_RU_02",["D30"]]],
                //M119_US_EP1
                [["STR_PRESET_M119_US_EP1_00",["M119"]],
                ["STR_PRESET_M119_US_EP1_01",["M119"]],
                ["STR_PRESET_M119_US_EP1_02",["M119"]]],
		//M252_US_EP1
		[["STR_PRESET_M252_US_EP1_00",["M252"]],
		["STR_PRESET_M252_US_EP1_01",["M252"]]],
		//2b14_82mm
		[["STR_PRESET_2b14_82mm_00",["2b14"]],
		["STR_PRESET_2b14_82mm_01",["2b14"]]],
		//AH64D
		[["STR_PRESET_AH64D_00",["M230","FFARLauncher","HellfireLauncher"]],
		["STR_PRESET_AH64D_01",["M230","FFARLauncher","SidewinderLaucher_AH64"]],
		["STR_PRESET_AH64D_02",["M230","FFARLauncher","HellfireLauncher","SidewinderLaucher_AH1Z"]]]
	];
	FFA_EASALOADOUTS_M=
	[
		//Su34
		[["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","6Rnd_Ch29","40Rnd_S8T","2Rnd_R73","2Rnd_R73","120Rnd_CMFlareMagazine"],
		["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_Ch29","40Rnd_S8T","2Rnd_R73","2Rnd_R73","2Rnd_R73","120Rnd_CMFlareMagazine"],
		["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","12Rnd_Vikhr_KA50","12Rnd_Vikhr_KA50","4Rnd_Ch29","4Rnd_Ch29","4Rnd_Ch29","4Rnd_Ch29","40Rnd_S8T","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","120Rnd_CMFlareMagazine"],
		["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","40Rnd_S8T","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","2Rnd_R73","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_Ch29","4Rnd_Ch29","4Rnd_Ch29","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_FAB_250","4Rnd_FAB_250","2Rnd_R73","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_FAB_250","4Rnd_FAB_250","2Rnd_FAB_250","120Rnd_CMFlareMagazine"]],
		//Su25_TK_EP1
                [["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_Ch29","80Rnd_S8T","2Rnd_R73","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","6Rnd_Ch29","40Rnd_S8T","2Rnd_R73","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","6Rnd_Ch29","80Rnd_S8T","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","40Rnd_S8T","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","40Rnd_80mm","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                 ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_FAB_250","2Rnd_FAB_250","40Rnd_80mm","2Rnd_R73","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                  ["180Rnd_30mm_GSh301","180Rnd_30mm_GSh301","4Rnd_FAB_250","2Rnd_FAB_250","40Rnd_80mm","40Rnd_80mm","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"]],
		//Mi24_V
		[["1470Rnd_127x108_YakB","1470Rnd_127x108_YakB","4Rnd_AT6_Mi24V","80Rnd_80mm"],
		["520Rnd_23mm_GSh23L","520Rnd_23mm_GSh23L","4Rnd_AT9_Mi24P","2Rnd_Igla","40Rnd_S8T"],
		["520Rnd_23mm_GSh23L","520Rnd_23mm_GSh23L","2Rnd_Igla","2Rnd_Igla","40Rnd_80mm","40Rnd_S8T"],
		["520Rnd_23mm_GSh23L","520Rnd_23mm_GSh23L","4Rnd_AT9_Mi24P","4Rnd_AT9_Mi24P"]],
                //F35B
                [["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12",/*"2Rnd_Maverick_A10",*/"8Rnd_Sidewinder_AH64","8Rnd_Sidewinder_AH64","120Rnd_CMFlareMagazine"],
                ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Sidewinder_F35","2Rnd_Sidewinder_F35","2Rnd_Sidewinder_F35","120Rnd_CMFlareMagazine"],
                ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","2Rnd_Maverick_A10","2Rnd_GBU12","2Rnd_GBU12","2Rnd_GBU12","2Rnd_GBU12","120Rnd_CMFlareMagazine"],
                ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","8Rnd_Hellfire","2Rnd_Sidewinder_F35","2Rnd_Sidewinder_F35","2Rnd_Sidewinder_F35","120Rnd_CMFlareMagazine"]],
                //A10
                [["1350Rnd_30mmAP_A10","1350Rnd_30mmAP_A10","14Rnd_FFAR","2Rnd_Maverick_A10","2Rnd_Sidewinder_AH1Z","2Rnd_Sidewinder_AH1Z","2Rnd_Sidewinder_AH1Z","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["1350Rnd_30mmAP_A10","1350Rnd_30mmAP_A10","14Rnd_FFAR","4Rnd_GBU12","4Rnd_GBU12","2Rnd_GBU12","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["1350Rnd_30mmAP_A10","1350Rnd_30mmAP_A10","14Rnd_FFAR","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Sidewinder_AH1Z","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"],
                ["1350Rnd_30mmAP_A10","1350Rnd_30mmAP_A10","14Rnd_FFAR","14Rnd_FFAR","8Rnd_Hellfire","2Rnd_Sidewinder_AH1Z","120Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine"]],
		//Mi24_P
		[["750Rnd_30mm_GSh301","750Rnd_30mm_GSh301","2Rnd_Igla","2Rnd_Igla","4Rnd_AT6_Mi24V","40Rnd_80mm"],
		["750Rnd_30mm_GSh301","750Rnd_30mm_GSh301","4Rnd_AT9_Mi24P","40Rnd_80mm","40Rnd_80mm"]],
		//AV8B2
		[["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","14Rnd_FFAR","2Rnd_Maverick_A10","4Rnd_Sidewinder_AV8B","4Rnd_Sidewinder_AV8B","120Rnd_CMFlareMagazine"],
            ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","14Rnd_FFAR","8Rnd_Hellfire","2Rnd_Sidewinder_AH1Z","120Rnd_CMFlareMagazine"],
		["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","14Rnd_FFAR","2Rnd_Maverick_A10","2Rnd_Maverick_A10","4Rnd_Sidewinder_AV8B","120Rnd_CMFlareMagazine"],
            ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","14Rnd_FFAR","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","2Rnd_Maverick_A10","120Rnd_CMFlareMagazine"],
            ["300Rnd_25mm_GAU12","300Rnd_25mm_GAU12","14Rnd_FFAR","3Rnd_Mk82","3Rnd_Mk82","3Rnd_Mk82","120Rnd_CMFlareMagazine"]],
		//L39_TK_EP1
		[["520Rnd_23mm_GSh23L","64Rnd_57mm","64Rnd_57mm","64Rnd_57mm","60Rnd_CMFlareMagazine"],
		["520Rnd_23mm_GSh23L","2Rnd_R73","2Rnd_R73","2Rnd_R73","60Rnd_CMFlareMagazine"]],
                //D30_RU
                [["30Rnd_122mmHE_D30"],
                ["30Rnd_122mmWP_D30"],
                ["30Rnd_122mmLASER_D30"]],
                //M119_US_EP1
                [["30Rnd_105mmHE_M119"],
                ["30Rnd_105mmWP_M119"],
                ["30Rnd_105mmLASER_M119"]],
		//M252_US_EP1
		[["8Rnd_81mmHE_M252"],
		["8Rnd_81mmWP_M252"]],
		//2b14_82mm
		[["8Rnd_82mmHE_2B14"],
		["8Rnd_82mmWP_2B14"]],
		//AH64D
		[["1200Rnd_30x113mm_M789_HEDP","38Rnd_FFAR","8Rnd_Hellfire"],
		["1200Rnd_30x113mm_M789_HEDP","38Rnd_FFAR","8Rnd_Sidewinder_AH64"],
		["1200Rnd_30x113mm_M789_HEDP","38Rnd_FFAR","8Rnd_Hellfire","2Rnd_Sidewinder_AH1Z"]]
	];
#endif
FFA_LOADOUT_W=["AK_47_M","RPG18","Makarov","Binocular_Vector","NVGoggles","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch"];//default players loadout - weapons
FFA_LOADOUT_M=["30Rnd_762x39_AK47","30Rnd_762x39_AK47","30Rnd_762x39_AK47","RPG18","HandGrenade_East","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","PipeBomb"];//default players loadout - magazines
if ((random 10)>5) then
{
	FFA_LOADOUT_W set [0,"AK_47_S"];
};
#ifdef __USE_ACE__
	FFA_LOADOUT_B="";
	FFA_LOADOUR_RW=[];
	FFA_LOADOUT_RM=[];
	FFA_LOADOUT_EARPROT=false;
	FFA_LOADOUT_EYEPROT=false;
	FFA_LOADOUT_EARWEAR=false;
	FFA_LOADOUT_EYEWEAR=false;
	FFA_IDENTITY="ACE_Original_Identity";
#endif

FFA_AVALIABLE_W=[];
FFA_AVALIABLE_M=[];

FFA_MAXUNITSINSQUAD=4;//basic AI number in player`s squad
FFA_AMMOAMMOUNT_M=30;//magazines ammount in weapon store per player`s life
FFA_AMMOAMMOUNT_W=10;//weapons ammount in weapon store per player`s life

FFA_AMMOCRATES=[];
FFA_PLAYERSLOT=0;
FFA_REPAIRVEHICLERANGE=40;//range of repair vehicles functionality

FFA_VEHICLE=objNull;
FFA_OLDVEHICLE=objNull;
FFA_WINCHCARGO=objNull;
FFA_WINCH=false;
FFA_PROCESSREPAIR=false;
FFA_PLAYERTASK=objNull;
FFA_HITBYENEMY=false;
FFA_DRAGREQUIRED=false;

FFA_DAMAGEHEAD_HIT=0;
FFA_DAMAGEBODY=0;
FFA_DAMAGELEGS=0;
FFA_DAMAGEHANDS=0;
FFA_DAMAGE=0;

FFA_LIFESTATE_HEALTHY=1;
FFA_LIFESTATE_INJURED=2;
FFA_LIFESTATE_DYING=3;
FFA_LIFESTATE_DEAD=4;

FFA_MARKERS_INFANTRY=0;
FFA_MARKERS_VEHICLES=1;
FFA_MARKERS_BOTH=2;
FFA_MARKERS_GROUP=3;

FFA_MARKERS_DISTANCE=2000;
FFA_MARKERS_TYPE=2;
FFA_CURRENTMARKER_DISTANCE=5;
FFA_CURRENTMARKER_TYPE=2;

FFA_DESIGNATION_TARGET=[];
FFA_DESIGNATION_CALLER=objNull;
FFA_DESIGNATION_TIME=0;
FFA_DESIGNATION_LASTTIME=0;

FFA_VEHPARA=[];

#ifdef __USE_ACE__	
	[] execVM "INIT\INIT_ArraysACE.sqf";
#else
	[] execVM "INIT\INIT_Arrays.sqf";
#endif
[] execVM "SYS\SYS_Client.sqf";
[] execVM "SYS\SYS_Common.sqf";
sleep 9;
waitUntil{(FFA_SERVERSTARTED)};
waitUntil{(local player)};
[] execVM "MSC\ffa_func_intro.sqf";
waitUntil{(FFA_CLIENTSTARTED)};

[] call FFA_FUNC_INITPLAYER;