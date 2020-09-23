class RscShortcutButton 
{
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	w = 0.183825;
	h = 0.104575;
	color[] = {0.95, 0.95, 0.95, 1};
	color2[] = {1, 1, 1, 0.4};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = {1, 1, 1, 0.25};
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone 
	{
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	class ShortcutPos 
	{
		left = 0.004;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos 
	{
		left = 0.025;
		top = 0.05;
		right = 0.005;
		bottom = 0.005;
	};
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.01.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	textureNoShortcut = "";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03521;
	sizeEx = 0.03521;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	
	class Attributes 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
	};
};
class RscIGUIShortcutButton : RscShortcutButton 
{
	w = 0.183825;
	h = 0.0522876;
	style = 2;
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 0.85};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.85};
	colorDisabled[] = {1, 1, 1, 0.4};
	
	class HitZone 
	{
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.016;
	};
	class ShortcutPos 
	{
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos 
	{
		left = 0.016;
		top = 0.0002;
		right = 0.01;
		bottom = 0.016;
	};
	animTextureNormal = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\igui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\igui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\igui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\igui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureNoShortcut = "\ca\ui\data\igui_button_normal_ca.paa";
	
	class Attributes 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};	
};

class RscEvoActiveText: RscActivetext
{
	style = ST_LEFT;
	blinkingPeriod=-1;
	default=false;
	color[]=CA_UI_element_background;
	colorActive[]=Color_WhiteDark;
	sizeEx = 0.03;
};

class DLG_VideoSettings
{
	idd = 100;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.7;
			y = 0.3;
			w = 0.4;
			h = 0.30;
			text = "\ca\ui\data\ui_background_esrb_ca.paa";
		};
		class ClassTitle : RscText
		{
		   	idc = 0;
			x = 0.7250;
			y = 0.2855;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_VIEW_Title;
		};
		class ViewTitle : RscText
		{
		   	idc = 0;
			x = 0.725;
			y = 0.33;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = $STR_GUI_VIEW_Distance;
		};
		class ViewMin : RscText
		{
		   	idc = 0;
			x = 0.705;
			y = 0.347;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = 1000;
		};
		class ViewMax : RscText
		{
		   	idc = 0;
			x = 1.000;
			y = 0.347;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = 5000;
		};
		class GridTitle : RscText
		{
		   	idc = 0;
			x = 0.725;
			y = 0.39;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = $STR_GUI_VIEW_Grid;
		};
		class GridMin : RscText
		{
		   	idc = 0;
			x = 0.71;
			y = 0.407;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = "50.0";
		};
		class GridMax : RscText
		{
		   	idc = 0;
			x = 1.000;
			y = 0.407;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.025;
			text = "00.0";
		};
	};	
	class controls
	{	      
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.845;
			y = 0.485;
			text = $STR_GUI_VIEW_Close;
			onButtonClick = "CloseDialog 0";
	     	};
		class ViewDistance: RscSlider
		{
			idc=200;
			type=CT_SLIDER;
			style=1024;
			x = 0.75; 
			y = 0.39; 
    			w = 0.25; 
    			h = 0.020;
			color[]=CA_UI_element_background;
			//colorActive[] = Color_White;
			onSliderPosChanged = "setViewDistance (sliderPosition 200)";
		};
		class GridDistance: RscSlider
		{
			idc=201;
			type=CT_SLIDER;
			style=1024;
			x = 0.75; 
			y = 0.45; 
    			w = 0.25; 
    			h = 0.020;
			color[]=CA_UI_element_background;
			//colorActive[] = Color_White;
			onSliderPosChanged = "FFA_TERAINGRID=(50-(sliderPosition 201)); setTerrainGrid FFA_TERAINGRID";
		};
		class VideoMore: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.73;
			y = 0.485;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_VIEW_Markers;
			action="MenuAction=[] execVM ""DLG\DLG_Markers.sqf"" ";
	     	};
	};
};

class DLG_Resources
{
	idd = 101;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.7;
			y = 0.3;
			w = 0.4;
			h = 0.30;
			text = "\ca\ui\data\ui_background_esrb_ca.paa";
		};
		class ClassTitle : RscText
		{
		   	idc = 0;
			x = 0.7250;
			y = 0.2855;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_RES_Title;
		};
		class TransferTitle : RscText
		{
		   	idc = 0;
			x = 0.73;
			y = 0.347;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_RES_Unit;
		};
		class AmmountTitle : RscText
		{
		   	idc = 0;
			x = 0.73;
			y = 0.397;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_RES_Ammount;
		};		
	};	
	class controls
	{	      
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.845;
			y = 0.485;
			text = $STR_GUI_VIEW_Close;
			onButtonClick = "CloseDialog 0";
	     	};
		class TransferUnit: RscCombo
		{
			idc=208;
			style=1024;
			x = 0.87; 
			y = 0.385; 
    			w = 0.15; 
    			h = 0.025;
		};
		class TransferAmmount: RscCombo
		{
			idc=209;
			style=1024;
			x = 0.87; 
			y = 0.435; 
    			w = 0.15; 
    			h = 0.025;
		};
		class TransferApply: RscEvoActiveText
	      	{
			idc = 210;
			x = 0.73;
			y = 0.485;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_RES_Transfer;
			action="[] call FFA_FUNC_TRANSFER";
	     	};
	};
};

class DLG_Markers
{
	idd = 103;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.7;
			y = 0.3;
			w = 0.4;
			h = 0.30;
			text = "\ca\ui\data\ui_background_esrb_ca.paa";
		};
		class ClassTitle : RscText
		{
		   	idc = 0;
			x = 0.7250;
			y = 0.2855;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_MARK_Title;
		};
		class DistanceTitle : RscText
		{
		   	idc = 0;
			x = 0.73;
			y = 0.347;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_MARk_Distance;
		};
		class TypeTitle : RscText
		{
		   	idc = 0;
			x = 0.73;
			y = 0.397;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_MARK_Type;
		};		
	};	
	class controls
	{	      
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.845;
			y = 0.485;
			text = $STR_GUI_VIEW_Close;
			onButtonClick = "CloseDialog 0";
	     	};
		class DistanceCombo: RscCombo
		{
			idc=211;
			style=1024;
			x = 0.87; 
			y = 0.385; 
    			w = 0.15; 
    			h = 0.025;
		};
		class TypeCombo: RscCombo
		{
			idc=212;
			style=1024;
			x = 0.87; 
			y = 0.435; 
    			w = 0.15; 
    			h = 0.025;
		};
		class Apply: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.73;
			y = 0.485;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_LIST_Apply;
			action="[] call FFA_FUNC_MARKERSAPPLY";
	     	};
	};
};


class DLG_List
{
	idd = 102;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{		
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.8;
			y = 0.2;
			w = 0.5;
			h = 0.8;
			text = "\ca\ui\data\ui_background_paused_ca.paa";
		};
		class ListTitle : RscText
		{
		   	idc = 203;
			x = 0.825;
			y = 0.20;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = "";
		};				
	};
	class controls
	{	      
//		class Score: RscText
//		{
//		   	idc = 205;
//			x = 0.825;
//			y = 0.645;
//			w = 0.2;
//			h = 0.1;
//			colorText[] = CA_UI_element_background;
//			sizeEx = 0.03;
//			text = "";
//		};	
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.835;
			y = 0.800;
			text = $STR_GUI_LIST_Cancel;
			onButtonClick = "CloseDialog 0";
	     	};
		class Apply: RscIGUIShortcutButton
	      	{
			idc = 207;
			x = 0.835;
			y = 0.720;
			text = $STR_GUI_LIST_Apply;
			onButtonClick = "[] call FFA_FUNC_LISTAPPLY";
	     	};
		class ListView: RscListBox
		{
			idc = 202;
			x = 0.825;
			y = 0.30;
			w = 0.21;
			h = 0.35;
			font = "Zeppelin32";
			sizeEx = 0.025;
			rowHeight = 0.015;
			SoundSelect[] = {"", 0.1, 1};
		};
	};
};

class DLG_Menu
{
	idd = 104;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{		
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.8;
			y = 0.2;
			w = 0.5;
			h = 0.8;
			text = "\ca\ui\data\ui_background_paused_ca.paa";
		};
		class ListTitle : RscText
		{
		   	idc = 204;
			x = 0.825;
			y = 0.20;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = "";
		};			
	};
	class controls
	{	      	

		class Score: RscText
		{
		   	idc = 206;
			x = 0.825;
			y = 0.670;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = "";
		};
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.835;
			y = 0.800;
			text = $STR_GUI_LIST_Cancel;
			onButtonClick = "CloseDialog 0";
	     	};
		class MENU_Weapons: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.300;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Weapons;
			action="MenuAction=[] execVM ""DLG\DLG_Weapons.sqf"" ";
	     	};
		class MENU_Units: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.350;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Units;
			action="MenuAction=[] execVM ""DLG\DLG_Units.sqf"" ";
	     	};
		class MENU_Vehicles: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.400;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Vehicles;
			action="MenuAction=[] execVM ""DLG\DLG_Vehicles.sqf"" ";
	     	};
		class MENU_Resources: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.450;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Resources;
			action="MenuAction=[] execVM ""DLG\DLG_Transfer.sqf"" ";
	     	};
		class MENU_Players: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.500;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Players;
			action="MenuAction=[] execVM ""DLG\DLG_Players.sqf"" ";
	     	};
		class MENU_Squad: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.550;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Squad;
			action="MenuAction=[] execVM ""DLG\DLG_Squad.sqf"" ";
	     	};
		class MENU_Video: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.84;
			y = 0.600;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_MENU_Video;
			action="MenuAction=[] execVM ""DLG\DLG_Video.sqf"" ";
	     	};			
	};
};

class DLG_Easa
{
	idd = 105;
	movingEnable=true;
	enableSimulation=true;

	class controlsBackground
	{
		class Mainback : RscPicture 
		{
			idc = 0;
			x = 0.7;
			y = 0.3;
			w = 0.4;
			h = 0.30;
			text = "\ca\ui\data\ui_background_esrb_ca.paa";
		};
		class ClassTitle : RscText
		{
		   	idc = 0;
			x = 0.7250;
			y = 0.2855;
			w = 0.2;
			h = 0.1;
			colorText[] = CA_UI_element_background;
			sizeEx = 0.03;
			text = $STR_GUI_EASA_Title;
		};		
	};	
	class controls
	{	      
		class Close: RscIGUIShortcutButton
	      	{
			idc = 0;
			x = 0.845;
			y = 0.485;
			text = $STR_GUI_VIEW_Close;
			onButtonClick = "CloseDialog 0";
	     	};		
		class EasaCombo: RscCombo
		{
			idc=221;
			style=1024;
			x = 0.74; 
			y = 0.410; 
    			w = 0.28; 
    			h = 0.025;
		};
		class Apply: RscEvoActiveText
	      	{
			idc = 0;
			x = 0.73;
			y = 0.485;
			w = 0.2;
			h = 0.03;
			text = $STR_GUI_LIST_Apply;
			action="[] call FFA_FUNC_EASAAPPLY";
	     	};
	};
};