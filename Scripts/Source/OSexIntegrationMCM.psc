Scriptname OSexIntegrationMCM extends nl_mcm_module
{OStim MCM Menu}

; code
int SetUpdate

OsexIntegrationMain Main

string currPage
int[] SlotSets
bool color1

actor playerref

int SetUndressingAbout

;ORomance 
int SetORDifficulty
int SetORSexuality
int SetORKey
int SetORColorblind
int SetORStationary
int SetORLeft
int SetORRight
int SetORNakadashi

string ORomance = "ORomance.esp"
int GVORDifficulty = 0x0063A4
int GVORSexuality = 0x0063A5
int GVORKey = 0x006E6A
int GVORLeft = 0x73D2
int GVORRight = 0x73D3
int GVORColorblind = 0x73D0
int GVORStationaryMode = 0x73D1
int GVORNakadashi = 0x73D4

string ONights = "ONights.esp"
int GVONFreqMult = 0x000D65
int GVONStopWhenFound = 0x000D64

string OBody = "OBody.esp"
int GVOBorefit = 0x001802
int GVOBNippleRand = 0x001803
int GVOBGenitalRand = 0x001804
int GVOBPrestKey = 0x001805

int SetOBRefit
int SetOBNippleRand
int SetOBGenitalRand
int SetOBPresetKey

int SetONStopWhenFound
int SetONFreqMult

int function getVersion()
    return 100
endFunction

Event OnInit()
    RegisterModule("Configuration")
endEvent

Event OnPageInit()
    SetModName("OStim")
    SetLandingPage("")
    SetSplashScreen("Ostim/logo.dds", 184, 31)

    Parent.OnGameReload()
	Main = (Self as Quest) as OsexIntegrationMain

	DomLightModeList = new String[3]
	DomLightModeList[0] = "No light"
	DomLightModeList[1] = "Rear light"
	DomLightModeList[2] = "Face light"

	SubLightModeList = new String[3]
	SubLightModeList[0] = "No light"
	SubLightModeList[1] = "Rear light"
	SubLightModeList[2] = "Face light"

	SubLightBrightList = new String[2]
	SubLightBrightList[0] = "Dim"
	SubLightBrightList[1] = "Bright"

	DomLightBrightList = new String[2]
	DomLightBrightList[0] = "Dim"
	DomLightBrightList[1] = "Bright"

	playerref = game.getplayer()
EndEvent

event OnVersionUpdate(int a_version)
    ;Nothing for now.
endEvent

Event OnPageDraw()
    If (!Main)
        Init()
        If (!Main.EndOnDomOrgasm)
            Main.Startup()
        EndIf
        Debug.MessageBox("Anomaly detected in install, please reinstall OStim if it does not start properly")
    EndIf
    Main.PlayDing()
    Main.playTickBig()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetThanks = AddTextOption("Thanks!", "")
    SetCursorPosition(1)
    AddTextOption("<font color='" + "#939292" +"'>" + "OStim Settings", "")
    SetCursorPosition(2)
    AddColoredHeader("Sex scenes")
    
EndEvent



Function AddColoredHeader(String In)
	String Blue = "#6699ff"
	String Pink = "#ff3389"
	String Color
	If Color1
		Color = Pink
		Color1 = False
	Else
		Color = Blue
		Color1 = True
	EndIf
	AddHeaderOption(FONT_CUSTOM(In, Color))
EndFunction