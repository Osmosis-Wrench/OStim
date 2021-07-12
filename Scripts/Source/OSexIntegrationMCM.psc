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
    AddToggleOptionST("setActorSpeedControl", "Actors control speed", Main.EnableActorSpeedControl)
    AddSliderOptionST("setSexExcitementMult", "Excitement multiplier", Main.SexExcitementMult, "{2} x")
    AddToggleOptionST("setClipinglessFirstPerson", "Clipping-less first person", Main.EnableImprovedCamSupport)
    AddSliderOptionST("setCustomTimescale", "Custom timescale", Main.CustomTimescale, "{0}")
    AddToggleOptionST("setMisallignmentOption", "Enable misalignment protection", Main.MisallignmentProtection)
    AddToggleOptionST("setFlipFix", "Enable flipped animation fix", Main.FixFlippedAnimations)
    AddToggleOptionST("setUseFades", "Fade out on intro/outro", Main.UseFades)
    AddToggleOptionST("setEndAfterActorHit", "End if attacked", Main.EndAfterActorHit)
    AddToggleOptionST("setUseRumble", "Use controller rumble", Main.UseRumble)
    AddToggleOptionST("setUseScreenShake", "Use extra screenshake", Main.UseScreenShake)
    AddToggleOptionST("setForceFirstPerson", "Force return to first person after scene", Main.ForceFirstPersonAfter)
    AddToggleOptionST("setScaling", "Disable scaling", Main.DisableScaling)
    AddToggleOptionST("setResetPosition", "Reset position after scene", Main.ResetPosAfterSceneEnd) 
    AddEmptyOption()

    AddColoredHeader("Player Roles")
    AddToggleOptionST("setOnlyGayAnimsInGayScenes", "Only use same sex animations for same sex scenes", Main.OnlyGayAnimsInGayScenes)
    AddToggleOptionST("setPlayerAlwaysDomStraight", "Player Always Dom: Straight", Main.PlayerAlwaysDomStraight)
    AddToggleOptionST("setPlayerAlwaysSubStraight", "Player Always Sub: Straight", Main.PlayerAlwaysSubStraight)
    AddToggleOptionST("setPlayerAlwaysDomGay", "Player Always Dom: Gay", Main.PlayerAlwaysDomGay)
    AddToggleOptionST("setPlayerAlwaysSubGay", "Player Always Sub: Gay", Main.PlayerAlwaysSubGay)
    AddEmptyOption()

    AddColoredHeader("Orgasms")
    AddToggleOptionST("setEndOnOrgasm", "End sex after Dom actor orgasm", Main.EndOnDomOrgasm)
    AddToggleOptionST("setEndOnSubOrgasm", "End sex after Sub actor orgasm", Main.EndOnSubOrgasm)
    AddToggleOptionST("setEndOnBothOrgasm", "Require both actors to orgasm to end", Main.RequireBothOrgasmsToFinish)
    AddToggleOptionST("setSlowMoOrgasms", "Slow motion on orgasm", Main.SlowMoOnOrgasm)
    AddToggleOptionST("setOrgasmBoostsRel", "Orgasm boosts relationship rank", Main.OrgasmIncreasesRelationship)
    AddEmptyOption()

    AddColoredHeader("Beds")
    AddToggleOptionST("setEnableBeds", "Use beds", Main.UseBed)
    AddSliderOptionST("setBedSearchDistance", "Bed search radius", Main.BedSearchDistance, "{0} meters")
    AddSliderOptionST("setBedReallignment", "Bed realignment", Main.BedReallignment, "{0} units")
    AddToggleOptionST("setBedAlgo", "Use alternate bed search method", Main.UseAlternateBedSearch)
    AddEmptyOption()

    AddColoredHeader("Excitement bars")
    AddToggleOptionST("setDomBar", "Main actor HUD bar", Main.EnableDomBar)
    AddToggleOptionST("setSubBar", "Second actor HUD bar", Main.EnableSubBar)
    AddToggleOptionST("setThirdBar", "Third actor HUD bar", Main.EnableThirdBar)
    AddToggleOptionST("setAutoHideBar", "Autohide bars", Main.AutoHideBars)
    AddToggleOptionST("setMatchColorToGender", "Match color to gender", Main.MatchBarColorToGender)
    AddToggleOptionST("setHideNPCOnNPCBars", "Hide bars in NPC-only scenes", Main.HideBarsInNPCScenes)
    AddEmptyOption()

    AddColoredHeader("Undressing")
    AddToggleOptionST("setAlwaysUndressAtStart", "Fully undress at start", Main.AlwaysUndressAtAnimStart)
    AddToggleOptionST("setUndressIfneed", "Remove clothes mid-scene", Main.AutoUndressIfNeeded)
    AddToggleOptionST("setDropClothes", "Toss clothes onto ground", Main.TossClothesOntoGround)
    AddToggleOptionST("setAnimateRedress", "Use animated redress", Main.FullyAnimateRedress)
    AddEmptyOption()

    AddColoredHeader("AI Control")
    AddToggleOptionST("setAIControl", "Enable full-auto control", Main.UseAIControl)
    AddToggleOptionST("setForceAIIfAttacking", "Force full-auto control if player attacking", Main.UseAIPlayerAggressor)
    AddToggleOptionST("setForceAIIfAttacked", "Force full-auto control if player is attacked", Main.UseAIPlayerAggressed)
    AddToggleOptionST("setForceAIInConsensualScenes", "Force full-auto control in consensual scenes", Main.UseAINonAggressive)
    AddToggleOptionST("setUseAutoFades", "Fade out in between animation transitions", Main.UseAutoFades)
    AddSliderOptionST("setAIChangeChance", "AI Animation Change Chance", Main.AiSwitchChance, "{0}")
    AddEmptyOption()

    AddColoredHeader("FreeCam")
    AddToggleOptionST("setUseFreeCam", "Switch to freecam mode on start", Main.UseFreeCam)
    AddSliderOptionST("setFreeCamFOV", "Freecam FOV", Main.FreecamFOV, "{0}")
    AddSliderOptionST("setDefaultFOV", "Default FOV", Main.DefaultFOV, "{0}")
    AddSliderOptionST("setCameraSpeed", "Camera speed", Main.FreecamSpeed, "{0}")
    AddEmptyOption()

    AddColoredHeader("Keys")
    AddKeyMapOptionST("setKeymap", "Start sex with target", Main.KeyMap)
    AddKeyMapOptionST("setKeyUp", "Increase speed", Main.SpeedUpKey)
    AddKeyMapOptionST("setKeyDown", "Decrease speed", Main.SpeedDownKey)
    AddKeyMapOptionST("setPullOut", "Pull out", Main.PullOutKey)
    AddKeyMapOptionST("setControlToggle", "Switch control mode", Main.ControlToggleKey)
    AddEmptyOption()

    AddColoredHeader("Lights")
    AddMenuOptionST("setDomLightMode", "Main actor light mode", DomLightModeList[Main.DomLightPos])
    AddMenuOptionST("setSubLightMode", "Second actor light mode", SubLightModeList[Main.SubLightPos])
    AddMenuOptionST("setDomLightBrightness", "Main actor light brightness", DomLightBrightList[Main.DomLightBrightness])
    AddMenuOptionST("setSubLightBrightness", "Second actor light brightness", SubLightBrightList[Main.SubLightBrightness])
    AddToggleOptionST("setOnlyLightInDark", "Only use lights in darkness", Main.LowLightLevelLightsOnly)
    AddEmptyOption()

    AddColoredHeader("System")
    AddTextOptionST("setResetState", "Reset thread state", "")
    AddTextOptionST("setRebuildDatabase", "Rebuild animation database", "")
    AddTextOptionST("setUpdate", "Update OStim", "")
    AddToggleOptionST("setMute", "Mute vanilla OSA sounds", Main.MuteOSA)
    AddEmptyOption()

    AddColoredHeader("Save and load settings.")
    AddTextOptionST("exportSettings", "Export Settings", "Done")
    AddTextOptionST("importSettings", "Import Settings", "Done")
    AddEmptyOption()
EndEvent


state setActorSpeedControl
    Event OnSelectST(String state_id)
        Main.EnableActorSpeedControl = !Main.EnableActorSpeedControl
        SetToggleOptionValueST(Main.EnableActorSpeedControl, False, "setActorSpeedControl")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Let actors increase the scene speed on their own when their Excitement gets high enough \nThis feature is experimental, disable if Osex behaves strangely on it's own")
    endEvent
endstate

state setSexExcitementMult
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.SexExcitementMult)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.1, 3.0)
        SetSliderDialogInterval(0.1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.SexExcitementMult = Value
        SetSliderOptionValue(SetsexExcitementMult, Value, "{2} x")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Multiply all the pleasure/second received by actors by this amount\nThis effectively lets you choose how long you want sex to last\n3.0 = 3 times shorter, 0.1 = 10 times longer")
    endEvent
endstate

state setClipinglessFirstPerson
    Event OnSelectST(String state_id)
        Main.EnableImprovedCamSupport = !Main.EnableImprovedCamSupport
        SetToggleOptionValueST(Main.EnableImprovedCamSupport, False, "setClipinglessFirstPerson")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("REQUIRES: Improved Camera, my custom ini settings file\nExperience first person without any clipping")
    endEvent
endstate

state setCustomTimescale
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.CustomTimescale)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0, 40)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.CustomTimescale = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Changes the timescale during sex scenes, and reverts it back to what it was after the scene ends\nUseful if you don't want sex taking an entire day\n0 = this feature is disabled")
    endEvent
endstate

state setMisallignmentOption
    Event OnSelectST(String state_id)
        Main.MisallignmentProtection = !Main.MisallignmentProtection
        SetToggleOptionValueST(Main.MisallignmentProtection, False, "setMisallignmentOption")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable automatic misalignment detection\nYou may want to disable this if you want to do some custom realigning.\nWarning: can cause characters to glitch on some setups, beware enabling this")
    endEvent
endstate

state setFlipFix
    Event OnSelectST(String state_id)
        Main.FixFlippedAnimations = !Main.FixFlippedAnimations
        SetToggleOptionValueST(Main.FixFlippedAnimations, False, "setFlipFix")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Fix some third party animations being flipped 180 degrees")
    endEvent
endstate

state setUseFades
    Event OnSelectST(String state_id)
        Main.UseFades = !Main.UseFades
        SetToggleOptionValueST(Main.UseFades, False, "setUseFades")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Fade the screen to black when a scene starts/ends")
    endEvent
endstate

state setEndAfterActorHit
    Event OnSelectST(String state_id)
        Main.EndAfterActorHit = !Main.EndAfterActorHit
        SetToggleOptionValueST(Main.EndAfterActorHit, False, "setEndAfterActorHit")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("End the scene after someone in the scene is hit\n Can misfire with certain other mods")
    endEvent
endstate

state setUseRumble
    Event OnSelectST(String state_id)
        Main.UseRumble = !Main.UseRumble
        SetToggleOptionValueST(Main.UseRumble, False, "setUseRumble")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Rumble a controller on thrust, if a controller is being used")
    endEvent
endstate

state setUseScreenShake
    Event OnSelectST(String state_id)
        Main.UseScreenShake = !Main.UseScreenShake
        SetToggleOptionValueST(Main.UseScreenShake, False, "setUseScreenShake")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Use extra screenshake on thrust\n This is not compatible with Improved Camera's first person")
    endEvent
endstate

state setForceFirstPerson
    Event OnSelectST(String state_id)
        Main.ForceFirstPersonAfter = !Main.ForceFirstPersonAfter
        SetToggleOptionValueST(Main.ForceFirstPersonAfter, False, "setForceFirstPerson")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Return to first person after scene ends.\nFixes the hybrid-camera bug in Improved Camera")
    endEvent
endstate

state setScaling
    Event OnSelectST(String state_id)
        Main.DisableScaling = !Main.DisableScaling
        SetToggleOptionValueST(Main.DisableScaling, False, "setScaling")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Disable changing actor height to fit animations better when scene starts\nDisabling scaling will absolutely wreck animation alignment, turning it off is not recommended\nHowever, turning it off may help fix issues with HDT-SMP")
    endEvent
endstate

state setResetPosition
    Event OnSelectST(String state_id)
        Main.ResetPosAfterSceneEnd = !Main.ResetPosAfterSceneEnd
        SetToggleOptionValueST(Main.ResetPosAfterSceneEnd, False, "setResetPosition")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Reset actors to where the where when the scene started, when the scene ends")
    endEvent
endstate

state setOnlyGayAnimsInGayScenes
    Event OnSelectST(String state_id)
        Main.OnlyGayAnimsInGayScenes = !Main.OnlyGayAnimsInGayScenes
        SetToggleOptionValueST(Main.OnlyGayAnimsInGayScenes, False, "setOnlyGayAnimsInGayScenes")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("In a same sex scene (Gay & Lesbian) only same sex animations will be used. There is no fallback in this option, so be aware that you will probably have limited animation options.")
    endEvent
endstate

state setPlayerAlwaysDomStraight
    Event OnSelectST(String state_id)
        Main.PlayerAlwaysDomStraight = !Main.PlayerAlwaysDomStraight
        SetToggleOptionValueST(Main.PlayerAlwaysDomStraight, False, "setPlayerAlwaysDomStraight")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Forces the player to always take the Dom role during Straight scenes. \nIf neither are enabled default actor placement will take place, if both are enabled player will default to Dom. \nNote that individual mods can temporarily override this setting.")
    endEvent
endstate

state setPlayerAlwaysSubStraight
    Event OnSelectST(String state_id)
        Main.PlayerAlwaysSubStraight = !Main.PlayerAlwaysSubStraight
        SetToggleOptionValueST(Main.PlayerAlwaysSubStraight, False, "setPlayerAlwaysSubStraight")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Forces the player to always take the Sub role during Straight scenes. \nIf neither are enabled default actor placement will take place, if both are enabled player will default to Dom. \nNote that individual mods can temporarily override this setting.")
    endEvent
endstate

state setPlayerAlwaysDomGay
    Event OnSelectST(String state_id)
        Main.PlayerAlwaysDomGay = !Main.PlayerAlwaysDomGay
        SetToggleOptionValueST(Main.PlayerAlwaysDomGay, False, "setPlayerAlwaysDomGay")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Forces the player to always take the Dom role during Gay scenes. \nIf neither are enabled default actor placement will take place, if both are enabled player will default to Dom. \nNote that individual mods can temporarily override this setting.")
    endEvent
endstate

state setPlayerAlwaysSubGay
    Event OnSelectST(String state_id)
        Main.PlayerAlwaysSubGay = !Main.PlayerAlwaysSubGay
        SetToggleOptionValueST(Main.PlayerAlwaysSubGay, False, "setPlayerAlwaysSubGay")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Forces the player to always take the Sub role during Gay scenes. \nIf neither are enabled default actor placement will take place, if both are enabled player will default to Dom. \nNote that individual mods can temporarily override this setting.")
    endEvent
endstate

state setEndOnOrgasm
    Event OnSelectST(String state_id)
        Main.EndOnDomOrgasm = !Main.EndOnDomOrgasm
        SetToggleOptionValueST(SetEndOnOrgasm, Main.EndOnDomOrgasm, False, "setEndOnOrgasm")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("End the Osex scene automatically when the dominant actor (usually the male) orgasms")
    endEvent
endstate

state setEndOnSubOrgasm
    Event OnSelectST(String state_id)
        Main.EndOnSubOrgasm = !Main.EndOnSubOrgasm
        SetToggleOptionValueST(SetEndOnSubOrgasm, Main.EndOnSubOrgasm, False, "setEndOnSubOrgasm")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("End the Osex scene automatically when the submissive actor (usually the female) orgasms")
    endEvent
endstate

state setEndOnBothOrgasm
    Event OnSelectST(String state_id)
        Main.RequireBothOrgasmsToFinish = !Main.RequireBothOrgasmsToFinish
        SetToggleOptionValueST(SetEndOnBothOrgasm, Main.RequireBothOrgasmsToFinish, False, "setEndOnBothOrgasm")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Will prevent the above 2 settings from ending the scene if both actors have not had an orgasm at least once")
    endEvent
endstate

state setSlowMoOrgasms
    Event OnSelectST(String state_id)
        Main.SlowMoOnOrgasm = !Main.SlowMoOnOrgasm
        SetToggleOptionValueST(Main.SlowMoOnOrgasm, False, "setSlowMoOrgasms")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Add in a few seconds of slow-motion right when the player orgasms")
    endEvent
endstate

state setOrgasmBoostsRel
    Event OnSelectST(String state_id)
        Main.OrgasmIncreasesRelationship = !Main.OrgasmIncreasesRelationship
        SetToggleOptionValueST(Main.OrgasmIncreasesRelationship, False, "setOrgasmBoostsRel")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Giving orgasms to actors you have a relationship rank of 0 with will increase them to rank 1, marking them as a friend\nThis may open up unique options in some mods")
    endEvent
endstate

state setEnableBeds
    Event OnSelectST(String state_id)
        Main.UseBed = !Main.UseBed
        SetToggleOptionValueST(Main.UseBed, False, "setEnableBeds")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Actors will find the nearest bed to have sex on")
    endEvent
endstate

state setBedSearchDistance
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.BedSearchDistance)
        SetSliderDialogDefaultValue(15.0)
        SetSliderDialogRange(1, 30)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.BedSearchDistance = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0} meters")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("High values may increase animation start time")
    endEvent
endstate

state setBedReallignment
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.BedReallignment)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(-250, 250)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.BedReallignment = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0} units")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Move actors forward/back by this amount on a bed")
    endEvent
endstate

state setBedAlgo
    Event OnSelectST(String state_id)
        Main.UseAlternateBedSearch = !Main.UseAlternateBedSearch
        SetToggleOptionValueST(Main.UseAlternateBedSearch, False, "setBedAlgo")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Use a slower papyrus bed search method rather than a faster native one\n May find more beds but only enable if a bed is not detected")
    endEvent
endstate

state setDomBar
    Event OnSelectST(String state_id)
        Main.EnableDomBar = !Main.EnableDomBar
        SetToggleOptionValueST(Main.EnableDomBar, False, "setDomBar")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable the on-screen bar that tracks the dominant actor's Excitement\nActor's orgasm when their Excitement maxes out")
    endEvent
endstate

state setSubBar
    Event OnSelectST(String state_id)
        Main.EnableSubBar = !Main.EnableSubBar
        SetToggleOptionValueST(Main.EnableSubBar, False, "setSubBar")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable the on-screen bar that tracks the second actor's Excitement\nActor's orgasm when their Excitement maxes out")
    endEvent
endstate

state setThirdBar
    Event OnSelectST(String state_id)
        Main.EnableThirdBar = !Main.EnableThirdBar
        SetToggleOptionValueST(Main.EnableThirdBar, False, "setThirdBar")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable the on-screen bar that tracks the third actor's Excitement\nActor's orgasm when their Excitement maxes out")
    endEvent
endstate

state setAutoHideBar
    Event OnSelectST(String state_id)
        Main.AutoHideBars = !Main.AutoHideBars
        SetToggleOptionValueST(Main.AutoHideBars, False, "setAutoHideBar")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Automatically hide the bars during sex when not interacting with the UI")
    endEvent
endstate

state setMatchColorToGender
    Event OnSelectST(String state_id)
        Main.MatchBarColorToGender = !Main.MatchBarColorToGender
        SetToggleOptionValueST(Main.MatchBarColorToGender, False, "setMatchColorToGender")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Change the color of the bars to match the gender of the character")
    endEvent
endstate

state setHideNPCOnNPCBars
    Event OnSelectST(String state_id)
        Main.HideBarsInNPCScenes = !Main.HideBarsInNPCScenes
        SetToggleOptionValueST(Main.HideBarsInNPCScenes, False, "setHideNPCOnNPCBars")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Do not show excitement bars if the player is not in a scene")
    endEvent
endstate

state setResetState
    Event OnSelectST(String state_id)
        Main.ResetState()
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Click this if you keep getting a Scene Already Running type error")
    endEvent
endstate

state setRebuildDatabase
    Event OnSelectST(String state_id)
        Debug.MessageBox("Close all menus and watch the console until it is done")
        Main.GetODatabase().InitDatabase()
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("This will rebuild OStim's internal animation database.\n You only need to click this if you have installed or uninstalled an animation pack MID-playthrough\n The animation database is automatically built at the start of a new playthrough")
    endEvent
endstate

state setUpdate
    Event OnSelectST(String state_id)
        Debug.MessageBox("Close all menus now")
        OStimUpdaterScript oupdater = Game.GetFormFromFile(0x000D67, "Ostim.esp") as OStimUpdaterScript
        oupdater.DoUpdate()
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Try to flush out old scripts.\nMay not be reliable, perform a clean install if you get weird behavior after updating")
    endEvent
endstate

state setMute
    Event OnSelectST(String state_id)
        Main.MuteOSA = !Main.MuteOSA
        SetToggleOptionValueST(Main.MuteOSA, False, "setMute")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Mute sounds coming from the OSA engine\nYou should probably only disable this if you have a soundpack installed")
    endEvent
endstate

state setAlwaysUndressAtStart
    Event OnSelectST(String state_id)
        Main.AlwaysUndressAtAnimStart = !Main.AlwaysUndressAtAnimStart
        SetToggleOptionValueST(Main.AlwaysUndressAtAnimStart, False, "setAlwaysUndressAtStart")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Actors will always get undressed as a scene starts \nMods using this mod's API can force an undress to occur even if this isn't checked")
    endEvent
endstate

state setUndressIfneed
    Event OnSelectST(String state_id)
        Main.AutoUndressIfNeeded = !Main.AutoUndressIfNeeded
        SetToggleOptionValueST(Main.AutoUndressIfNeeded, False, "setUndressIfneed")
    endEvent

    Event OnHighlightST(String state_id)
        False    endEvent
endstate

state setDropClothes
    Event OnSelectST(String state_id)
        Main.TossClothesOntoGround = !Main.TossClothesOntoGround
        SetToggleOptionValueST(Main.TossClothesOntoGround, False, "setDropClothes")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Characters will drop clothes they take off onto the ground instead of storing them in their inventory\nCharacters will automatically pick them up when redressing")
    endEvent
endstate

state setAnimateRedress
    Event OnSelectST(String state_id)
        Main.FullyAnimateRedress = !Main.FullyAnimateRedress
        SetToggleOptionValueST(Main.FullyAnimateRedress, False, "setAnimateRedress")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Makes NPCs play redressing animations after a scene ends if they need to redress")
    endEvent
endstate

state setAIControl
    Event OnSelectST(String state_id)
        Main.UseAIControl = !Main.UseAIControl
        SetToggleOptionValueST(Main.UseAIControl, False, "setAIControl")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("If enabled, scenes will play out on their own without user input via procedural generation\nNote: If you have only used Manual mode briefly or not at all, and never became adept with using it, I STRONGLY recommend you give manual mode a fair chance before using this")
    endEvent
endstate

state setForceAIIfAttacking
    Event OnSelectST(String state_id)
        Main.UseAIPlayerAggressor = !Main.UseAIPlayerAggressor
        SetToggleOptionValueST(Main.UseAIPlayerAggressor, False, "setForceAIIfAttacking")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("If using manual mode by default, this will force automatic mode to activate if the player is the attacker in an aggressive scene")
    endEvent
endstate

state setForceAIIfAttacked
    Event OnSelectST(String state_id)
        Main.UseAIPlayerAggressed = !Main.UseAIPlayerAggressed
        SetToggleOptionValueST(Main.UseAIPlayerAggressed, False, "setForceAIIfAttacked")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("If using manual mode by default, this will force automatic mode to activate if the player is the victim in an aggressive scene")
    endEvent
endstate

state setForceAIInConsensualScenes
    Event OnSelectST(String state_id)
        Main.UseAINonAggressive = !Main.UseAINonAggressive
        SetToggleOptionValueST(Main.UseAINonAggressive, False, "setForceAIInConsensualScenes")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("If using manual mode by default, this will force automatic mode to activate in consensual scenes")
    endEvent
endstate

state setUseAutoFades
    Event OnSelectST(String state_id)
        Main.UseAutoFades = !Main.UseAutoFades
        SetToggleOptionValueST(Main.UseAutoFades, False, "setUseAutoFades")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Fade to black in between animation transitions")
    endEvent
endstate

state setAIChangeChance
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.AiSwitchChance)
        SetSliderDialogDefaultValue(6.0)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.AiSwitchChance = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Chance that characters will switch animations mid scene\nDoes not affect chance of a foreplay -> full sex transition")
    endEvent
endstate

state setUseFreeCam
    Event OnSelectST(String state_id)
        Main.UseFreeCam = !Main.UseFreeCam
        SetToggleOptionValueST(Main.UseFreeCam, False, "setUseFreeCam")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Automatically switch to freecam when a scene starts")
    endEvent
endstate

state setFreeCamFOV
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamFOV)
        SetSliderDialogDefaultValue(45.0)
        SetSliderDialogRange(1, 120)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamFOV = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The field of view of the camera when in freecam mode\nThis is incompatible with Improved Camera")
    endEvent
endstate

state setDefaultFOV
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.DefaultFOV)
        SetSliderDialogDefaultValue(85.0)
        SetSliderDialogRange(1, 120)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.DefaultFOV = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The field of view to return to when a scene ends when using free cam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setCameraSpeed
    Event OnSliderOpenST(String state_id)
        SetSliderDialogStartValue(Main.FreecamSpeed)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1, 20)
        SetSliderDialogInterval(1)
    endEvent

    Event OnSliderAcceptST(String state_id, float value)
        Main.FreecamSpeed = (Value as Int)
        SetSliderOptionValue(Option, Value, "{0}")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("The speed of the freecam")
    endEvent
endstate

state setDomLightMode
    Event OnSelectST(String state_id)
        Main.UseFreeCam = !Main.UseFreeCam
        SetToggleOptionValueST(Main.UseFreeCam, False, "setUseFreeCam")
    endEvent

    Event OnMenuAcceptST(String state_id)
        Main.DomLightPos = Index
        SetMenuOptionValue(SetDomLightMode, DomLightModeList[Index])
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable light on main actor at animation start")
    endEvent
endstate

state setSubLightMode
    Event OnSelectST(String state_id)
        Main.UseFreeCam = !Main.UseFreeCam
        SetToggleOptionValueST(Main.UseFreeCam, False, "setUseFreeCam")
    endEvent

    Event OnMenuAcceptST(String state_id)
        Main.SubLightPos = Index
        SetMenuOptionValue(Option, SubLightModeList[Index])
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Enable light on second actor at animation start")
    endEvent
endstate

state setDomLightBrightness
    Event OnSelectST(String state_id)
        Main.UseFreeCam = !Main.UseFreeCam
        SetToggleOptionValueST(Main.UseFreeCam, False, "setUseFreeCam")
    endEvent

    Event OnMenuAcceptST(String state_id)
        Main.DomLightBrightness = Index
        SetMenuOptionValue(Option, DomLightBrightList[Index])
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Set main actor's light's brightness")
    endEvent
endstate

state setSubLightBrightness
    Event OnSelectST(String state_id)
        Main.UseFreeCam = !Main.UseFreeCam
        SetToggleOptionValueST(Main.UseFreeCam, False, "setUseFreeCam")
    endEvent

    Event OnMenuAcceptST(String state_id)
        Main.SubLightBrightness = Index
        SetMenuOptionValue(Option, SubLightBrightList[Index])
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Set second actor's light's brightness")
    endEvent
endstate

state setOnlyLightInDark
    Event OnSelectST(String state_id)
        Main.LowLightLevelLightsOnly = !Main.LowLightLevelLightsOnly
        SetToggleOptionValueST(Main.LowLightLevelLightsOnly, False, "setOnlyLightInDark")
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Only use actor lights when the scene takes place in a dark area")
    endEvent
endstate

state exportSettings
    Event OnSelectST(String state_id)
        ExportSettings()
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Click this button to export the Ostim MCM settings.")
    endEvent
endstate

state importSettings
    Event OnSelectST(String state_id)
        ImportSettings()
    endEvent

    Event OnHighlightST(String state_id)
        SetInfoText("Click this button to import the Ostim MCM settings.")
    endEvent
endstate

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