
if not isfolder("TheSigmaHub") then
    makefolder("TheSigmaHub")
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local scriptversion = "v1.0.5"
local updateperiod = "16/06/2026"

local Window = Rayfield:CreateWindow({
    Name = "Sigmasaken",
    Name = "Sigmasaken " .. scriptversion,
    ScriptID = "sid_39jm3r1n1ocq",
    Icon = "sigma",
    LoadingTitle = "Sigmasaken",
    LoadingSubtitle = "Last updated: " .. updateperiod,
    ShowText = "Sigmasaken",
    Theme = {
                TextColor = Color3.fromRGB(230, 238, 245),
				Background = Color3.fromRGB(32, 38, 50),
				Topbar = Color3.fromRGB(42, 50, 66),
				Shadow = Color3.fromRGB(15, 18, 24),

				NotificationBackground = Color3.fromRGB(42, 50, 66),
				NotificationActionsBackground = Color3.fromRGB(230, 238, 245),

				TabBackground = Color3.fromRGB(50, 60, 78),
				TabStroke = Color3.fromRGB(70, 85, 105),
				TabBackgroundSelected = Color3.fromRGB(130, 170, 200),
				TabTextColor = Color3.fromRGB(205, 220, 235),
				SelectedTabTextColor = Color3.fromRGB(20, 28, 38),

				ElementBackground = Color3.fromRGB(40, 48, 62),
				ElementBackgroundHover = Color3.fromRGB(48, 58, 74),
				SecondaryElementBackground = Color3.fromRGB(36, 43, 56),
				ElementStroke = Color3.fromRGB(68, 82, 102),
				SecondaryElementStroke = Color3.fromRGB(58, 70, 88),

				SliderBackground = Color3.fromRGB(100, 145, 180),
				SliderProgress = Color3.fromRGB(130, 170, 200),
				SliderStroke = Color3.fromRGB(160, 195, 220),

				ToggleBackground = Color3.fromRGB(40, 48, 62),
				ToggleEnabled = Color3.fromRGB(130, 170, 200),
				ToggleDisabled = Color3.fromRGB(92, 102, 115),
				ToggleEnabledStroke = Color3.fromRGB(160, 195, 220),
				ToggleDisabledStroke = Color3.fromRGB(110, 120, 135),
				ToggleEnabledOuterStroke = Color3.fromRGB(90, 130, 165),
				ToggleDisabledOuterStroke = Color3.fromRGB(70, 78, 90),

				DropdownSelected = Color3.fromRGB(72, 77, 100),
				DropdownUnselected = Color3.fromRGB(36, 43, 56),

				InputBackground = Color3.fromRGB(36, 43, 56),
				InputStroke = Color3.fromRGB(68, 82, 102),
				PlaceholderColor = Color3.fromRGB(150, 165, 180),
		    },

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TheSigmaHub",
        FileName = "SigmasakenSettings"
    },

    Discord = {
        Enabled = false,
        Invite = "fBjUx54cbd",
        RememberJoins = true
    },

    KeySystem = false, -- dont enable, i was doing some demo work
    KeySettings = {
        Title = "Sigmasaken",
        Subtitle = "hashed",
        Note = "-",
        FileName = "c2lnbWFzYWtlbmtleXRlcm1zb2ZzZXJ2aWNl",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"0"}
    }
})

pcall(function()
    if not isfile("TheSigmaHub/totalexecutions.sigma") then
        writefile("TheSigmaHub/totalexecutions.sigma", "1")
        Rayfield:Notify({ 
            Title = "Total executions",
            Content = "You have total 1 execution",
            Duration = 5,
            Image = "calendar",
        })
    else
        local executions = tonumber(readfile("TheSigmaHub/totalexecutions.sigma"))
        writefile("TheSigmaHub/totalexecutions.sigma", tostring(tonumber(executions) + 1))
        executions = tonumber(readfile("TheSigmaHub/totalexecutions.sigma"))
        Rayfield:Notify({ 
            Title = "Total executions",
            Content = "You have total: " .. executions .. " executions",
            Duration = 5,
            Image = "calendar",
        })
    end
end)

local players = game:GetService("Players")
local lli = game:GetService("Lighting")
local run = game:GetService("RunService")
local srv = game:GetService("SoundService")
local rs = game:GetService("ReplicatedStorage")
local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")
-- local mp = game:GetService("MarketplaceService")
local textchat = game:GetService("TextChatService")
local twin = game:GetService("TweenService") -- WWWWW
local tts = game:GetService("TestService")
local lp = players.LocalPlayer
local playergui = lp.PlayerGui

local mainremote = rs.Modules.Network.Network.RemoteEvent
local ismobile = false
if uis.TouchEnabled and not uis.MouseEnabled then
    ismobile = true
	tts:Message("Mobile device")
elseif not uis.TouchEnabled and uis.KeyboardEnabled and uis.MouseEnabled then
	tts:Message("Computer device")
end

-- tabs
local ESPTab = Window:CreateTab("ESP", 89705354952445)
local StaminaTab = Window:CreateTab("Movement", 131988134488629)
local MiscTab = Window:CreateTab("Misc", 125961818116791)
local CombatTab = Window:CreateTab("Combat", 100914317336916)
local AudioTab = Window:CreateTab("Music", 74530234897361)
local FunTab = Window:CreateTab("Fun", 70414744064346)
local GeneratorTab = Window:CreateTab("Objectives", 93079123429781)
local SettingsTab = Window:CreateTab("Settings", 102842005215871)

task.spawn(function()

local rgdl = game.workspace:FindFirstChild("Ragdolls")
local ingamefolder = workspace.Map.Ingame
local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
local mousemodule = rs.Systems.Player.Miscellaneous.GetPlayerMousePosition
local kill = workspace.Players.Killers
local surv = workspace.Players.Survivors
local stunconn, fovconn, unstunconn
local SmoothShiftLock

local currentkiller = nil
local togglenormalesp = false
local toggleminionsesp = false
local togglefootesp = false
local toggleritualesp = false
local togglequestesp = false
local togglebb = false
local esptpn = 0.5

local togglecf = false
local adaprivecf = false
local cfspeed = 20
local cfmultiplier = 1
local num1 = 100
local num2 = 0
local num3 = 20
local num4 = 10
local num5 = 26
local ssk = 28
local ms = 110
local num6 = false

local autopickupbloxy = false
local autopickupmedkit = false
local chatvisibility = false
local togglewalktroughkilleronly = false
local godmode = false
local customjumppower = 0
local fblooping = false
local toggleinvis = false
local toggleinviswhensurv = false
local invis = nil
local flipcoin = false
local charges = 2
local toggleinkognito = true
local device = "Disable"
local curdevice = ""
local changingdevice = false
local dusekprotection = false
local makepizzabigger = false
local instanteatpizza = false
local pizzasize = 30
local disableslowness = false
local disablefovmodf = false
local deletejohntoespikes = false
local disableblind = false
local disableragdoll = false
local togglenoclip = false

local hitboxsize = 18
local visiblehitbox = false
local toggleautoblock = false
local autoblockpart = nil
local autocd = false
local customautoblockhitboxcolor = Color3.fromRGB(255, 255, 255)
local autoblockconn
local autopunch = false

local jh = false
local jh2 = false
local jh3 = false
local tped = false
local hdist = 10
local hitboxfunc
local hitboxfunc2
local bjh = false
local noveedmg = false
local gcd = false
local plsj = false
local veecontrol = 1
local veenopaint = false
local noskateloss = false
local autoveetrick = false
local customskatespeed = 1
local customtrickpower = 1
local customtrickjpower = 1
local customtrickcooldown = 1
local veecfg = {}
local togglenmg = false
local crystalchrg = false
local ibmg = 0.1
local ibmgr = 0.1
local mgr = false
local predictiontime = 0.4
local slientaim = false
local killerssilentaim = false
local curs
local enablecursor = ismobile
local cursorypos = 20
local mousepos = nil
local slientaimtype = "Killer"
local toggleaim = false
local togglecharaim = false
local togglekilleraim = false
local toggleaimpredict = false
local toggleooblock = false
local ooblockdelay = 1
local togglebettercontroll = false
local controllll = 1
local toggleautobackstab = false
local autobackstabtype = "Tween"
local usewithhitboxdrag = false
local autolook = false
local autobackstabtrigdist = 10
local autobackstabdistance = 0.25
local truepunch = false
local moving = false
local track
local controllconn
local fakeblockanimation = "Normal"
local togglefakeblock = false
local hrp = lp.Character:WaitForChild("HumanoidRootPart", 5)
local hum = lp.Character:WaitForChild("Humanoid", 5)
local kick = false
local toggledesync = false

local currentanimationreplace = "None"
local animationcode = nil
local currentcustomemote = "None"
local emoteanimationspy, emotesoundspy
local useemotegui = 0
local customlmsmusic = "None"
local customlobbymusic = "Normal"
local currentshedanim = "None"
local currentguestanim = "None"
local useemotegui = 0
local shedanimchagerconn
local guestanimchangerconn
local flipheight = 15
local flipdistance = 35
local togglefrontflip = false
local instantflip = false
local frontflipcooldown = false
local toggragafterst = false

local toggleautogen = false
local dotaskwhenjoingen = false
local lastusedgenerator = nil
local dotaskcooldown = false
local timebeforegen = 4.5
local timegenrandomize = 0
local currentimage = "None"

local sausageHolder
local originalSize
if game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame:FindFirstChild("UnibarMenu") and game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.UnibarMenu:FindFirstChild("2") then
    sausageHolder = game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
    originalSize = sausageHolder.Size.X.Offset
elseif game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame:FindFirstChild("TopBarLeftContainer") and 
    game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.TopBarLeftContainer:FindFirstChild("UnibarMenu") and 
    game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.TopBarLeftContainer.UnibarMenu:FindFirstChild("2") then

    sausageHolder = game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.TopBarLeftContainer.UnibarMenu:FindFirstChild("2")
    originalSize = sausageHolder.Size.X.Offset
end
local usefbtoggle = false
local useemote = false
local useflip = false
local usegenerator = false

local generators = {}
local generatorhls = {}
local fakegenshls = {}
local itemhls = {}
local killershl = {}
local srvshl = {}
local footshls = {}
local minionshls = {}
local ritualhls = {}
local questhls = {}
local allbbs = {}
local allhls = {}
local sigmausers = {}

local autoblocktrigers = loadstring(game:HttpGet("https://raw.githubusercontent.com/gopnikjovana/animations-tables/refs/heads/main/autoblocksounds.luau"))()

local AttackAnimations = loadstring(game:HttpGet("https://raw.githubusercontent.com/gopnikjovana/animations-tables/refs/heads/main/atackanimations.luau"))()

local controllanims = {
  	["rbxassetid://106776364623742"] = {delay = 0.5, speed = 80}, -- walkspeed override
	["rbxassetid://126896426760253"] = {delay = 0, speed = 47}, -- void rush
	["rbxassetid://135884061951801"] = {delay = 0, speed = 50}, -- looks loke void rush but i cant tell
  	["rbxassetid://106014898528300"] = {delay = 0.1, speed = 30}, -- 1337 charge
	["rbxassetid://73502073176819"] = {delay = 0.1, speed = 30}, -- 1337 cahrge green day
	["rbxassetid://97623143664485"] = {delay = 0.1, speed = 30}, -- 1337 charge bobby ig
    ["rbxassetid://96173857867228"] = {delay = 0.1, speed = 30},
    ["rbxassetid://74291573260497"] = {delay = 0.1, speed = 30},
    ["rbxassetid://96173857867228"] = {delay = 0.1, speed = 30},
    ["rbxassetid://100505444434161"] = {delay = 0.1, speed = 30},
    ["rbxassetid://97690896670367"] = {delay = 0.1, speed = 30},
}

local customanimsids = {
    noli = {
        walkAnimationId = "rbxassetid://103292185212679",
        idleAnimationId = "rbxassetid://83465205704188",
        jumpAnimationId = "rbxassetid://83465205704188",
	    runanimationId = "rbxassetid://103292185212679",
    },
    one_eggs_one_eggs_one_eggs_one = {
        walkAnimationId = "rbxassetid://131235528875091",
        idleAnimationId = "rbxassetid://138754221537146",
        jumpAnimationId = "rbxassetid://138754221537146",
	    runanimationId = "rbxassetid://106485518413331",
    },
    jason = {
        walkAnimationId = "rbxassetid://93622022596108",
        idleAnimationId = "rbxassetid://116050994905421",
        jumpAnimationId = "rbxassetid://116050994905421",
	    runanimationId = "rbxassetid://93054787145505",
    },
    johndoe = {
        walkAnimationId = "rbxassetid://81193817424328",
        idleAnimationId = "rbxassetid://105880087711722",
        jumpAnimationId = "rbxassetid://105880087711722",
	    runanimationId = "rbxassetid://95204713031545",
    },
    c00lkidd = {
        walkAnimationId = "rbxassetid://18885906143",
        idleAnimationId = "rbxassetid://18885903667",
        jumpAnimationId = "rbxassetid://18885903667",
	    runanimationId = "rbxassetid://96571077893813",
    },
    mafioso = {
        walkAnimationId = "rbxassetid://90878063243908",
        idleAnimationId = "rbxassetid://112527946233530",
        jumpAnimationId = "rbxassetid://112527946233530",
	    runanimationId = "rbxassetid://90878063243908",
    },
    pizzadelivery = {
        walkAnimationId = "rbxassetid://18886064499",
        idleAnimationId = "rbxassetid://18886066950",
        jumpAnimationId = "rbxassetid://18886066950",
	    runanimationId = "rbxassetid://18886064499",
    },
    busterbrawler = {
        walkAnimationId = "rbxassetid://96194626828153",
        idleAnimationId = "rbxassetid://96173779255396",
        jumpAnimationId = "rbxassetid://96173779255396",
	    runanimationId = "rbxassetid://96194626828153",
    },
	    herobrine = {
        walkAnimationId = "rbxassetid://89380107485006",
        idleAnimationId = "rbxassetid://107799240559806",
        jumpAnimationId = "rbxassetid://107799240559806",
	    runanimationId = "rbxassetid://89380107485006",
    },
	dukeerisa = {
        walkAnimationId = "rbxassetid://74634685431456",
        idleAnimationId = "rbxassetid://132811450080149",
        jumpAnimationId = "rbxassetid://132811450080149",
	    runanimationId = "rbxassetid://74634685431456",
    },
	    erlking = {
        walkAnimationId = "rbxassetid://72722119435580",
        idleAnimationId = "rbxassetid://138465378316476",
        jumpAnimationId = "rbxassetid://138465378316476",
	    runanimationId = "rbxassetid://72722119435580",
    },
	sancho = {
        walkAnimationId = "rbxassetid://87121677046773",
        idleAnimationId = "rbxassetid://93727662665079",
        jumpAnimationId = "rbxassetid://93727662665079",
	    runanimationId = "rbxassetid://87121677046773",
    },
	stalker = {
        walkAnimationId = "rbxassetid://108287960442206",
        idleAnimationId = "rbxassetid://135419935358802",
        jumpAnimationId = "rbxassetid://135419935358802",
	    runanimationId = "rbxassetid://108287960442206",
    },
    pursuer = {
        walkAnimationId = "rbxassetid://100206079439305",
        idleAnimationId = "rbxassetid://94895464960972",
        jumpAnimationId = "rbxassetid://94895464960972",
	    runanimationId = "rbxassetid://138660433982140",
    },
}

local customemotesanims = {
    subter_fuge = {
        animationId = "rbxassetid://87482480949358",
        soundId = "rbxassetid://132297506693854",
        loops = false,
    },
    shucks = {
        animationId = "rbxassetid://74238051754912",
        soundId = "rbxassetid://123236721947419",
        loops = false,
    },
    silly_billy = {
        animationId = "rbxassetid://107464355830477",
        soundId = "rbxassetid://77601084987544",
        loops = false,
    },
    silly_billy_secret_version = {
        animationId = "rbxassetid://107464355830477",
        soundId = "rbxassetid://120176009143091",
        loops = false,
    },
    griddy = {
        animationId = "rbxassetid://93821902607346",
        soundId = "rbxassetid://0",
        loops = true,
    },
    wait = {
        animationId = "rbxassetid://119813505721636",
        soundId = "rbxassetid://123179402505565",
        loops = true,
    },
    so_retro = {
        animationId = "rbxassetid://90399490625732",
        soundId = "rbxassetid://81332555827290",
        loops = true,
    },
    subject_three = {
        animationId = "rbxassetid://75193609204744",
        soundId = "rbxassetid://136651893030423",
        loops = true,
    },
    distraction_dance = {
        animationId = "rbxassetid://98261071866527",
        soundId = "rbxassetid://0",
        loops = true,
    },
    poisoned = {
        animationId = "rbxassetid://83463199855585",
        soundId = "rbxassetid://118582448199737",
        loops = true,
    },
    pyt = {
        animationId = "rbxassetid://91362496118165",
        soundId = "rbxassetid://123571142022763",
        loops = true,
    },
    locked = {
        animationId = "rbxassetid://77920404652731",
        soundId = "rbxassetid://134957854576218",
        loops = true,
    },
    miss_the_quiet = {
        animationId = "rbxassetid://100986631322204",
        soundId = "rbxassetid://131936418953291",
        loops = true,
    },
    company_groove = {
        animationId = "rbxassetid://89926565466406",
        soundId = "rbxassetid://87037127480984",
        loops = true,
    },
	insanity = {
        animationId = "rbxassetid://75420633536507",
        soundId = "rbxassetid://125452574134166",
        loops = true,
    },
	hero = {
        animationId = "rbxassetid://133160365635320",
        soundId = "rbxassetid://114638282732720",
        loops = true,
    },
	headbanger = {
        animationId = "rbxassetid://103719006556178",
        soundId = "rbxassetid://0",
        loops = true,
    },
	california_girls_old = {
        animationId = "rbxassetid://121768360244671",
        soundId = "rbxassetid://96677274748910",
        loops = true,
    },
	bagup = {
        animationId = "rbxassetid://117853129871362",
        soundId = "rbxassetid://133954185831066",
        loops = true,
    },
	aol_guy = {
        animationId = "rbxassetid://80918082366233",
        soundId = "rbxassetid://101494406892555",
        loops = true,
    },
	cat_dance = {
        animationId = "rbxassetid://133145243088885",
        soundId = "rbxassetid://75850411329107",
        loops = true,
    },
	dio = {
        animationId = "rbxassetid://85856303945173",
        soundId = "rbxassetid://88954959076192",
        loops = false,
    },
	tick_tock = {
        animationId = "rbxassetid://118204083671442",
        soundId = "rbxassetid://79383274437776",
        loops = true,
    },
}

local FATLETSKY_ANIMS = {
    NORMAL = {
        SLASH = "rbxassetid://116618003477002",
        CHICKEN = "rbxassetid://121781457295101",
    },
    TURKING = {
        SLASH = "rbxassetid://116618003477002",
        CHICKEN = "rbxassetid://87614442534377",
    },
    JOHNWARD = {
        SLASH = "rbxassetid://97648548303678",
        CHICKEN = "rbxassetid://130578336615625",
    },
    BLOXY = {
        SLASH = "rbxassetid://110400453990786",
        CHICKEN = "rbxassetid://102343031936929",
    },
    BRIGHTEYES = {
        SLASH = "rbxassetid://98031287364865",
        CHICKEN = "rbxassetid://121781457295101",
    },
    HEARTBROKEN = {
        SLASH = "rbxassetid://119462383658044",
        CHICKEN = "rbxassetid://121781457295101",
    },
    SUNDERLAND = {
        SLASH = "rbxassetid://131696603025265",
        CHICKEN = "rbxassetid://107074146593306",
    },
    MILESTONE = {
        SLASH = "rbxassetid://77448521277146",
        CHICKEN = "rbxassetid://121781457295101",
    },
    RETRO = {
        SLASH = "rbxassetid://121255898612475",
        CHICKEN = "rbxassetid://89158177589094",
    },
    SKIES = {
        SLASH = "rbxassetid://122503338277352",
        CHICKEN = "rbxassetid://121781457295101",
    },
}

local GUEST_ANIMS = {
    NORMAL = {
        BLOCK = "rbxassetid://72722244508749",
        PUNCH = "rbxassetid://87259391926321",
        CHARGE = "rbxassetid://106014898528300",
    },
    GREENBELT = {
        BLOCK = "rbxassetid://82605295530067",
        PUNCH = "rbxassetid://138040001965654",
        CHARGE = "rbxassetid://73502073176819",
    },
    DEMOMAN = {
        BLOCK = "rbxassetid://115706752305794",
        PUNCH = "rbxassetid://129843313690921",
        CHARGE = "rbxassetid://97623143664485",    
    },
    GUNNER = {
        BLOCK = "rbxassetid://95802026624883",
        PUNCH = "rbxassetid://87259391926321",
        CHARGE = "rbxassetid://106014898528300",
    },
    SOCCER = {
        BLOCK = "rbxassetid://82605295530067",
        PUNCH = "rbxassetid://86709774283672",
        CHARGE = "rbxassetid://106014898528300",
    },
    PIXEL = {
        BLOCK = "rbxassetid://72722244508749",
        PUNCH = "rbxassetid://136007065400978",
        CHARGE = "rbxassetid://106014898528300",
    },
    KJ = {
        BLOCK = "rbxassetid://72722244508749",
        PUNCH = "rbxassetid://91522546229765",
        CHARGE = "rbxassetid://106014898528300",
    },
    DRAGONGUEST = {
        BLOCK = "rbxassetid://72722244508749",
        PUNCH = "rbxassetid://140703210927645",
        CHARGE = "rbxassetid://106014898528300",
    },
    BOBBY = {
        BLOCK = "rbxassetid://95802026624883",
        PUNCH = "rbxassetid://87259391926321",
        CHARGE = "rbxassetid://97623143664485",
    },
    MILESTONES = {
        BLOCK = "rbxassetid://96959123077498",
        PUNCH = "rbxassetid://86096387000557",
        CHARGE = "rbxassetid://106014898528300",
    },
}

local espcolors = {
    Killers = Color3.fromRGB(255, 0, 0),
    Survivors = Color3.fromRGB(0, 0, 255),
    Generators = Color3.fromRGB(125, 0, 255),
    Items = Color3.fromRGB(255, 255, 0),
    Rituals = Color3.fromRGB(255, 255, 255),
    Minions = Color3.fromRGB(0, 255, 255),
    Foots = Color3.fromRGB(255, 125, 0),
    Quests = Color3.fromRGB(255, 255, 255),
    FakeGenerators = Color3.fromRGB(255, 0, 0),
}

local durations = {
    Slash = 0.8,
    Shoot = 1,
    Dagger = 0.7,
    Punch = 1.1,
	Axe = 0.8,
}

local killerdurations = {
    WalkspeedOverride = 0.4,
    MassInfection = 2,
    Entanglement = 0.5,
    CorruptEnergy = 3.5,
    Stab = 0.9,
    Punch = 0.4,
    GashingWound = 0.4,
    Behead = 0.65,
    Slash = 0.7
}

local NameProtecting = {}

local GeneratorAssets = {"None",}
local LMSAssets = {"None", "Custom",}
local LobbyAssets = {"Normal", "Custom",}

local shedtrigers = {
    ["rbxassetid://116618003477002"] = "SLASH",
    ["rbxassetid://121781457295101"] = "CHICKEN",
}

local guesttrigers = {
    ["rbxassetid://87259391926321"] = "PUNCH",
    ["rbxassetid://106014898528300"] = "CHARGE",
    ["rbxassetid://72722244508749"] = "BLOCK",
}









-- Functions:
-- Download:
task.spawn(function()
local function GetAssetList()
	local url = "https://api.github.com/repos/sigmaboy-sigma-boy/SigmasakenHubFileDownloader/git/trees/main?recursive=1"
	local assetList = {}

	local success, errorMessage = pcall(function()
		local Request = http_request or syn.request or request
		if not Request then
			return {}
		end
		if Request then
			local response = Request({
				Url = url,
				Method = "GET",
				Headers = { ["Content-Type"] = "application/json" },
			})

			if response.StatusCode ~= 200 then
				return {}
			end

			if response and response.Body then
				local data = game:GetService("HttpService"):JSONDecode(response.Body)
				for _, item in ipairs(data.tree) do
					if
						item.path:match("^SigmasakenAsset/.+%.png$")
						or item.path:match("^SigmasakenAsset/.+%.mp4$")
						or item.path:match("SigmasakenAsset/(.+)%.mp3$")
					then
						local rawUrl = "https://raw.githubusercontent.com/sigmaboy-sigma-boy/SigmasakenHubFileDownloader/main/" .. item.path
						table.insert(assetList, rawUrl)

						local name = item.path:match("SigmasakenAsset/(.+)%.png$") or item.path:match("SigmasakenAsset/(.+)%.mp4$")
					end
				end
			end
		end
	end)

	if not success then
		Rayfield:Notify({ 
			Title = "Error",
			Content = errorMessage,
			Duration = 6.5,
			Image = "circle-alert",
		})
	end
	return assetList
end

local function DownloadBallers(url, path)
	if not url:match("^https://") then
		return
	end
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet(url, true)
		end)
		if not suc or res == "404: Not Found" then
		end
		task.delay(5, function()
			if not isfile(path) then
				return
			end
		end)
		writefile(path, res)
	end
end

local function CheckIfSigmasDownloaded()
	local assetList = GetAssetList()
	local basePath = "TheSigmaHub/Assets/"

	if not isfolder("TheSigmaHub") then
		makefolder("TheSigmaHub")
	end

	if not isfolder(basePath) then
		makefolder(basePath)
	end

	task.spawn(function()
		for _, url in ipairs(assetList) do
			local filePath = basePath .. url:match("SigmasakenAsset/(.+)")
			if filePath then
				local newFilePath = filePath
					:gsub("%.png$", ".png.Sigma")
					:gsub("%.mp4$", ".mp4.Sigma4")
					:gsub("%.mp3$", ".mp3")

                if filePath:find(".png") and string.split(filePath, "/")[4] == nil then
					table.insert(NameProtecting, string.split(filePath, "/")[3])
                --[[elseif filePath:find(".png") and string.split(filePath, "/")[3] == "GeneratorAssets" then
                    if not GeneratorAssets[string.split(filePath, "/")[4]] --then
                        --[[GeneratorAssets[string.split(filePath, "/")[4]] --= {}
                    --[[end
                    GeneratorAssets[string.split(filePath, "/")[4]]--[[.image = newFilePath
                elseif filePath:find(".mp3") and string.split(filePath, "/")[3] == "GeneratorAssets" then
                    if not GeneratorAssets[string.split(filePath, "/")[4]] --then
                        --[[GeneratorAssets[string.split(filePath, "/")[4]] --= {}
                    --[[end
                    GeneratorAssets[string.split(filePath, "/")[4]]--.sound = newFilePath
                --elseif filePath:find(".mp3") and string.split(filePath, "/")[3] == "Lobby" then
                    --table.insert(LobbyAssets, (#LobbyAssets + 1), string.split(filePath, "/")[4]:gsub(".mp3", ""))
                    --print(filePath)
                --elseif filePath:find(".mp3") and string.split(filePath, "/")[3] == "LMS" then
                    --table.insert(LMSAssets, (#LMSAssets + 1), string.split(filePath, "/")[4]:gsub(".mp3", ""))
                    --print(filePath)]]
				end

				if not isfile(newFilePath) then
					local folderPath = newFilePath:match("(.*/)")
					if folderPath and not isfolder(folderPath) then
						makefolder(folderPath)
					end
					
					task.spawn(function()
						DownloadBallers(url, newFilePath)
						Rayfield:Notify({ 
							Title = "Downloaded",
							Content = newFilePath,
							Duration = 1,
							Image = "download"
						})
					end)
					task.wait(0.25)
				end
			end
		end
	end)
end

local function LoadAsset(assetName)
    local basePath = "TheSigmaHub/Assets/"
    local assetPath = basePath .. assetName
    
    if isfile(assetPath) then
    	return getcustomasset(assetPath)
    else
    	return nil
    end
end

-- ESP:
local function createplayeresp(player, category)
    local hrp = player:FindFirstChild("HumanoidRootPart")
    if not hrp or player == lp.Character then return end

    if not hrp:FindFirstChild("nameesp") then
        local namegui = Instance.new("BillboardGui")
        namegui.Name = "nameesp"
        namegui.Size = UDim2.new(0, 200, 0, 30)
        namegui.StudsOffset = Vector3.new(0, 3.1, 0)
        namegui.AlwaysOnTop = true
        namegui.Parent = hrp

        local textlabel = Instance.new("TextLabel")
        textlabel.Name = "label"
        textlabel.BackgroundTransparency = 1
        textlabel.Size = UDim2.new(1, 0, 1, 0)
        textlabel.Font = Enum.Font.Roboto
        textlabel.TextColor3 = Color3.new(1, 1, 1)
        textlabel.TextStrokeTransparency = 0
        textlabel.TextSize = 10
        textlabel.TextScaled = false
        textlabel.Text = ""
        textlabel.Parent = namegui
        table.insert(allbbs, namegui)
    end
    if not hrp:FindFirstChild("healthesp") then
        local healthgui = Instance.new("BillboardGui")
        healthgui.Name = "healthesp"
        healthgui.Size = UDim2.new(0, 100, 0, 25)
        healthgui.StudsOffset = Vector3.new(0, -3.75, 0)
        healthgui.AlwaysOnTop = true
        healthgui.Parent = hrp

        local healthlabel = Instance.new("TextLabel")
        healthlabel.Name = "healthlabel"
        healthlabel.BackgroundTransparency = 1
        healthlabel.Size = UDim2.new(1, 0, 1, 0)
        healthlabel.Font = Enum.Font.Roboto
        healthlabel.TextColor3 = Color3.new(0, 1, 0)
        healthlabel.TextStrokeTransparency = 0
        healthlabel.TextSize = 11
        healthlabel.TextScaled = false
        healthlabel.Text = ""
        healthlabel.Parent = healthgui
        table.insert(allbbs, healthgui)
    end
    if not player:FindFirstChild("HL") then
        local hl = Instance.new("Highlight")
        hl.Enabled = false
        hl.Name = "HL"
        hl.OutlineTransparency = esptpn - 0.15
        hl.FillTransparency = esptpn
        hl.FillColor = espcolors[category]
        hl.OutlineColor = espcolors[category]
        table.insert(allhls, hl)
        if category == "Killers" then
            table.insert(killershl, hl)
        else
            table.insert(srvshl, hl)
        end

        task.spawn(function()
            while task.wait(0.1) do
                if togglenormalesp then
                    hl.Enabled = true
                else
                    hl.Enabled = false
                end
                local otherhl = player:FindFirstChildOfClass("Highlight")
                if otherhl and otherhl.Name ~= "HL" then otherhl:Destroy() end
            end
        end)

        hl.Parent = player
    end

    if category == "Killers" then
        task.spawn(function()
            while task.wait(0.1) do
                if not togglebb then
                    local namegui = hrp:FindFirstChild("nameesp")
                    local healthgui = hrp:FindFirstChild("healthesp")

                    if namegui and namegui.Enabled then namegui.Enabled = false end
                    if healthgui and healthgui.Enabled then healthgui.Enabled = false end
                else
                    local namegui = hrp:FindFirstChild("nameesp")
                    if namegui and togglebb then
                        if not namegui.Enabled then namegui.Enabled = true end
                        local label = namegui:FindFirstChild("label")
                        if label then
                            label.Text = player.Name
                            label.TextColor3 = espcolors["Killers"]
                        end
                    end

                    local hrp = player.HumanoidRootPart
                    local healthgui = hrp:FindFirstChild("healthesp")
                    local humanoid = player:FindFirstChildOfClass("Humanoid")
                    if healthgui and humanoid and togglebb then
                        local healthlabel = healthgui:FindFirstChild("healthlabel")
                        if healthlabel then
                            local hp = math.clamp(humanoid.Health, 0, humanoid.MaxHealth)
                            healthlabel.Text = string.format("%d/%d", math.floor(hp), math.floor(humanoid.MaxHealth))
                            if player.Name == "c00lkidd" then
                                if hp >= 600 then
                                    healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hp >= 300 then
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            elseif player.Name == "JohnDoe" then
                                if hp >= 1000 then
                                    healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hp >= 500 then
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            elseif player.Name == "Jason" then
                                if hp >= 800 then
                                    healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hp >= 340 then
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            elseif player.Name == "Noli" then
                                if hp >= 740 then
                                    healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hp >= 370 then
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            elseif player.Name == "1x1x1x1" then
                                if hp >= 800 then
                                    healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hp >= 400 then
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            end

                            if not togglenormalesp or not togglebb or player == lp.Character then 
                                healthgui.Enabled = false
                            else 
                                healthgui.Enabled = true
                            end
                        end
                    elseif healthgui and humanoid then
                        healthgui.Enabled = false
                    end
                end
            end
        end)
    else
        task.spawn(function()
            while task.wait(0.1) do
                if not togglebb then
                    local namegui = hrp:FindFirstChild("nameesp")
                    local healthgui = hrp:FindFirstChild("healthesp")

                    if namegui and namegui.Enabled then namegui.Enabled = false end
                    if healthgui and healthgui.Enabled then healthgui.Enabled = false end
                else
                    local namegui = hrp:FindFirstChild("nameesp")
                    if namegui and togglebb then
                        if not namegui.Enabled then namegui.Enabled = true end
                        local label = namegui:FindFirstChild("label")
                        if label then
                            label.Text = player.Name
                            label.TextColor3 = espcolors["Survivors"]
                        end
                    end

                    local hrp = player.HumanoidRootPart
                    local healthgui = hrp:FindFirstChild("healthesp")
                    local humanoid = player:FindFirstChildOfClass("Humanoid")
                    if healthgui and humanoid and togglebb then
                        local healthlabel = healthgui:FindFirstChild("healthlabel")
                        if healthlabel then
                            local hp = math.clamp(humanoid.Health, 0, humanoid.MaxHealth)
                            healthlabel.Text = string.format("%d/%d", math.floor(hp), math.floor(humanoid.MaxHealth))

                            if hp >= 65 then
                                healthlabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                            elseif hp >= 40 then
                                healthlabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            else
                                healthlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                            
                            if not togglenormalesp then 
                                healthgui.Enabled = false
                            else 
                                healthgui.Enabled = true
                            end
                        end
                    elseif healthgui and humanoid then
                        healthgui.Enabled = false
                    end
                end
            end
        end)
    end
end

local function createesps(item, category)
    if category == "Generators" then
        local prgs = item:FindFirstChild("Progress")
        local prprt = item.PrimaryPart

        if prgs.Value == nil then prgs.Value = 0 end

        if not prprt:FindFirstChild("generatorbb") then
            local gui2 = Instance.new("BillboardGui")
            gui2.Name = "generatorbb"
            gui2.Size = UDim2.new(0, 150, 0, 30)
            gui2.StudsOffset = Vector3.new(0, 3, 0)
            gui2.AlwaysOnTop = true
            gui2.Parent = prprt

            local label2 = Instance.new("TextLabel")
            label2.Name = "label"
            label2.BackgroundTransparency = 1
            label2.Size = UDim2.new(1, 0, 1, 0)
            label2.Font = Enum.Font.Roboto
            label2.TextColor3 = espcolors["Generators"]
            label2.TextStrokeTransparency = 0
            label2.TextSize = 11
            label2.TextScaled = false
            label2.Text = ""
            label2.Parent = gui2
        end
        if not prprt:FindFirstChild("generatoresp") then
            local gui = Instance.new("BillboardGui")
            gui.Name = "generatoresp"
            gui.Size = UDim2.new(0, 150, 0, 30)
            gui.StudsOffset = Vector3.new(0, 0, 0)
            gui.AlwaysOnTop = true
            gui.Parent = prprt

            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.Roboto
            label.TextColor3 = Color3.fromRGB(225, 225, 225)
            label.TextStrokeTransparency = 0
            label.TextSize = 8
            label.TextScaled = false
            label.Text = ""
            label.Parent = gui

            if prgs.Value == 0 then
                label.Text = "0%"
            elseif prgs.Value == 26 then
                label.Text = "25%"
            elseif prgs.Value == 52 then
                label.Text = "50%"
            elseif prgs.Value == 78 then
                label.Text = "75%"
            else
                label.Text = "100%"
            end

            prgs:GetPropertyChangedSignal("Value"):Connect(function()
                if prgs.Value == 0 then
                    label.Text = "0%"
                elseif prgs.Value == 26 then
                    label.Text = "25%"
                elseif prgs.Value == 52 then
                    label.Text = "50%"
                elseif prgs.Value == 78 then
                    label.Text = "75%"
                else
                    label.Text = "100%"
                end                    
            end)
        end
        if not item:FindFirstChild("HL") then
            local hl = Instance.new("Highlight")
            hl.Enabled = false
            hl.FillColor = espcolors["Generators"]
            hl.OutlineColor = espcolors["Generators"]
            hl.OutlineTransparency = esptpn - 0.15
            hl.FillTransparency = esptpn

            table.insert(generatorhls, hl)
            local bb = prprt:FindFirstChild("generatoresp")

            task.spawn(function()
                while task.wait(0.1) do
                    if togglenormalesp then
                        hl.Enabled = true
                        if bb and not bb.Enabled then bb.Enabled = true end 
                    else
                        hl.Enabled = false
                        if bb and bb.Enabled then bb.Enabled = false end 
                    end
                    if prgs.Value == 100 then
                        hl.FillColor = Color3.fromRGB(0, 255, 0)
                        hl.OutlineColor = Color3.fromRGB(0, 255, 0)
                    end
                end
            end)

            task.spawn(function()
                while task.wait(0.1) do
                    if not togglebb then
                        local namegui = prprt:FindFirstChild("generatorbb")
                        if namegui and namegui.Enabled then namegui.Enabled = false end
                    else
                        local namegui = prprt:FindFirstChild("generatorbb")
                        if namegui then
                            local label = namegui:FindFirstChild("label")
                            if label then
                                if not namegui.Enabled then namegui.Enabled = true end
                                label.Text = "Generator"

                                if prgs.Value == 100 then
                                    label.TextColor3 = Color3.fromRGB(0, 255, 0)
                                else
                                    label.TextColor3 = espcolors["Generators"]
                                end
                            end
                        end
                    end
                end
            end)

            hl.Parent = item

            item.ChildAdded:Connect(function(child)
                if child:IsA("Highlight") and child.Name ~= "HL" then child:Destroy() end
            end)
        end
    elseif category == "FakeGenerators" then
        local prgs = item:FindFirstChild("Progress")
        local prprt = item.PrimaryPart

        if prgs.Value == nil then prgs.Value = 0 end

        if not prprt:FindFirstChild("generatorbb") then
            local gui2 = Instance.new("BillboardGui")
            gui2.Name = "generatorbb"
            gui2.Size = UDim2.new(0, 150, 0, 30)
            gui2.StudsOffset = Vector3.new(0, 3, 0)
            gui2.AlwaysOnTop = true
            gui2.Parent = prprt

            local label2 = Instance.new("TextLabel")
            label2.Name = "label"
            label2.BackgroundTransparency = 1
            label2.Size = UDim2.new(1, 0, 1, 0)
            label2.Font = Enum.Font.Roboto
            label2.TextColor3 = espcolors["FakeGenerators"]
            label2.TextStrokeTransparency = 0
            label2.TextSize = 11
            label2.TextScaled = false
            label2.Text = ""
            label2.Parent = gui2
        end
        if not prprt:FindFirstChild("generatoresp") then
            local gui = Instance.new("BillboardGui")
            gui.Name = "generatoresp"
            gui.Size = UDim2.new(0, 150, 0, 30)
            gui.StudsOffset = Vector3.new(0, 0, 0)
            gui.AlwaysOnTop = true
            gui.Parent = prprt

            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.Roboto
            label.TextColor3 = Color3.fromRGB(225, 225, 225)
            label.TextStrokeTransparency = 0
            label.TextSize = 8
            label.TextScaled = false
            label.Text = ""
            label.Parent = gui

            if prgs.Value == 0 then
                label.Text = "0%"
            elseif prgs.Value == 26 then
                label.Text = "25%"
            elseif prgs.Value == 52 then
                label.Text = "50%"
            elseif prgs.Value == 78 then
                label.Text = "75%"
            else
                label.Text = "100%"
            end

            prgs:GetPropertyChangedSignal("Value"):Connect(function()
                if prgs.Value == 0 then
                    label.Text = "0%"
                elseif prgs.Value == 26 then
                    label.Text = "25%"
                elseif prgs.Value == 52 then
                    label.Text = "50%"
                elseif prgs.Value == 78 then
                    label.Text = "75%"
                else
                    label.Text = "100%"
                end                    
            end)
        end
        if not item:FindFirstChild("HL") then
            local hl = Instance.new("Highlight")
            hl.Enabled = false
            hl.FillColor = espcolors["FakeGenerators"]
            hl.OutlineColor = espcolors["FakeGenerators"]
            hl.OutlineTransparency = esptpn - 0.15
            hl.FillTransparency = esptpn

            table.insert(fakegenshls, hl)

            task.spawn(function()
                while task.wait(0.1) do
                    local bb = prprt:FindFirstChild("generatoresp")
                    if togglenormalesp then
                        hl.Enabled = true
                        if bb and not bb.Enabled then bb.Enabled = true end 
                    else
                        hl.Enabled = false
                        if bb and bb.Enabled then bb.Enabled = false end 
                    end
                end
            end)

            task.spawn(function()
                while task.wait(0.1) do
                    if not togglebb then
                        local namegui = prprt:FindFirstChild("generatorbb")
                        if namegui and namegui.Enabled then namegui.Enabled = false end
                    else
                        local namegui = prprt:FindFirstChild("generatorbb")
                        if namegui then
                            local label = namegui:FindFirstChild("label")
                            if label then
                                if not namegui.Enabled then namegui.Enabled = true end
                                label.Text = "Fake generator"

                                if prgs.Value == 100 then
                                    label.TextColor3 = Color3.fromRGB(0, 255, 0)
                                else
                                    label.TextColor3 = espcolors["FakeGenerators"]
                                end
                            end
                        end
                    end
                end
            end)
            hl.Parent = item

            item.ChildAdded:Connect(function(child)
                if child:IsA("Highlight") and child.Name ~= "HL" then child:Destroy() end
            end)
        end
    elseif category == "Items" then
        local root = item:FindFirstChild("ItemRoot")
        if root == nil then return end

        if not root:FindFirstChild("itemesp") then
            local gui = Instance.new("BillboardGui")
            gui.Name = "itemesp"
            gui.Size = UDim2.new(0, 150, 0, 30)
            gui.StudsOffset = Vector3.new(0, 2, 0)
            gui.AlwaysOnTop = true
            gui.Parent = root

            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.Roboto
            label.TextColor3 = espcolors["Items"]
            label.TextStrokeTransparency = 0
            label.TextSize = 10
            label.TextScaled = false
            label.Text = ""
            label.Parent = gui
        end

        if not item:FindFirstChild("HL") then
            local hl = Instance.new("Highlight")
            hl.Enabled = false
            hl.Name = "HL"
            hl.FillColor = espcolors["Items"]
            hl.OutlineColor = espcolors["Items"]
            hl.FillTransparency = esptpn
            hl.OutlineTransparency = esptpn - 0.15
            hl.Parent = item

            table.insert(itemhls, hl)

            task.spawn(function()
                while task.wait(0.1) do 
                    if not togglenormalesp then
                        hl.Enabled = false
                    else
                        hl.Enabled = true
                    end
                end
            end)
        end

        task.spawn(function()
            while task.wait(0.1) do
                if not togglebb or not togglenormalesp then
                    local bb = root:FindFirstChild("itemesp")
                    if bb and bb.Enabled then bb.Enabled = false end
                else
                    local namegui = root:FindFirstChild("itemesp")
                    if namegui then
                        local label = namegui:FindFirstChild("label")
                        if label then
                            if not namegui.Enabled then namegui.Enabled = true end

                            label.Text = item.Name
                            label.TextColor3 = espcolors["Items"]
                        end
                    end
                end
            end
        end)
    elseif category == "Rituals" then
        if not item:FindFirstChild("spawnesppart") then
            local part = Instance.new("Part")
            part.Name = "spawnesppart"
            part.Parent = item
            part.Anchored = true
            part.Position = item.Position
            part.Size = Vector3.new(4, 1, 4)
            part.Transparency = 1
            part.CanCollide = false

            if not part:FindFirstChild("HL") then
                local hl = Instance.new("Highlight")
                hl.Name = "HL"
                hl.Parent = part
                hl.FillColor = espcolors["Rituals"]
                hl.OutlineColor = espcolors["Rituals"]
                hl.FillTransparency = esptpn
                hl.OutlineTransparency = esptpn - 0.15
                table.insert(ritualhls, hl)
                task.spawn(function()
                    while task.wait(0.1) do
                        if togglenormalesp and toggleritualesp then
                            hl.Enabled = true
                            if part ~= nil then part.Transparency = 0 end
                        else
                            hl.Enabled = false
                            if part ~= nil then part.Transparency = 1 end
                        end
                    end
                end)
            end
        end

        local part = item:FindFirstChild("spawnesppart")

        if part ~= nil and not part:FindFirstChild("ritualbb") then
            local bb = Instance.new("BillboardGui")
            bb.Name = "ritualbb"
            bb.Size = UDim2.new(0, 100, 0, 25)
            bb.StudsOffset = Vector3.new(0, 1.5, 0)
            bb.AlwaysOnTop = true
            bb.Parent = part

            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.Roboto
            label.TextColor3 = espcolors["Rituals"]
            label.TextStrokeTransparency = 0
            label.TextSize = 8
            label.TextScaled = false
            label.Text = "Ritual"
            label.Parent = bb
        end
        
        task.spawn(function()
            while task.wait(0.1) do
                if not togglebb or not toggleritualesp or not togglenormalesp then
                    local part = item:FindFirstChild("spawnesppart")
                    if part ~= nil then
                        local bb = part:FindFirstChild("ritualbb")
                        bb.Enabled = false
                    end
                else
                    local part = item:FindFirstChild("spawnesppart")
                    if part ~= nil then
                        local bb = part:FindFirstChild("ritualbb")
                        if bb == nil then continue end

                        local label = bb:FindFirstChild("label")
                        if label ~= nil then
                            if not namegui.Enabled then namegui.Enabled = true end
                            label.Text = " Tt Ritual"

                            label.TextColor3 = espcolors["Rituals"]
                        end
                    end
                end
            end
        end)
    elseif category == "Minions" then
        local hrp = item:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if not item:FindFirstChild("HL") then
            local hl = Instance.new("Highlight")
            hl.Enabled = false
            hl.Name = "HL"
            hl.FillColor = espcolors["Minions"]
            hl.OutlineColor = espcolors["Minions"]
            hl.FillTransparency = esptpn
            hl.OutlineTransparency = esptpn - 0.15
            table.insert(minionshls, hl)

            task.spawn(function()
                while task.wait(0.1) do
                    if togglenormalesp and toggleminionsesp then
                        hl.Enabled = true
                    else
                        hl.Enabled = false
                    end
                end
            end)

            hl.Parent = item
        end

        if not hrp:FindFirstChild("minionesp") then
            local namegui = Instance.new("BillboardGui")
            namegui.Name = "minionesp"
            namegui.Size = UDim2.new(0, 200, 0, 30)
            namegui.StudsOffset = Vector3.new(0, 3, 0)
            namegui.AlwaysOnTop = true
            namegui.Parent = hrp

            local textlabel = Instance.new("TextLabel")
            textlabel.Name = "label"
            textlabel.BackgroundTransparency = 1
            textlabel.Size = UDim2.new(1, 0, 1, 0)
            textlabel.Font = Enum.Font.Roboto
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 10
            textlabel.TextScaled = false
            textlabel.Text = ""
            textlabel.Parent = namegui
        end

        task.spawn(function()
            while task.wait(0.1) do
                if not togglebb or not toggleminionsesp or not togglenormalesp then
                    local bb = hrp:FindFirstChild("minionesp")
                    if bb and bb.Enabled then bb.Enabled = false end
                else
                    if not item:FindFirstChild("Humanoid") then continue end

                    local namegui = hrp:FindFirstChild("minionesp")
                    if namegui then
                        local label = namegui:FindFirstChild("label")
                        if label then
                            if not namegui.Enabled then namegui.Enabled = true end

                            label.Text = "Minion"
                            label.TextColor3 = espcolors["Minions"]
                        end
                    end
                end
            end
        end)
    elseif category == "Footprint" then
        for _, foot in pairs(item:GetChildren()) do
            if foot:IsA("Part") and foot.Name:find("Shadow") and not foot:FindFirstChild("footpart") then
                local part = Instance.new("Part")
                part.Name = "footpart"
                part.Parent = foot
                part.Size = Vector3.new(15, 1, 15)
                part.Anchored = true
                part.CanCollide = false

                if not part:FindFirstChildOfClass("Highlight") then
                    local hl = Instance.new("Highlight")
                    hl.Enabled = false
                    hl.Name = "HL"
                    hl.FillColor = espcolors["Foots"]
                    hl.OutlineColor = espcolors["Foots"]
                    hl.FillTransparency = esptpn
                    hl.OutlineTransparency = esptpn - 0.15
                    
                    task.spawn(function()
                        while task.wait(0.1) do
                            part.CFrame = foot.CFrame
                            part.Rotation = Vector3.new(0, 0, 0)
                            if togglenormalesp and togglefootesp then
                                hl.Enabled = true
                                part.Transparency = 0
                            else
                                hl.Enabled = false
                                part.Transparency = 1
                            end
                        end
                    end)

                    hl.Parent = part
                end
            end
            local part = foot:FindFirstChild("footpart")

            if part ~= nil and not part:FindFirstChild("footesp") then
                local namegui = Instance.new("BillboardGui")
                namegui.Name = "footesp"
                namegui.Size = UDim2.new(0, 200, 0, 30)
                namegui.StudsOffset = Vector3.new(0, 4, 0)
                namegui.AlwaysOnTop = true
                namegui.Parent = part

                local textlabel = Instance.new("TextLabel")
                textlabel.Name = "label"
                textlabel.BackgroundTransparency = 1
                textlabel.Size = UDim2.new(1, 0, 1, 0)
                textlabel.Font = Enum.Font.Roboto
                textlabel.TextColor3 = Color3.new(1, 1, 1)
                textlabel.TextStrokeTransparency = 0
                textlabel.TextSize = 12
                textlabel.TextScaled = false
                textlabel.Text = "Footprint"
                textlabel.Parent = namegui
            end

            task.spawn(function()
                while task.wait(0.1) do
                    if not togglefootesp or not togglenormalesp or not togglebb or not foot.Name:find("Shadow") then
                        local part = foot:FindFirstChild("footpart")
                        if part == nil then continue end

                        local namegui = part:FindFirstChild("footesp")
                        if namegui and namegui.Enabled then namegui.Enabled = false end
                    else
                        local part = foot:FindFirstChild("footpart")
                        local namegui = part:FindFirstChild("footesp")
                        if part ~= nil and namegui then
                            local label = namegui:FindFirstChild("label")
                            if label then
                                if not namegui.Enabled then namegui.Enabled = true end
                                
                                label.Text = "Footprint"
                                label.TextColor3 = espcolors["Foots"]
                            end
                        end
                    end
                end
            end)
        end
    end
end

local function clearesp()
    currentmap = nil
    currentkiller = nil
    generators = {}
    generatorhls = {}
    fakegenshls = {}
    itemhls = {}
    footshls = {}
    minionshls = {}
    ritualhls = {}
    allbbs = {}
    allhls = {}
end

local function checkhls(item)
    if item.Name:find("RespawnLocation") then
        createesps(item, "Rituals")
    elseif item.Name:find("PizzaDelivery") or 
        item.Name:find("Zombie") or 
        item.Name:find("PizzaDelivery") or 
        item.Name == "Builderman" or 
        item.Name == "ChancecORRUPT" or 
        item.Name == "Elliot" or 
        item.Name == "ShedletskyCORRUPT" or 
        item.Name == "BlueGuy" or 
        item.Name == "GreenGuy" or 
        item.Name == "PurpleGuy" or 
        item.Name == "RedGuy" or 
        item.Name:find("Mafia2") or 
        item.Name:find("Mafia1") or 
        item.Name:find("Mafia3") or 
        item.Name:find("Mafia4") then

        createesps(item, "Minions")
    elseif item:IsA("Folder") and item.Name:find("Shadows") then
        createesps(item, "Footprint")
    end
end

currentkiller = kill:FindFirstChildOfClass("Model")

local function getall(map)
    clearesp()
    task.wait(0.5)
    currentkiller = kill:FindFirstChildOfClass("Model")
    currentmap = map
    task.spawn(function()
        for _, killer in pairs(kill:GetChildren()) do
            if killer == lp.Character then continue end
            task.spawn(function()
                createplayeresp(killer, "Killers")

                while task.wait(0.5) do
                    if not killer:FindFirstChild("HL") then
                        createplayeresp(killer, "Killers")
                    end
                end
            end)
            task.spawn(function()
                game.workspace.Players.Killers.ChildAdded:Connect(function(model)
                    if model ~= currentkiller then
                        local hrp = model:FindFirstChild("HumanoidRootPart")

                        if hrp then
                            local bb = model:FindFirstChild("HumanoidRootPart"):FindFirstChild("nameesp")
                            if bb ~= nil then bb:Destroy() end
                            local bb = model:FindFirstChild("HumanoidRootPart"):FindFirstChild("healthesp")
                            if bb ~= nil then bb:Destroy() end
                        end
                        local hl = model:FindFirstChild("HL")
                        if hl ~= nil then hl:Destroy() end
                    end
                end)
            end)
        end
    end)
    task.spawn(function()
        for _, survivor in pairs(surv:GetChildren()) do
            if survivor == lp.Character then continue end
            task.spawn(function()
                createplayeresp(survivor, "Survivors")

                while task.wait(0.5) do
                    if not survivor:FindFirstChild("HL") then
                        createplayeresp(survivor, "Survivors")
                    end
                end
            end)
        end
    end)
    wait(0.5)
    task.spawn(function()
        for _, gen in pairs(map:GetChildren()) do
            if gen.Name == "Generator" then
                createesps(gen, "Generators")
            elseif gen.Name == "FakeGenerator" then
                createesps(gen, "FakeGenerators")
            end
        end
    end)
    wait(0.5)
    task.spawn(function()
        for _, item in pairs(ingamefolder:GetDescendants()) do
            if item:IsA("Tool") then
                createesps(item, "Items")
            end
        end
    end)
end

ingamefolder.ChildAdded:Connect(function(child)
    if child.Name == "Map" then
        getall(child)
    else
        checkhls(child)
    end
end)

ingamefolder.ChildRemoved:Connect(function(child)
    if child.Name == "Map" then
        clearesp()
    end
end)

task.spawn(function()
    if ingamefolder:FindFirstChild("Map") then
        getall(ingamefolder.Map)
    end
end)

rgdl.ChildAdded:Connect(function(killed)
    if not killed:IsA("Model") then return end

    local head = killed:FindFirstChild("Head")
    local hrp = killed:FindFirstChild("HumanoidRootPart")

    local hl = killed:FindFirstChildOfClass("Highlight")
    if hl then hl:Destroy() end

    if hrp ~= nil then
        local bb = hrp:FindFirstChildOfClass("BillboardGui")
        if bb then bb:Destroy() end

        local bb2 = hrp:FindFirstChildOfClass("BillboardGui")
        if bb2 then bb2:Destroy() end
    end
end)

print("loaded ESP")

local suc, err = pcall(function()
    local stamina = require(Sprinting)
end)

local cframecon
cframecon = run.RenderStepped:Connect(function(dt)
    if togglecf then
        local hum = lp.Character:WaitForChild("Humanoid", 5)
        local hrp = lp.Character:WaitForChild("HumanoidRootPart", 5)

        local speed
        if adaprivecf then
            speed = hum.WalkSpeed * ((tonumber(cfmultiplier) or 1) / 2)
        else
            speed = cfspeed
        end

        hrp.CFrame = hrp.CFrame + hum.MoveDirection * speed * dt
    end
end)

lp.CharacterAdded:Connect(function()
    if cframecon then cframecon:Disconnect() cframecon = nil end

    cframecon = run.RenderStepped:Connect(function(dt)
        if togglecf then
            local hum = lp.Character:WaitForChild("Humanoid", 5)
            local hrp = lp.Character:WaitForChild("HumanoidRootPart", 5)

            local speed
            if adaprivecf then
                speed = hum.WalkSpeed * (tonumber(cfmultiplier) / 2)
            else
                speed = cfspeed
            end

            hrp.CFrame = hrp.CFrame + hum.MoveDirection * speed * dt
        end
    end)
end)


if suc then
    local stamina = require(Sprinting)
    run.Heartbeat:Connect(function()
        pcall(function()
            if not lp.Character.Parent then return end
            if lp.Character.Parent.Name == "Killers" then
                if ms then
                    stamina.MaxStamina = tonumber(ms)
                end
                if num2 then
                    stamina.MinStamina = tonumber(num2)
                end
                if num3 then
                    stamina.StaminaGain = tonumber(num3)
                end
                if ssk then
                    stamina.SprintSpeed = tonumber(ssk)
                end
                if num4 then
                    stamina.StaminaLoss = tonumber(num4)
                end
                if num6 then
                    stamina.StaminaLoss = 0
                end
            else
                if num1 then
                    stamina.MaxStamina = tonumber(num1)
                end
                if num2 then
                    stamina.MinStamina = tonumber(num2)
                end
                if num3 then
                    stamina.StaminaGain = tonumber(num3)
                end
                if num4 then
                    stamina.StaminaLoss = tonumber(num4)
                end
                if num5 then
                    stamina.SprintSpeed = tonumber(num5)
                end
                if num5 then
                    stamina.StaminaLossDisabled = num6
                end
            end
        end)
    end)
end

print("loaded Stamina")

-- misc
-- Invisibility:
local function invisible(state)
    local humanoid = lp.Character.Humanoid
    if humanoid then
        if not state then
            invis:Stop()
            invis:Destroy()
            invis = nil
            return
        end
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://75804462760596"

        invis = humanoid:LoadAnimation(animation)
        invis:Play()
        invis:AdjustSpeed(0)
        local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Transparency = 0.8 end
    end
end

task.spawn(function()
    while task.wait(0.25) do
        if toggleinvis then
            if toggleinviswhensurv then
                if lp.Character.Parent.Name == "Survivors" and not invis then
                    invisible(true)
                elseif lp.Character.Parent.Name ~= "Spectating" and lp.Character.Parent.Name ~= "Survivors" and invis then
                    invisible(false)
                end
            else
                if lp.Character.Parent.Name ~= "Spectating" and not invis then
                    invisible(true)
                elseif lp.Character.Parent.Name == "Spectating" and invis then
                    invisible(false)
                end
            end
        elseif invis then
            invisible(false)
        end
    end
end)

print("loaded Invisibility")

-- God mode:
local sucm, err = pcall(function()
    local stamina = require(Sprinting)
end)

if sucm then
    local gm = getrawmetatable(game)
    local oldnamecall = gm.__namecall
    local remote = game:GetService("ReplicatedStorage").Modules.Network.Network.UnreliableRemoteEvent
    setreadonly(gm, false)

    gm.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if not checkcaller() and method == "FireServer" and self == remote and toggledesync then
            return
        end
        
        return oldnamecall(self, ...)
    end)

    setreadonly(gm, true)

    lp.CharacterAdded:Connect(function()
        task.wait(1)
        if lp.Character.Parent.Name ~= "Spectating" then
            if godmode then
                toggledesync = false

                task.wait(8)

                local hrp = lp.Character:WaitForChild("HumanoidRootPart")

                local last = hrp.CFrame
                hrp.CFrame = CFrame.new(0, 100, 0)

                task.wait(0.2)
                toggledesync = true
                task.wait(0.1)

                hrp.CFrame = last
            else
                toggledesync = false
            end

            local function checkifnear()
                local hitbox = lp.Character:FindFirstChild("QueryHitbox")
                if not hitbox then return false end

                local distance = (hitbox.Position - Vector3.new(0, 100, 0)).Magnitude
                if distance > 50 then
                    toggledesync = false

                    task.wait(2)

                    local hrp = lp.Character:WaitForChild("HumanoidRootPart")

                    local last = hrp.CFrame
                    hrp.CFrame = CFrame.new(0, 100, 0)

                    task.wait(0.2)
                    toggledesync = true
                    task.wait(0.1)

                    hrp.CFrame = last
                end
                return true
            end

            task.spawn(function()
                while task.wait(0.1) do
                    if not godmode then repeat task.wait(0.1) until godmode end
                    local a = checkifnear()
                    if not a then task.wait(5) end
                end
            end)
        end
    end)
end

print("loaded God mode")

-- Chat visibility:
textchat.ChatWindowConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function()
    if chatvisibility then
        textchat.ChatWindowConfiguration.Enabled = true
    end
end)

print("loaded chat")

-- Walk through killer only walls:
local function walkthroughkillerwalls(folder)
    if togglewalktroughkilleronly then
        for _, wall in pairs(folder:GetDescendants()) do
            if wall:IsA("BasePart") then  
                if wall.CanCollide then
                    wall.CanCollide = false
                end
            end
        end
    end
end

ingamefolder.ChildAdded:Connect(function(map)
    if map.Name == "Map" then
        task.wait(3)
        local killerswalls = map:FindFirstChild("Obstacles")
        if killerswalls then
            walkthroughkillerwalls(killerswalls)
        end
        killerswalls =  map:FindFirstChild("KillerOnlyEntrances")
        if killerswalls then
            walkthroughkillerwalls(killerswalls)
        end
        killerswalls =  map:FindFirstChild("Killer_Only Wall")
        if killerswalls then
            walkthroughkillerwalls(killerswalls)
        end
		if map:FindFirstChild("MapBoundaries") and map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerDoors") then
			killerswalls = map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerDoors")
			if killerswalls then
				walkthroughkillerwalls(killerswalls)
			end
		end
		if map:FindFirstChild("MapBoundaries") and map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerOnly") then
			killerswalls = map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerOnly")
			if killerswalls then
				walkthroughkillerwalls(killerswalls)
			end
		end
    end
end)

-- Custom jump power:
task.spawn(function()
    while task.wait(0.5) do
        local humanoid = lp.Character:WaitForChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = customjumppower
        end
    end
end)

-- Loop fb:
local function loopfb()
    task.spawn(function()
        while task.wait(0.5) do
            local Lighting = game:GetService("Lighting")
            local atmosphere = Lighting:FindFirstChild("Atmosphere") or Lighting:FindFirstChild("Atmosphere1") or nil
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.ShadowSoftness = 0
            Lighting.GlobalShadows = false
            if atmosphere ~= nil then atmosphere:Destroy() end
        end
    end)
end

-- Chance auto-coin flip:
task.spawn(function()
	while task.wait(0.1) do
		repeat task.wait(0.1) until playergui.MainUI:FindFirstChild("AbilityContainer") and playergui.MainUI.AbilityContainer:FindFirstChild("CoinFlip")

		local reroll = playergui.MainUI.AbilityContainer:WaitForChild("Reroll")
		if reroll:WaitForChild("Charges").Text == "" and flipcoin then
			reroll:WaitForChild("Charges").Text = "0"
		end
		if tonumber(reroll:WaitForChild("Charges").Text) < tonumber(charges) and flipcoin then
			mainremote:FireServer("UseActorAbility", {
                [1] = "CoinFlip"
            })
			task.wait(1.8)
		end
	end
end)

print("loaded alot")

-- Protect names:
local function randomtext()
    local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
    local length = math.random(5, 12)
    local result = ""

    for i = 1, length do
        local randIndex = math.random(1, #characters)
        result = result .. characters:sub(randIndex, randIndex)
    end

    return result
end

local function NameProtect(state)
    if #NameProtecting == 0 then
        return
    end

	local function updateNames()
		local CurrentSurvivors = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
			and game:GetService("Players").LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("PlayerInfo")
			and game:GetService("Players").LocalPlayer.PlayerGui.TemporaryUI.PlayerInfo
				:FindFirstChild("CurrentSurvivors")
		if CurrentSurvivors then
			local indices = {}
			for index in pairs(NameProtecting) do
				table.insert(indices, index)
			end
			for i = #indices, 2, -1 do
				local j = math.random(i)
				indices[i], indices[j] = indices[j], indices[i]
			end
			for _, People in pairs(CurrentSurvivors:GetChildren()) do
				if People:IsA("Frame") then
					local name
					local success = false
					local maxTries = 10
                    local tries = 0
                    repeat
                        tries += 1
                    	name = NameProtecting[indices[math.random(#indices)]]
                    	local asset = LoadAsset(name .. ".Sigma")
                    	if asset then
                    		People.Icon.Image = asset
                    		success = true
                    	end
                    until success or tries >= maxTries
                    if not success then
                    	People.Icon.Image = LoadAsset("UltraSigma.png.Sigma")
                    end
					People.Username.Text = (name:gsub(".png", ""))
				end
			end
		end
	end

	if state then
		local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        local KillerIntro

		local function setupConnections()
			local TemporaryUI = PlayerGui:WaitForChild("TemporaryUI", math.huge)
			local PlayerInfo = TemporaryUI:WaitForChild("PlayerInfo", math.huge)

			PlayerGui.ChildAdded:Connect(function(child)
				if child.Name == "TemporaryUI" then
					updateNames()
				end
			end)
			TemporaryUI.ChildAdded:Connect(function(child)
				if child.Name == "PlayerInfo" then
					updateNames()
				end
			end)
			PlayerInfo.ChildAdded:Connect(function(child)
				if child.Name == "CurrentSurvivors" then
					updateNames()
				end
			end)

            game:GetService("Players").LocalPlayer.PlayerGui.TemporaryUI.ChildAdded:Connect(function(child)
                if not child:IsA("ImageLabel") then return end

                local info = child:FindFirstChild("BasicInfo")
                if not info then return end

                local randomtext = randomtext()

                local playername = info:FindFirstChild("PlayerName")
                local playerusername = info:FindFirstChild("PlayerUsername")

                if playername then
                    playername.Text = randomtext
                end
                if playerusername then
                    playerusername.Text = "@" .. randomtext
                end
            end)
		end

        task.spawn(function()
            while true do
                task.wait(0.1)
                local killerintro = PlayerGui:FindFirstChild("KillerIntroUI")

                if not killerintro then continue end

                local function sigma()
                    for _, killerint in ipairs(killerintro:GetChildren()) do
                        if killerint.Name:lower():find("killer") then return true end
                    end
                end
                repeat task.wait() until sigma()

                local function finduser()
                    for _, killerint in ipairs(killerintro:GetChildren()) do
                        if killerint.Name:lower():find("killer") then 
                            local displays = killerint:FindFirstChild("Displays")
                            if displays then
                                local display = displays:FindFirstChild("Display")
                                if display then
                                    local playername = display:FindFirstChild("PlayerName")
                                    if playername then
                                        return playername
                                    end
                                end
                            end
                        end
                    end
                end

                local username = finduser()

                repeat
                    username = finduser()
                    task.wait() 
                until username or not sigma()

                if username then
                    username.Text = "(" .. randomtext() .. ")"
                end

                repeat task.wait() until not sigma() or not finduser()
            end
        end)

        task.spawn(function()
            while true do
                repeat task.wait() until PlayerGui:FindFirstChild("EndScreen")
                local endscreen = PlayerGui:FindFirstChild("EndScreen")
                
                local checker = endscreen:FindFirstChild("WinnerTitle")
                if not checker then continue end

                local checker2 = checker:FindFirstChild("Usernames")
                if not checker2 then continue end

                local sigmas = checker2.Text
                local totalsigmausers = 0

                for sigmauser in string.gmatch(sigmas, "[^,]+") do
                    totalsigmausers += 1
                end

                if totalsigmausers == 1 then 
                    checker2.Text = randomtext() .. "." 
                end
                if totalsigmausers == 2 then 
                    checker2.Text = randomtext() .. ", " .. randomtext() .. "." 
                end
                if totalsigmausers == 3 then 
                    checker2.Text = randomtext() .. ", " .. randomtext() .. ", " .. randomtext() .. "." 
                end
                if totalsigmausers == 4 then 
                    checker2.Text = randomtext() .. ", " .. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. "." 
                end
                if totalsigmausers == 5 then 
                    checker2.Text = randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. "." 
                end
                if totalsigmausers == 6 then 
                    checker2.Text = randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. "." 
                end
                if totalsigmausers == 7 then 
                    checker2.Text = randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. "." 
                end
                if totalsigmausers == 8 then 
                    checker2.Text = randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. ", ".. randomtext() .. "." 
                end

                local stats = endscreen:FindFirstChild("Main"):FindFirstChild("PlayerStats")
                if not stats then continue end

                local dropdown = stats:FindFirstChild("Header"):FindFirstChild("PlayerDropdown"):FindFirstChild("DropdownFrame")
                local choosenvalue = dropdown:FindFirstChild("ChosenValue"):FindFirstChild("Title")

                choosenvalue.Text = randomtext()

                task.spawn(function()
                    local options = dropdown:FindFirstChild("Options")
                    options.ChildAdded:Connect(function(sigmavariant)
                        if not sigmavariant:IsA("ImageButton") then return end

                        local titlename = sigmavariant:FindFirstChild("Title")
                        titlename.Text = randomtext()
                    end)
                end)

                repeat task.wait() until not PlayerGui:FindFirstChild("EndScreen")
            end
        end)

        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            end
            player.CharacterAdded:Connect(function(character)
                local humanoid = character:WaitForChild("Humanoid", 5)
                if humanoid then
                    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            end)
        end


		setupConnections()
		updateNames()

		if PlayerGui.MainUI.PlayerListHolder then
			for _, player in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.PlayerListHolder.Contents.Players:GetChildren()) do
                if not player:IsA("Frame") then continue end
                local playerusername = player:WaitForChild("PlayerInfo", 10):WaitForChild("Username", 10)

                if playerusername ~= nil then
                    playerusername.Text = randomtext()
                end
            end
            PlayerGui.MainUI.PlayerListHolder.Contents.Players.ChildAdded:Connect(function(player)
                if not player:IsA("Frame") then return end
                local playerusername = player:WaitForChild("PlayerInfo", 10):WaitForChild("Username", 10)

                if playerusername ~= nil then
                    playerusername.Text = randomtext()
                end
            end)
        end
        task.spawn(function()
            while true do
                task.wait(1)
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player.Character then
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        end
                    end
                    player.CharacterAdded:Connect(function(character)
                        local humanoid = character:WaitForChild("Humanoid", 5)
                        if humanoid then
                            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        end
                    end)
                end
            end
        end)
		if PlayerGui.MainUI.Spectate.Username then
			PlayerGui.MainUI.Spectate.Username.Visible = false
		end
	end
end

local function startchangedevice()
    while task.wait(1) do
        if device == "Disable" or curdevice == device then continue end

        mainremote:FireServer("SetDevice", {
            [1] = tostring(device)
        })
        curdevice = device
    end
end

local function tleporttoitem(itemroot, prompt)
    local hrp = lp.Character.HumanoidRootPart
    local startpos = hrp.CFrame
    
    hrp.CFrame = itemroot.CFrame * CFrame.new(0, 2, -2.5)
    task.wait(0.2)
    fireproximityprompt(prompt)
    task.wait(0.2)
    hrp.CFrame = startpos
end

ingamefolder.ChildAdded:Connect(function(map)
    if not map.Name == "Map" then return end
    task.wait(5)
    if lp.Character.Parent.Name ~= "Survivors" then return end
    local teleportedmed = false
    local teleportedbloxy = false
    for _, item in pairs(map:GetChildren()) do
        if item:IsA("Tool") and {item.Name == "BloxyCola" or item.Name == "Medkit"} then
            if item.Name == "BloxyCola" and not teleportedbloxy and autopickupbloxy then
                teleportedbloxy = true
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                task.wait(0.1)
            elseif item.Name == "Medkit" and not teleportedmed and autopickupmedkit then
                teleportedmed = true
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                task.wait(0.1)
            end
        end
    end
end)

-- Auto eat pizza:
task.spawn(function()
    while task.wait(0.2) do
        local hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    	local ingame = workspace.Map.Ingame
    
    	local pizza = ingame:FindFirstChild("Pizza")
    	if pizza ~= nil and pizza:IsA("Part") and lp.Character.Name == "Survivors" then
    	    if not instanteatpizza and makepizzabigger then
    		local size = Vector3.new(
    			tonumber(pizzasize),
    			tonumber(pizzasize),
    			tonumber(pizzasize)
    		)
    		pizza.Size = size
    		elseif instanteatpizza then
    		    pizza.CFrame = hrp.CFrame
    		    pizza.Anchored = true
    		end
    	end
	end
end)

-- Some anti stff:
local function setupantistun(character)
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    local slowfolder = character:WaitForChild("SpeedMultipliers", 5)
    local fovfolder = character:WaitForChild("FOVMultipliers", 5)

    if not hrp or not slowfolder then return end

    if unstunconn then unstunconn:Disconnect() end
    unstunconn = hrp:GetPropertyChangedSignal("Anchored"):Connect(function()
        if disableslowness and hrp.Anchored then
            hrp.Anchored = false
        end
    end)
    
    if fovconn then fovconn:Disconnect() end
    fovconn = fovfolder.DescendantAdded:Connect(function(effect)
        if disablefovmodf and effect.Name ~= "FOVSetting" and effect.Name ~= "Sprinting" then
            effect:Destroy()
        end
    end)
    
    if stunconn then stunconn:Disconnect() end
    stunconn = slowfolder.ChildAdded:Connect(function(effect)
        local slow = slowfolder:FindFirstChild("SlowedStatus")
        if slow and disableslowness then slow:Destroy() end
        if disableslowness and effect.Name ~= "Sprinting" and effect.Name ~= "ENRAGED" and effect.Name ~= "FixingGenerator" and effect.Name ~= "Guest1337Charge" and effect.Name ~= "SpeedStatus" then
            effect:Destroy()
        end
    end)
end

task.spawn(function()
    if lp.Character then
        setupantistun(lp.Character)
    end

    lp.CharacterAdded:Connect(function(character)
        setupantistun(character)
    end)

    ingamefolder.ChildAdded:Connect(function(spike)
        if spike:IsA("Model") and deletejohntoespikes and spike.Name == "Spike" then
            task.wait(0.5)
            spike:Destroy()
        end
    end)

    while true do
        task.wait(0.1)
        local blindfolder = game:GetService("Lighting"):FindFirstChild("BlindnessBlur") or game:GetService("Lighting"):FindFirstChild("SubspaceVFXColorCorrection") or game:GetService("Lighting"):FindFirstChild("SubspaceVFXBlur")
        if blindfolder and disableblind then blindfolder:Destroy() end
    end
end)

local function enablenoclip()
    togglenoclip = true
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    while togglenoclip do
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
        task.wait(0.2)
    end
end

local function disablenoclip()
    togglenoclip = false
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and not part.CanCollide and part.Name ~= "QueryHitbox" and part.Name ~= "CollisionHitbox" and part.Name ~= "Left Arm" and part.Name ~= "Right Arm" and part.Name ~= "Right Leg" and part.Name ~= "Left Leg" then
            part.CanCollide = true
        end
    end
end

task.spawn(function()
	while true do
		repeat task.wait(1) until togglenoclip and game.workspace.Map.Ingame:FindFirstChild("Map")
            
        task.wait(5)

        enablenoclip()
        
		repeat 
		    task.wait(0.5)
		    until not togglenoclip or not game.workspace.Map.Ingame:FindFirstChild("Map")

		if not togglenoclip then
		    disablenoclip()
		else
		    enablenoclip()
		end
	end
end)

print("loaded misc")

-- Jane doe insta charge:
local sucs, er = pcall(function()
	require(Sprinting)
end)

if sucs then
	local gm = getrawmetatable(game)
	local oldnamecall = gm.__namecall
	setreadonly(gm, false)
	gm.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = {...}
		
		if crystalchrg and not checkcaller() and method == "FireServer" and tostring(args[1]):find("CrystalInput") and self == mainremote then
			args[2][1] = 1
			return oldnamecall(self, unpack(args))
		end
		
		return oldnamecall(self, ...)
	end)

	setreadonly(gm, true)
end

-- No veeronica dmg:
local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

if suc then
	local gm = getrawmetatable(game)
	local oldnamecall = gm.__namecall
	setreadonly(gm, false)
	gm.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = {...}
		
		if self == mainremote and 
		method:lower() == "fireserver" and args[1]:lower():find("stopskate") and 
		noveedmg then
			args[2][1] = buffer.fromstring("\x03\x06\x00\x00\x00Manual")
			return oldnamecall(self, unpack(args))
		end
		
		return oldnamecall(self, ...)
	end)

	setreadonly(gm, true)

	local old = require(game:GetService("ReplicatedStorage").Assets.Survivors.Veeronica.Behavior).Abilities.Sk8.Callback

	task.spawn(function()
		while task.wait(0.05) do
			if plsj then
				local vim = game:GetService("VirtualInputManager")
				vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
				task.wait(0.05)
				vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
			end
		end
	end)

	require(game:GetService("ReplicatedStorage").Assets.Survivors.Veeronica.Behavior).Abilities.Sk8.Callback = function(x, z)

		x.Config.Sk8TurnControl = veecontrol
		x.Config.Sk8Speed = 1.15 * customskatespeed
		x.Config.Sk8TrickPower = 75 * customtrickpower
		x.Config.Sk8TrickJump = 0.45 * customtrickjpower
		x.Config.Sk8TrickCooldown = customtrickcooldown
		if noskateloss then
			x.Config.Sk8StaminaLoss = 0
			x.Config.Sk8StaminaLossOut = 0
			x.Config.Sk8StaminaLossOutNerfed = 0
		end

		if veenopaint then
			z = "SPRAY"
		end

		veecfg.cfg = x

		veecfg.updateveecfg = function()
			veecfg.cfg = x
		end

		veecfg.updatecfg = function()
			x = veecfg.cfg
		end

		veecfg.getcfg = function()
			return x
		end

		local bec = game:GetService("ReplicatedStorage").Assets.Survivors.Veeronica.Behavior
		bec.ChildAdded:Connect(function(l)
			if l:IsA("Highlight") then
				local co
				local start = tick()
				co = l:GetPropertyChangedSignal("Adornee"):Connect(function()
					if l and bec:FindFirstChildWhichIsA("Highlight") and 
					not gcd and l.Adornee == lp.Character and 
					l.FillColor == x.Config.Sk8TrickHighlightData.TrickReady.FillColor and 
					autoveetrick then
						gcd = true

						plsj = true
						task.wait(0.02)
						plsj = false

						task.delay(0.25, function()
							gcd = false
						end)
					elseif not bec:FindFirstChildWhichIsA("Highlight") then
						co:Disconnect()
						co = nil
						return
					end
				end)
			end
		end)

		return old(x, z)
	end
end

-- Auto-nosferatu minigame:
playergui.TemporaryUI.ChildAdded:Connect(function(g)
    run.RenderStepped:Wait()
    run.RenderStepped:Wait()
    run.RenderStepped:Wait()
    if g.Name ~= "QTE" or not togglenmg or not currentkiller then return end

	repeat
		task.wait(tonumber(ibmg) + (math.random() * tonumber(ibmgr)))
		mainremote:FireServer(
			("%*NosHookQTE"):format(currentkiller:GetAttribute("Username")),
			{
				buffer.fromstring("\x01\x01")
			}
		)
	until not g or not togglenmg
end)

-- Auto-block:
local function addpartlmao(killerhrp)
    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 8, hitboxsize)
    part.CFrame = killerhrp.CFrame * CFrame.new(0, 0, (hitboxsize / 2) * -1)
    part.Color = customautoblockhitboxcolor
    part.Transparency = 0
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.Material = Enum.Material.ForceField
    part.Parent = killerhrp

    autoblockpart = part
end

kill.ChildAdded:Connect(function(killer)
    task.wait(1)
    if killer == currentkiller and lp.Character.Parent.Name ~= "Killers" then
        local hrp = killer:WaitForChild("HumanoidRootPart")
        addpartlmao(hrp)
    end
end)

run.Heartbeat:Connect(function()
    if autoblockpart and autoblockpart.Parent and currentkiller and currentkiller:FindFirstChild("HumanoidRootPart") then
        autoblockpart.CFrame = currentkiller.HumanoidRootPart.CFrame * CFrame.new(0, 0, (hitboxsize / 2) * -1)
        autoblockpart.Size = Vector3.new(10, 8, hitboxsize)
        autoblockpart.Color = customautoblockhitboxcolor
        if not visiblehitbox then
            autoblockpart.Transparency = 1
        else
            autoblockpart.Transparency = 0
        end
    end
end)

local function extractsoundid(sound)
    if not sound or not sound.SoundId then return nil end
    local sid = tostring(sound.SoundId)

    local num = sid:match("%d+")
    if num then return num end

    local hash = sid:match("[&%?]hash=([^&]+)")
    if hash then return "&hash="..hash end
    local path = sid:match("rbxasset://sounds/.+")
    if path then return path end

    return nil
end

local abparttt = Instance.new("Part")
abparttt.CanCollide = false
abparttt.Size = lp.Character.HumanoidRootPart.Size
abparttt.Anchored = true
abparttt.Transparency = 1
abparttt.Parent = workspace

local function soundblock(sound)
    if not toggleautoblock or not lp.Character.Name == "Guest1337" or autocd then return end
    if not sound or not sound:IsA("Sound") then return end
    if not sound.IsPlaying then return end

    local id = extractsoundid(sound)
    if not id or not autoblocktrigers[tostring(id)] then return end

    local can = false
    if (sound.TimePosition / sound.TimeLength) < 0.6 then can = true end

    if not can then return end

    local isinpart = false
    abparttt.CFrame = lp.Character.HumanoidRootPart.CFrame
    for _, v in pairs(workspace:GetPartsInPart(autoblockpart)) do
        if v.Parent == workspace.Hitboxes then continue end
        if v:IsDescendantOf(lp.Character) or v.Parent == lp.Character or v == abparttt then
            isinpart = true
            break
        end
    end

    if not isinpart then return end

    if autocd then return end
    if not autocd then autocd = true end
    
    local punch = playergui.MainUI.AbilityContainer.Punch
    
    if not autoblockconn and autopunch then
        autoblockconn = punch:GetPropertyChangedSignal("ImageColor3"):Connect(function()
            print(punch.ImageColor3)
            task.wait(0.05)
            mainremote:FireServer("UseActorAbility", {
                [1] = "Punch"
            })
            autoblockconn:Disconnect()
            autoblockconn = nil
        end)
    end

    mainremote:FireServer("UseActorAbility", {
        [1] = "Block"
    })

    task.delay(3, function()
        autocd = false
    end)

    task.wait(5)
    if autoblockconn then autoblockconn:Disconnect() end
    autoblockconn = nil
end

run.RenderStepped:Connect(function()
    local currentkiller
    if kill:FindFirstChildWhichIsA("Model") then
        currentkiller = kill:FindFirstChildWhichIsA("Model")
    end
    if not currentkiller or not currentkiller:FindFirstChild("HumanoidRootPart") or lp.Character.Name ~= "Guest1337" or not currentkiller:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("Sound") then return end

    for _, sound in pairs(currentkiller:FindFirstChild("HumanoidRootPart"):GetChildren()) do
        if sound:IsA("Sound") then 
            soundblock(sound)
        end
    end
end)

task.spawn(function()
    task.wait(1)
    if currentkiller then
        pcall(function()
            addpartlmao(currentkiller:WaitForChild("HumanoidRootPart", 10))
        end)
    end
end)

-- Silent aim:
local sc = Instance.new("ScreenGui")
sc.Name = "Crosshair"
sc.ResetOnSpawn = false
sc.Parent = playergui

local f = Instance.new("Frame")
f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f.BackgroundTransparency = 0.4
f.AnchorPoint = Vector2.new(0.5, 0.5)
f.Visible = false
f.Size = UDim2.new(0, 10, 0, 10)
f.Position = UDim2.new(0.5, 0, 0.5, cursorypos * -5)
f.Parent = sc

local u = Instance.new("UICorner")
u.CornerRadius = UDim.new(1, 0)
u.Parent = f

curs = f

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

local function findclosestnpc()
    local mouse = players.LocalPlayer:GetMouse()
	local cursorpos
	if enablecursor then
		local x = curs.AbsolutePosition.X + curs.AbsoluteSize.X / 2
		local y = curs.AbsolutePosition.Y + curs.AbsoluteSize.Y / 2
		local ray = workspace.CurrentCamera:ScreenPointToRay(x, y)

		local p = RaycastParams.new()
		p.FilterDescendantsInstances = {lp.Character}
		p.FilterType = Enum.RaycastFilterType.Blacklist

		local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, p)
		if res and res.Position then
			cursorpos = res.Position
		else
			cursorpos = mouse.Hit.Position
		end
	else
		cursorpos = mouse.Hit.Position
	end
	local mindist = math.huge
	local nearest = nil
    
    for _, survivor in ipairs(workspace.Map.Lobby.NPCs:GetChildren()) do
        if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") and survivor ~= lp.Character then
            local distance = (cursorpos - survivor:FindFirstChild("HumanoidRootPart").Position).Magnitude
            if distance < mindist then
                mindist = distance
                nearest = survivor
            end
        end
    end
    return nearest
end

local function findclosestsurv()
    local mouse = players.LocalPlayer:GetMouse()
	local cursorpos
	if enablecursor then
		local x = curs.AbsolutePosition.X + curs.AbsoluteSize.X / 2
		local y = curs.AbsolutePosition.Y + curs.AbsoluteSize.Y / 2
		local ray = workspace.CurrentCamera:ScreenPointToRay(x, y)

		local p = RaycastParams.new()
		p.FilterDescendantsInstances = {lp.Character}
		p.FilterType = Enum.RaycastFilterType.Blacklist

		local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, p)
		if res and res.Position then
			cursorpos = res.Position
		else
			cursorpos = mouse.Hit.Position
		end
	else
		cursorpos = mouse.Hit.Position
	end
	local mindist = math.huge
	local nearest = nil
    
    for _, survivor in ipairs(surv:GetChildren()) do
        if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") and survivor ~= lp.Character then
            local distance = (cursorpos - survivor:FindFirstChild("HumanoidRootPart").Position).Magnitude
            if distance < mindist then
                mindist = distance
                nearest = survivor
            end
        end
    end
    return nearest
end

local function findclosesttomouse()
	local mouse = players.LocalPlayer:GetMouse()
	local cursorpos
	if enablecursor then
		local x = curs.AbsolutePosition.X + curs.AbsoluteSize.X / 2
		local y = curs.AbsolutePosition.Y + curs.AbsoluteSize.Y / 2
		local ray = workspace.CurrentCamera:ScreenPointToRay(x, y)

		local p = RaycastParams.new()
		p.FilterDescendantsInstances = {lp.Character}
		p.FilterType = Enum.RaycastFilterType.Blacklist

		local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, p)
		if res and res.Position then
			cursorpos = res.Position
		else
			cursorpos = mouse.Hit.Position
		end
	else
		cursorpos = mouse.Hit.Position
	end
	local mindist = math.huge
	local nearest = nil
	
	for _, survivor in pairs(surv:GetChildren()) do
		if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") and survivor ~= lp.Character then
			local distance = (cursorpos - survivor:FindFirstChild("HumanoidRootPart").Position).Magnitude
			if distance < mindist then
				mindist = distance
				nearest = survivor
			end
		end
	end
	for _, survivor in pairs(kill:GetChildren()) do
		if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") and survivor ~= lp.Character then
			local distance = (cursorpos - survivor:FindFirstChild("HumanoidRootPart").Position).Magnitude
			if distance < mindist then
				mindist = distance
				nearest = survivor
			end
		end
	end
	for _, survivor in ipairs(workspace.Map.Lobby.NPCs:GetChildren()) do
        if survivor:IsA("Model") and survivor:FindFirstChild("HumanoidRootPart") and survivor ~= lp.Character then
            local distance = (cursorpos - survivor:FindFirstChild("HumanoidRootPart").Position).Magnitude
            if distance < mindist then
                mindist = distance
                nearest = survivor
            end
        end
    end

	return nearest
end

if suc then 
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
    local mousefunc = mousemodule.GetMousePos

    mousemodule.GetMousePos = function(self, p2)
        if slientaim or killerssilentaim or toggleooblock then
            if mousepos then
                return mousepos
            end
        end

        local mouse = players.LocalPlayer:GetMouse()
		local cursorpos
		if enablecursor then
			local x = curs.AbsolutePosition.X + curs.AbsoluteSize.X / 2
			local y = curs.AbsolutePosition.Y + curs.AbsoluteSize.Y / 2
			local ray = workspace.CurrentCamera:ScreenPointToRay(x, y)

			local p = RaycastParams.new()
			p.FilterDescendantsInstances = {lp.Character, part}
			p.FilterType = Enum.RaycastFilterType.Blacklist

			local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, p)
			part.Position = res.Position
			cursorpos = res.Position
		else
			cursorpos = mousefunc(self, p2)
		end

        return cursorpos
    end

    run.RenderStepped:Connect(function()
        if not slientaim and killerssilentaim then mousepos = nil return end

        local character = lp.Character
        if character then
            if slientaimtype == "Killer" and slientaim and (character.Name == "Dusekkar" or character.Name == "JaneDoe") then
                local killer = kill:FindFirstChildWhichIsA("Model")
                if killer then
                    local part = killer:FindFirstChild("HumanoidRootPart")
                    if part then
                        local velocity = part.AssemblyLinearVelocity or Vector3.zero
                        local predictedPosition = part.Position + velocity * tonumber(predictiontime)
                        mousepos = predictedPosition
                        return
                    end
                end
            elseif slientaimtype == "Survivors" and slientaim and (character.Name == "Dusekkar" or character.Name == "JaneDoe") then
                local survivor = findclosestsurv() 
                if survivor then
                    local part = survivor:FindFirstChild("HumanoidRootPart")
                    if part then
                        local velocity = part.AssemblyLinearVelocity or Vector3.zero
                        local predictedPosition = part.Position + velocity * tonumber(predictiontime)
                        mousepos = predictedPosition
                        return
                    end
                end
            elseif slientaimtype == "Closest to mouse" and slientaim and (character.Name == "Dusekkar" or character.Name == "JaneDoe") then
                local survivor = findclosesttomouse()
                if survivor then
                    local part = survivor:FindFirstChild("HumanoidRootPart")
                    if part then
                        local velocity = part.AssemblyLinearVelocity or Vector3.zero
                        local predictedPosition = part.Position + velocity * tonumber(predictiontime)
                        mousepos = predictedPosition
                        return
                    end
                end
            end
            if killerssilentaim and {character.Name == "Noli" or character.Name == "c00lkidd"} then
                local survivor = findclosestsurv() 
                if survivor then
                    local part = survivor:FindFirstChild("HumanoidRootPart")
                    if part then
                        local velocity = part.AssemblyLinearVelocity or Vector3.zero
                        local predictedPosition = part.Position + velocity * tonumber(predictiontime)
                        mousepos = predictedPosition
                        return
                    end
                end
            end
            --[[
            if character.Name == "007n7" and toggleooblock then
                local me = lp.Character
                if me:FindFirstChild("HumanoidRootPart") then
                    mousepos = me:FindFirstChild("HumanoidRootPart")
                    return
                end
            end
            ]]
        end
        mousepos = nil
    end)
end

-- Normal aim bot:
local function aimto(part, duration, hum)
	if not part then return end
	local camera = game.workspace.CurrentCamera
    local hrp = lp.Character.HumanoidRootPart
	local starttime = tick()

	local conn
	conn = run.RenderStepped:Connect(function()
		if tick() - starttime > duration then
			conn:Disconnect()
			return
		end

        local predictpos
        local movedir
        local speed = hum.WalkSpeed

        if hum.MoveDirection.Magnitude == 0 then
            movedir = hum.MoveDirection
        else
            movedir = hum.MoveDirection.Unit
        end

        --[[if velocity ~= Vector3.new(0, 0, 0) and toggleaimpredict then
		    predictpos = part.CFrame + velocity * tonumber(aimpredict)]]
        if speed and toggleaimpredict then
            predictpos = part.AssemblyLinearVelocity * tonumber(predictiontime)
        else
            predictpos = part.CFrame
        end

        if togglecharaim and toggleaim then
            if toggleaimpredict then
                hrp.CFrame = CFrame.lookAt(hrp.Position, predictpos or part.Position)
            else
                hrp.CFrame = CFrame.lookAt(hrp.Position, part.Position)
            end
        elseif toggleaim then
            if toggleaimpredict then
		        camera.CFrame = CFrame.new(camera.CFrame.Position, predictpos)
            else
                camera.CFrame = CFrame.new(camera.CFrame.Position, part.Position)
            end
        end
	end)
end

mainremote.OnClientEvent:Connect(function(action, ability)
    if action ~= "UseActorAbility" or not toggleaim or not currentkiller then return end
    local char = lp.Character

    if not char or char.Parent.Name ~= "Survivors" then return end

    local ez = tostring(buffer.tostring(ability[1]):sub(6))
    local duration = durations[ez]

    local target = currentkiller:FindFirstChild("HumanoidRootPart")
    if target and duration then
        aimto(target, duration, currentkiller:FindFirstChild("Humanoid"))
    end
end)

mainremote.OnClientEvent:Connect(function(action, ability)
    if action ~= "UseActorAbility" or not togglekilleraim then return end
    local name = lp.Character.Name

    if not name or lp.Character.Parent.Name ~= "Killers" then return end

    local ez = buffer.tostring(ability[1]):sub(6)
    local duration = killerdurations[ez]

    local target = findclosestsurv()
    if target and duration then
        aimto(target:FindFirstChild("HumanoidRootPart"), duration, target:FindFirstChild("Humanoid"))
    end
end)

-- True punch
mainremote.OnClientEvent:Connect(function(action, ability)
    if action ~= "UseActorAbility" or not truepunch then return end
    local name = lp.Character.Name

    if not name or lp.Character.Name ~= "Guest1337" then return end

    local ez = buffer.tostring(ability[1]):sub(6)
    if ez ~= "Punch" then return end

    task.wait(0.6)
    local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
    for _, obj in ipairs(hrp:GetChildren()) do
        if obj:IsA("BodyMover") or obj:IsA("BodyVelocity") or obj:IsA("LinearVelocity") or obj:IsA("VectorForce") then
            obj:Destroy()
        end
    end

    local start = tick()
    local conn

    conn = run.RenderStepped:Connect(function()
        if tick() - start >= 0.25 then
            hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            conn:Disconnect()
            conn = nil
        end 

        local cam = workspace.CurrentCamera
        if cam then
            local dir = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
            hrp.Velocity = Vector3.new(dir.X * 90, hrp.Velocity.Y, dir.Z * 90)
        end
    end)
end)

-- Auto backstab:
mainremote.OnClientEvent:Connect(function(action, ability)
    if action ~= "UseActorAbility" then return end
    if tostring(buffer.tostring(ability[1]):sub(6)) ~= "Dagger" or lp.Character.Name ~= "TwoTime" then return end

    local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
    local killerhrp = currentkiller:FindFirstChild("HumanoidRootPart")

    task.spawn(function()
        if autolook then
            hrp.CFrame = CFrame.lookAt(
                hrp.Position, 
                hrp.Position + Vector3.new(killerhrp.CFrame.LookVector.X, 0, killerhrp.CFrame.LookVector.Z).Unit)
        end
    end)

    if not hrp or not killerhrp or not toggleautobackstab then return end
    if (killerhrp.Position - hrp.Position).Magnitude > autobackstabtrigdist then return end

    local start = tick()
    local conn

    --autobackstabtrigdist
    --"Tween", "Teleport 1 Time", "Teleport until ability end","Hitbox Drag"
    --autobackstabtype

    --[[if autobackstabtype == "Teleport until ability end" then
        conn = run.RenderStepped:Connect(function()
            if tick() - start > 0.6 then
                conn:Disconnect()
            end

            hrp.CFrame = killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance))
        end)
    else]]if autobackstabtype == "Teleport" then
        hrp.CFrame = killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance))

        if usewithhitboxdrag then
            local c
            c = run.Heartbeat:Connect(function()
                if tick() - start > 0.8 then
                    c:Disconnect()
                    c = nil
                    return
                end

                lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance)), lp.Character.HumanoidRootPart.AssemblyLinearVelocity))
            end)
        end
    elseif autobackstabtype == "Tween" then
        local tween = twin:Create(hrp, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), 
        {CFrame = killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance))})
        tween:Play()

        if usewithhitboxdrag then
            local c
            c = run.Heartbeat:Connect(function()
                if tick() - start > 0.8 then
                    c:Disconnect()
                    c = nil
                    return
                end

                lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance)), lp.Character.HumanoidRootPart.AssemblyLinearVelocity))
            end)
        end
    elseif autobackstabtype == "Hitbox Drag" then
        local c
        c = run.Heartbeat:Connect(function()
            if tick() - start > 0.8 then
                c:Disconnect()
                c = nil
                return
            end

            lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(killerhrp.CFrame * CFrame.new(0, 0, tonumber(autobackstabdistance)), lp.Character.HumanoidRootPart.AssemblyLinearVelocity))
        end)
    end
end)

-- Hitbox expander:
--[[local function jasonhitbox()
    if hitboxfunc then hitboxfunc:Disconnect() end

    hitboxfunc = game:GetService("RunService").Heartbeat:Connect(function()
        if not jh or jh2 or jh3 or bjh then return end

        local hum = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
        local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

        local Playing = false
        for _, v in hum:GetPlayingAnimationTracks() do
            if AttackAnimations[v.Animation.AnimationId] and (v.TimePosition / v.Length < 0.75) then
                Playing = true
            end
        end

        if not Playing then
            return
        end

        local tar

        if game:GetService("Players").LocalPlayer.Character.Parent.Name == "Killers" then
            tar = findclosestsurv()
            if not tar then
                tar = findclosestnpc()
            end
        else
            tar = workspace.Players.Killers:GetChildren()[1]
            if not tar then
                tar = findclosestnpc()
            end
        end

        if not tar then
            return
        end

        local d = (tar.HumanoidRootPart.Position - hrp.Position).Magnitude
        if d > hdist then
            return
        end

        local ov = hrp.Velocity
        local tarpos = tar.HumanoidRootPart.Position
        local nv = (tarpos - hrp.Position) * 11
        
        hrp.Velocity = nv
        game:GetService("RunService").RenderStepped:Wait()
        hrp.Velocity = ov
    end)
end]]
-- they patched it

-- Hitbox v2:
local function betterhitbox()
    if hitboxfunc2 then hitboxfunc2:Disconnect() end

    local first = true
    local second = false
    local third = false

    local humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")

    hitboxfunc2 = game:GetService("RunService").Heartbeat:Connect(function()
        if not bjh or jh or jh2 or jh3 then return end

        local Playing = false
        for _, v in humanoid:GetPlayingAnimationTracks() do
            if AttackAnimations[v.Animation.AnimationId] and (v.TimePosition / v.Length < 0.75) then
                Playing = true
            end
        end

        if not Playing then
            return
        end

        local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local OldVelocity = HumanoidRootPart.Velocity

        if first then
            HumanoidRootPart.Velocity = Vector3.new(HumanoidRootPart.CFrame.LookVector.X * 150, 0, HumanoidRootPart.CFrame.LookVector.Z * 150)
            first = false
            third = false
            second = true
        elseif second then
            HumanoidRootPart.Velocity = Vector3.new(HumanoidRootPart.CFrame.LookVector.X * 75, 0, HumanoidRootPart.CFrame.LookVector.Z * 75)
            first = false
            second = false
            third = true
        elseif third then
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            first = true
            second = false
            third = false
        end
        game:GetService("RunService").RenderStepped:Wait()
        HumanoidRootPart.Velocity = OldVelocity
    end)
end

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    
    --jasonhitbox()
    betterhitbox()
end)

--jasonhitbox()
betterhitbox()

-- Better controll:
local function clearForces()
	for _, obj in ipairs(hrp:GetChildren()) do
		if obj:IsA("BodyMover") or obj:IsA("BodyVelocity") or obj:IsA("LinearVelocity") or obj:IsA("VectorForce") then
			obj:Destroy()
		end
	end
end

controllconn = hum.AnimationPlayed:Connect(function(t)
	local data = controllanims[t.Animation.AnimationId]
	if data then
		track = t
		task.wait(data.delay)
		moving = true
		t.Stopped:Connect(function()
			moving = false
			hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
		end)
	end
end)

run.RenderStepped:Connect(function()
    if not togglebettercontroll then return end
    if moving and track and track.IsPlaying and togglebettercontroll then
        clearForces()
        local cam = workspace.CurrentCamera
        if cam then
            local dir = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
            local spd = controllanims[track.Animation.AnimationId].speed
            hrp.Velocity = Vector3.new(dir.X * (spd * controllll), hrp.Velocity.Y, dir.Z * (spd * controllll))
        end
    end
end)


lp.CharacterAdded:Connect(function(char)
    hrp = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")

    if controllconn then controllconn:Disconnect() end

    controllconn = hum.AnimationPlayed:Connect(function(t)
        local data = controllanims[t.Animation.AnimationId]
        if data then
            track = t
            task.wait(data.delay)
            moving = true
            t.Stopped:Connect(function()
                moving = false
                hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            end)
        end
    end)
end)

local function dofakeblock(animationid)
    local animation = Instance.new("Animation")
    animation.AnimationId = animationid
    local fb = hum:LoadAnimation(animation)
    fb:Play()
end

local function spawnanimchanger(code)
    if currentanimationreplace == "None" then return end

    animationcode = code
    local mycode = code

    local walkrunconn
    local jumpconn
    local idleconn

    local customData = customanimsids[currentanimationreplace]
    local humanoid = lp.Character:WaitForChild("Humanoid")

    local walkAnimation = Instance.new("Animation")
    walkAnimation.AnimationId = customData.walkAnimationId
    local idleAnimation = Instance.new("Animation")
    idleAnimation.AnimationId = customData.idleAnimationId
    local jumpAnimation = Instance.new("Animation")
    jumpAnimation.AnimationId = customData.jumpAnimationId
    local runAnimation = Instance.new("Animation")
    runAnimation.AnimationId = customData.runanimationId

    local walkTrack = humanoid:LoadAnimation(walkAnimation)
    local idleTrack = humanoid:LoadAnimation(idleAnimation)
    local jumpTrack = humanoid:LoadAnimation(jumpAnimation)
    local runtrack = humanoid:LoadAnimation(runAnimation)

    idleTrack:Play()

    function onWalking()
        if not walkTrack.IsPlaying then
            walkTrack:Play()
        end
        if idleTrack.IsPlaying then
            idleTrack:Stop()
        end
        if runtrack.IsPlaying then
            runtrack:Stop()
        end
    end

    function onIdle()
        if not idleTrack.IsPlaying then
            idleTrack:Play()
        end
        if walkTrack.IsPlaying then
            walkTrack:Stop()
        end
    if runtrack.IsPlaying then
            runtrack:Stop()
        end
    end

	function onRuning()
        if not idleTrack.IsPlaying then
            idleTrack:Stop()
        end
        if walkTrack.IsPlaying then
            walkTrack:Stop()
        end
	    if not runtrack.IsPlaying then
            runtrack:Play()
        end
	end

    function onJump()
        if not jumpTrack.IsPlaying then
            jumpTrack:Play()
        end
    end

    walkrunconn = humanoid.Running:Connect(function(speed)
        if currentanimationreplace == "None" or mycode ~= animationcode then
            if walkTrack.IsPlaying then
                walkTrack:Stop()
            end
            if idleTrack.IsPlaying then
                idleTrack:Stop()
            end
            if runtrack.IsPlaying then
                runtrack:Stop()
            end
            if jumpTrack.IsPlaying then
                jumpTrack:Stop()
            end
            walkrunconn:Disconnect()
            return
        end

        local speedvalue = lp.Character:FindFirstChild("SpeedMultipliers"):FindFirstChild("Sprinting")
        if not speedvalue or not speedvalue.Value then return end

        if speed <= 17 and speed > 1 then
            onWalking()
        elseif speedvalue.Value > 1 and speed > 18 then
            onRuning()
        else
            onIdle()
        end
    end)

    jumpconn = humanoid.Jumping:Connect(function()
        if currentanimationreplace == "None" or mycode ~= animationcode then
            if walkTrack.IsPlaying then
                walkTrack:Stop()
            end
            if idleTrack.IsPlaying then
                idleTrack:Stop()
            end
            if runtrack.IsPlaying then
                runtrack:Stop()
            end
            if jumpTrack.IsPlaying then
                jumpTrack:Stop()
            end
            jumpconn:Disconnect()
            return
        end

        onJump()
    end)

    idleconn = humanoid.FreeFalling:Connect(function()
        if currentanimationreplace == "None" or mycode ~= animationcode then
            if walkTrack.IsPlaying then
                walkTrack:Stop()
            end
            if idleTrack.IsPlaying then
                idleTrack:Stop()
            end
            if runtrack.IsPlaying then
                runtrack:Stop()
            end
            if jumpTrack.IsPlaying then
                jumpTrack:Stop()
            end
            idleconn:Disconnect()
            return
        end

        onIdle()
    end)
end

lp.CharacterAdded:Connect(function()
    spawnanimchanger(randomtext())
end)

local function playecustomemote(emote)
    local humanoid = lp.Character:WaitForChild("Humanoid")
    local data = customemotesanims[emote]

    local animation = Instance.new("Animation")
    if emote ~= "None" then
        animation.AnimationId = data.animationId
        emoteanimationspy = humanoid:LoadAnimation(animation)
        emoteanimationspy.Looped = data.loops
    end

    if data and data.soundId and data.soundId ~= "rbxassetid://0" and emote ~= "None" then
        emotesoundspy = Instance.new("Sound")
        emotesoundspy.SoundId = data.soundId
        emotesoundspy.Parent = humanoid.Parent or lp.Character
        emotesoundspy.Volume = 1
        emotesoundspy.Looped = data.loops
        emotesoundspy:Play()
    end

    local function stopEmote()
        if emoteanimationspy and emoteanimationspy.IsPlaying then
            emoteanimationspy:Stop()
            emoteanimationspy = nil
        end
        if emotesoundspy and emotesoundspy.IsPlaying then
            emotesoundspy:Stop()
            emotesoundspy = nil
        end
    end

    if emote ~= "None" then
        emoteanimationspy:Play()
    else
        stopEmote()
    end

    lp:GetMouse().KeyDown:Connect(function(key)
        if key == " " then
            stopEmote()
        end
    end)

    humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
        if humanoid.Jump then
            stopEmote()
        end
    end)
end

local function SigmaHubEmoteGUI()
    if useemotegui == 0 then
        useemotegui = 1
    	local FartHubEmoteGUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
    	local FartsakLogo = Instance.new("ImageLabel")
    	local LogoUIC = Instance.new("UICorner")
    	local Bwah = Instance.new("UIAspectRatioConstraint")
    	local WhereTheButtons = Instance.new("Frame")
    	local _1 = Instance.new("Frame")
    	local TextButton1 = Instance.new("TextButton")
    	local Front1 = Instance.new("ImageLabel")
    	local UIC111 = Instance.new("UICorner")
    	local Background1 = Instance.new("ImageLabel")
    	local UIC11 = Instance.new("UICorner")
    	local UIC1 = Instance.new("UICorner")
    	local _2 = Instance.new("Frame")
    	local TextButton2 = Instance.new("TextButton")
    	local Front2 = Instance.new("ImageLabel")
    	local UIC222 = Instance.new("UICorner")
    	local Background2 = Instance.new("ImageLabel")
    	local UIC22 = Instance.new("UICorner")
    	local UIC2 = Instance.new("UICorner")
    	local _3 = Instance.new("Frame")
    	local TextButton3 = Instance.new("TextButton")
    	local Front3 = Instance.new("ImageLabel")
    	local UIC333 = Instance.new("UICorner")
    	local Background3 = Instance.new("ImageLabel")
    	local UIC33 = Instance.new("UICorner")
    	local UIC3 = Instance.new("UICorner")
    	local _4 = Instance.new("Frame")
    	local TextButton4 = Instance.new("TextButton")
    	local Front4 = Instance.new("ImageLabel")
    	local UIC444 = Instance.new("UICorner")
    	local Background4 = Instance.new("ImageLabel")
    	local UIC44 = Instance.new("UICorner")
    	local UIC4 = Instance.new("UICorner")
    	local _5 = Instance.new("Frame")
    	local TextButton5 = Instance.new("TextButton")
    	local Front5 = Instance.new("ImageLabel")
    	local UIC555 = Instance.new("UICorner")
    	local Background5 = Instance.new("ImageLabel")
    	local UIC55 = Instance.new("UICorner")
    	local UIC5 = Instance.new("UICorner")
    	local _6 = Instance.new("Frame")
    	local TextButton6 = Instance.new("TextButton")
    	local Front6 = Instance.new("ImageLabel")
    	local UIC666 = Instance.new("UICorner")
    	local Background6 = Instance.new("ImageLabel")
    	local UIC66 = Instance.new("UICorner")
    	local UIC6 = Instance.new("UICorner")
    	local _7 = Instance.new("Frame")
    	local TextButton7 = Instance.new("TextButton")
    	local Front7 = Instance.new("ImageLabel")
    	local UIC777 = Instance.new("UICorner")
    	local Background7 = Instance.new("ImageLabel")
    	local UIC77 = Instance.new("UICorner")
    	local UIC7 = Instance.new("UICorner")
    	local _8 = Instance.new("Frame")
    	local TextButton8 = Instance.new("TextButton")
    	local Front8 = Instance.new("ImageLabel")
    	local UIC888 = Instance.new("UICorner")
    	local Background8 = Instance.new("ImageLabel")
    	local UIC88 = Instance.new("UICorner")
    	local UIC8 = Instance.new("UICorner")
    	local ListingLayouts = Instance.new("UIListLayout")
    	local WhereButtonPadding = Instance.new("UIPadding")
    	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    	local Name = Instance.new("Frame")
    	local NameTextbox = Instance.new("TextLabel")
    	local NameUIT = Instance.new("UITextSizeConstraint")
    	local NameUIC = Instance.new("UICorner")
    	local sigmahubtest = Instance.new("Frame")
    	local sigmasakentestemotes = Instance.new("Frame")
    	local textemoteframe = Instance.new("TextLabel")
        
        sigmahubtest.Name = "EmoteHolder"
        sigmahubtest.Position = UDim2.new(0, 0, 0, 0)
        sigmahubtest.Size = UDim2.new(1, 0, 1, 0)
        sigmahubtest.BackgroundTransparency = 1
        sigmahubtest.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        sigmahubtest.BorderColor3 = Color3.fromRGB(0, 0, 0)
        sigmahubtest.Parent = FartHubEmoteGUI
        
        sigmasakentestemotes.Name = "Emotes"
        sigmasakentestemotes.Parent = sigmahubtest
        sigmasakentestemotes.Position = UDim2.new(0.325, 0, 0.15, 0)
        sigmasakentestemotes.Size = UDim2.new(0.35, 0, 0.7, 0)
        sigmasakentestemotes.BackgroundTransparency = 1
        sigmasakentestemotes.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        sigmasakentestemotes.BorderColor3 = Color3.fromRGB(0, 0, 0)
        
    	FartHubEmoteGUI.Name = "SigmasakenEmoteGUI"
    	FartHubEmoteGUI.Parent = game:GetService("CoreGui")
    	FartHubEmoteGUI.ResetOnSpawn = false
        
        textemoteframe.Name = "SigmasakenEmoteLabel"
        textemoteframe.Text = "Emotes"
        textemoteframe.Size = UDim2.new(0.35, 0, 0.15, 0)
        textemoteframe.Position = UDim2.new(0.324999988, 0, 0.44999988, 0)
        textemoteframe.Parent = sigmasakentestemotes
        textemoteframe.TextSize = 36
        textemoteframe.TextColor3 = Color3.fromRGB(255, 255, 255)
        textemoteframe.BackgroundTransparency = 1
        textemoteframe.TextScaled = true
    
    	_1.Name = "1"
    	_1.Parent = sigmasakentestemotes
    	_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_1.BackgroundTransparency = 0.700
    	_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_1.BorderSizePixel = 0
    	_1.LayoutOrder = 1
    	_1.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_1.Position = UDim2.new(0.5, 0, 0.75, 0)
    	_1.ZIndex = 2
    
    	TextButton1.Name = "TextButton1"
    	TextButton1.Parent = _1
    	TextButton1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton1.BackgroundTransparency = 1.000
    	TextButton1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton1.BorderSizePixel = 0
    	TextButton1.Size = UDim2.new(1, 0, 1, 0)
    	TextButton1.ZIndex = 3
    	TextButton1.Font = Enum.Font.FredokaOne
    	TextButton1.Text = ""
    	TextButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton1.TextScaled = true
    	TextButton1.TextSize = 10.000
    	TextButton1.TextWrapped = true
    
    	Front1.Name = "Front1"
    	Front1.Parent = TextButton1
    	Front1.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front1.BackgroundTransparency = 1.000
    	Front1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front1.BorderSizePixel = 0
    	Front1.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front1.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front1.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front1.ZIndex = 4
    	Front1.Image = "rbxassetid://112068843495830"
    
    	UIC111.Name = "UIC111"
    	UIC111.Parent = Front1
    
    	Background1.Name = "Background1"
    	Background1.Parent = TextButton1
    	Background1.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background1.BackgroundTransparency = 1.000
    	Background1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background1.BorderSizePixel = 0
    	Background1.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background1.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background1.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background1.ZIndex = 3
    	Background1.Image = "rbxassetid://138110752460865"
    
    	UIC11.Name = "UIC11"
    	UIC11.Parent = Background1
    
    	UIC1.Name = "UIC1"
    	UIC1.Parent = _1
    
    	_2.Name = "2"
    	_2.Parent = sigmasakentestemotes
    	_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_2.BackgroundTransparency = 0.700
    	_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_2.BorderSizePixel = 0
    	_2.LayoutOrder = 2
    	_2.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_2.Position = UDim2.new(0.75, 0, 0.5, 0)
    	_2.ZIndex = 2
    
    	TextButton2.Name = "TextButton2"
    	TextButton2.Parent = _2
    	TextButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton2.BackgroundTransparency = 1.000
    	TextButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton2.BorderSizePixel = 0
    	TextButton2.Size = UDim2.new(1, 0, 1, 0)
    	TextButton2.ZIndex = 3
    	TextButton2.Font = Enum.Font.FredokaOne
    	TextButton2.Text = ""
    	TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton2.TextScaled = true
    	TextButton2.TextSize = 10.000
    	TextButton2.TextWrapped = true
    
    	Front2.Name = "Front2"
    	Front2.Parent = TextButton2
    	Front2.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front2.BackgroundTransparency = 1.000
    	Front2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front2.BorderSizePixel = 0
    	Front2.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front2.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front2.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front2.ZIndex = 4
    	Front2.Image = "rbxassetid://112068843495830"
    
    	UIC222.Name = "UIC222"
    	UIC222.Parent = Front2
    
    	Background2.Name = "Background2"
    	Background2.Parent = TextButton2
    	Background2.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background2.BackgroundTransparency = 1.000
    	Background2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background2.BorderSizePixel = 0
    	Background2.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background2.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background2.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background2.ZIndex = 3
    	Background2.Image = "rbxassetid://138110752460865"
    
    	UIC22.Name = "UIC22"
    	UIC22.Parent = Background2
    
    	UIC2.Name = "UIC2"
    	UIC2.Parent = _2
    
    	_3.Name = "3"
    	_3.Parent = sigmasakentestemotes
    	_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_3.BackgroundTransparency = 0.700
    	_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_3.BorderSizePixel = 0
    	_3.LayoutOrder = 3
    	_3.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_3.Position = UDim2.new(0.75, 0, 0.25, 0)
    	_3.ZIndex = 2
    
    	TextButton3.Name = "TextButton3"
    	TextButton3.Parent = _3
    	TextButton3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton3.BackgroundTransparency = 1.000
    	TextButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton3.BorderSizePixel = 0
    	TextButton3.Size = UDim2.new(1, 0, 1, 0)
    	TextButton3.ZIndex = 3
    	TextButton3.Font = Enum.Font.FredokaOne
    	TextButton3.Text = ""
    	TextButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton3.TextScaled = true
    	TextButton3.TextSize = 10.000
    	TextButton3.TextWrapped = true
    
    	Front3.Name = "Front3"
    	Front3.Parent = TextButton3
    	Front3.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front3.BackgroundTransparency = 1.000
    	Front3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front3.BorderSizePixel = 0
    	Front3.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front3.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front3.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front3.ZIndex = 4
    	Front3.Image = "rbxassetid://112068843495830"
    
    	UIC333.Name = "UIC333"
    	UIC333.Parent = Front3
    
    	Background3.Name = "Background3"
    	Background3.Parent = TextButton3
    	Background3.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background3.BackgroundTransparency = 1.000
    	Background3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background3.BorderSizePixel = 0
    	Background3.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background3.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background3.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background3.ZIndex = 3
    	Background3.Image = "rbxassetid://138110752460865"
    
    	UIC33.Name = "UIC33"
    	UIC33.Parent = Background3
    
    	UIC3.Name = "UIC3"
    	UIC3.Parent = _3
    
    	_4.Name = "4"
    	_4.Parent = sigmasakentestemotes
    	_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_4.BackgroundTransparency = 0.700
    	_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_4.BorderSizePixel = 0
    	_4.LayoutOrder = 4
    	_4.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_4.Position = UDim2.new(0.5, 0, 0, 0)
    	_4.ZIndex = 2
    
    	TextButton4.Name = "TextButton4"
    	TextButton4.Parent = _4
    	TextButton4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton4.BackgroundTransparency = 1.000
    	TextButton4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton4.BorderSizePixel = 0
    	TextButton4.Size = UDim2.new(1, 0, 1, 0)
    	TextButton4.ZIndex = 3
    	TextButton4.Font = Enum.Font.FredokaOne
    	TextButton4.Text = ""
    	TextButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton4.TextScaled = true
    	TextButton4.TextSize = 10.000
    	TextButton4.TextWrapped = true
    
    	Front4.Name = "Front4"
    	Front4.Parent = TextButton4
    	Front4.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front4.BackgroundTransparency = 1.000
    	Front4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front4.BorderSizePixel = 0
    	Front4.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front4.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front4.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front4.ZIndex = 4
    	Front4.Image = "rbxassetid://112068843495830"
    
    	UIC444.Name = "UIC444"
    	UIC444.Parent = Front4
    
    	Background4.Name = "Background4"
    	Background4.Parent = TextButton4
    	Background4.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background4.BackgroundTransparency = 1.000
    	Background4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background4.BorderSizePixel = 0
    	Background4.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background4.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background4.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background4.ZIndex = 3
    	Background4.Image = "rbxassetid://138110752460865"
    
    	UIC44.Name = "UIC44"
    	UIC44.Parent = Background4
    
    	UIC4.Name = "UIC4"
    	UIC4.Parent = _4
    
    	_5.Name = "5"
    	_5.Parent = sigmasakentestemotes
    	_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_5.BackgroundTransparency = 0.700
    	_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_5.BorderSizePixel = 0
    	_5.LayoutOrder = 5
    	_5.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_5.Position = UDim2.new(0.25, 0, 0, 0)
    	_5.ZIndex = 2
    
    	TextButton5.Name = "TextButton5"
    	TextButton5.Parent = _5
    	TextButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton5.BackgroundTransparency = 1.000
    	TextButton5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton5.BorderSizePixel = 0
    	TextButton5.Size = UDim2.new(1, 0, 1, 0)
    	TextButton5.ZIndex = 3
    	TextButton5.Font = Enum.Font.FredokaOne
    	TextButton5.Text = ""
    	TextButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton5.TextScaled = true
    	TextButton5.TextSize = 10.000
    	TextButton5.TextWrapped = true
    
    	Front5.Name = "Front5"
    	Front5.Parent = TextButton5
    	Front5.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front5.BackgroundTransparency = 1.000
    	Front5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front5.BorderSizePixel = 0
    	Front5.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front5.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front5.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front5.ZIndex = 4
    	Front5.Image = "rbxassetid://112068843495830"
    
    	UIC555.Name = "UIC555"
    	UIC555.Parent = Front5
    
    	Background5.Name = "Background5"
    	Background5.Parent = TextButton5
    	Background5.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background5.BackgroundTransparency = 1.000
    	Background5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background5.BorderSizePixel = 0
    	Background5.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background5.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background5.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background5.ZIndex = 3
    	Background5.Image = "rbxassetid://138110752460865"
    
    	UIC55.Name = "UIC55"
    	UIC55.Parent = Background5
    
    	UIC5.Name = "UIC5"
    	UIC5.Parent = _5
    
    	_6.Name = "6"
    	_6.Parent = sigmasakentestemotes
    	_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_6.BackgroundTransparency = 0.700
    	_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_6.BorderSizePixel = 0
    	_6.LayoutOrder = 6
    	_6.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_6.Position = UDim2.new(0, 0, 0.25, 0)
    	_6.ZIndex = 2
    
    	TextButton6.Name = "TextButton6"
    	TextButton6.Parent = _6
    	TextButton6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton6.BackgroundTransparency = 1.000
    	TextButton6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton6.BorderSizePixel = 0
    	TextButton6.Size = UDim2.new(1, 0, 1, 0)
    	TextButton6.ZIndex = 3
    	TextButton6.Font = Enum.Font.FredokaOne
    	TextButton6.Text = ""
    	TextButton6.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton6.TextScaled = true
    	TextButton6.TextSize = 10.000
    	TextButton6.TextWrapped = true
    
    	Front6.Name = "Front6"
    	Front6.Parent = TextButton6
    	Front6.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front6.BackgroundTransparency = 1.000
    	Front6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front6.BorderSizePixel = 0
    	Front6.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front6.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front6.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front6.ZIndex = 4
    	Front6.Image = "rbxassetid://112068843495830"
    
    	UIC666.Name = "UIC666"
    	UIC666.Parent = Front6
    
    	Background6.Name = "Background6"
    	Background6.Parent = TextButton6
    	Background6.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background6.BackgroundTransparency = 1.000
    	Background6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background6.BorderSizePixel = 0
    	Background6.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background6.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background6.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background6.ZIndex = 3
    	Background6.Image = "rbxassetid://138110752460865"
    
    	UIC66.Name = "UIC66"
    	UIC66.Parent = Background6
    
    	UIC6.Name = "UIC6"
    	UIC6.Parent = _6
    
    	_7.Name = "7"
    	_7.Parent = sigmasakentestemotes
    	_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_7.BackgroundTransparency = 0.700
    	_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_7.BorderSizePixel = 0
    	_7.LayoutOrder = 7
    	_7.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_7.Position = UDim2.new(0, 0, 0.5, 0)
    	_7.ZIndex = 2
    
    	TextButton7.Name = "TextButton7"
    	TextButton7.Parent = _7
    	TextButton7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton7.BackgroundTransparency = 1.000
    	TextButton7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton7.BorderSizePixel = 0
    	TextButton7.Size = UDim2.new(1, 0, 1, 0)
    	TextButton7.ZIndex = 3
    	TextButton7.Font = Enum.Font.FredokaOne
    	TextButton7.Text = ""
    	TextButton7.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton7.TextScaled = true
    	TextButton7.TextSize = 10.000
    	TextButton7.TextWrapped = true
    
    	Front7.Name = "Front7"
    	Front7.Parent = TextButton7
    	Front7.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front7.BackgroundTransparency = 1.000
    	Front7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front7.BorderSizePixel = 0
    	Front7.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front7.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front7.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front7.ZIndex = 4
    	Front7.Image = "rbxassetid://112068843495830"
    
    	UIC777.Name = "UIC777"
    	UIC777.Parent = Front7
    
    	Background7.Name = "Background7"
    	Background7.Parent = TextButton7
    	Background7.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background7.BackgroundTransparency = 1.000
    	Background7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background7.BorderSizePixel = 0
    	Background7.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background7.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background7.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background7.ZIndex = 3
    	Background7.Image = "rbxassetid://138110752460865"
    
    	UIC77.Name = "UIC77"
    	UIC77.Parent = Background7
    
    	UIC7.Name = "UIC7"
    	UIC7.Parent = _7
    
    	_8.Name = "8"
    	_8.Parent = sigmasakentestemotes
    	_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	_8.BackgroundTransparency = 0.700
    	_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	_8.BorderSizePixel = 0
    	_8.LayoutOrder = 8
    	_8.Size = UDim2.new(0.225, 0, 0.225, 0)
    	_8.Position = UDim2.new(0.25, 0, 0.75, 0)
    	_8.ZIndex = 2
    
    	TextButton8.Name = "TextButton8"
    	TextButton8.Parent = _8
    	TextButton8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton8.BackgroundTransparency = 1.000
    	TextButton8.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	TextButton8.BorderSizePixel = 0
    	TextButton8.Size = UDim2.new(1, 0, 1, 0)
    	TextButton8.ZIndex = 3
    	TextButton8.Font = Enum.Font.FredokaOne
    	TextButton8.Text = ""
    	TextButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
    	TextButton8.TextScaled = true
    	TextButton8.TextSize = 10.000
    	TextButton8.TextWrapped = true
    
    	Front8.Name = "Front8"
    	Front8.Parent = TextButton8
    	Front8.AnchorPoint = Vector2.new(0.5, 0.5)
    	Front8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Front8.BackgroundTransparency = 1.000
    	Front8.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Front8.BorderSizePixel = 0
    	Front8.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Front8.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
    	Front8.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Front8.ZIndex = 4
    	Front8.Image = "rbxassetid://112068843495830"
    
    	UIC888.Name = "UIC888"
    	UIC888.Parent = Front8
    
    	Background8.Name = "Background8"
    	Background8.Parent = TextButton8
    	Background8.AnchorPoint = Vector2.new(0.5, 0.5)
    	Background8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	Background8.BackgroundTransparency = 1.000
    	Background8.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Background8.BorderSizePixel = 0
    	Background8.Position = UDim2.new(0.5, 0, 0.5, 0)
    	Background8.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
    	Background8.SizeConstraint = Enum.SizeConstraint.RelativeXX
    	Background8.ZIndex = 3
    	Background8.Image = "rbxassetid://138110752460865"
    
    	UIC88.Name = "UIC88"
    	UIC88.Parent = Background8
    
    	UIC8.Name = "UIC8"
    	UIC8.Parent = _8
    
    	ListingLayouts.Name = "ListingLayouts"
    	ListingLayouts.Parent = WhereTheButtons
    	ListingLayouts.FillDirection = Enum.FillDirection.Horizontal
    	ListingLayouts.SortOrder = Enum.SortOrder.LayoutOrder
    	ListingLayouts.VerticalAlignment = Enum.VerticalAlignment.Center
    	ListingLayouts.HorizontalAlignment = Enum.HorizontalAlignment.Left
    	ListingLayouts.Padding = UDim.new(0, 5)
    
    	Name.Name = "Name"
    	Name.Parent = sigmahubtest
    	Name.AnchorPoint = Vector2.new(0.5, 1)
    	Name.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    	Name.BackgroundTransparency = 0.250
    	Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	Name.BorderSizePixel = 0
    	Name.Position = UDim2.new(0.4999999999, 0, 0.8999999999, 0)
    	Name.Size = UDim2.new(0.349999999999999, 0, 0.0499999999999, 0)
    
    	NameTextbox.Name = "NameTextbox"
    	NameTextbox.Parent = Name
    	NameTextbox.AnchorPoint = Vector2.new(0.5, 0.5)
    	NameTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	NameTextbox.BackgroundTransparency = 1.000
    	NameTextbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    	NameTextbox.BorderSizePixel = 0
    	NameTextbox.Position = UDim2.new(0.5, 0, 0.5, 0)
    	NameTextbox.Size = UDim2.new(1, 0, 1, 0)
    	NameTextbox.Font = Enum.Font.FredokaOne
    	NameTextbox.Text = "Some Emote Name"
    	NameTextbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    	NameTextbox.TextScaled = true
    	NameTextbox.TextSize = 14.000
    	NameTextbox.TextWrapped = true
    
    	NameUIT.Name = "NameUIT"
    	NameUIT.Parent = NameTextbox
    	NameUIT.MaxTextSize = 30
    	NameUIT.MinTextSize = 10
    
    	NameUIC.Name = "NameUIC"
    	NameUIC.Parent = Name
    
    	local Images = {
    		{ name = "Locked", renderImage = "rbxassetid://103241825392940" },
    		{ name = "LethalCompany", renderImage = "rbxassetid://89769371017185" },
    		{ name = "Headbanger", renderImage = "rbxassetid://126222345373558" },
    		{ name = "SoRetro", renderImage = "rbxassetid://129885437120707" },
    		{ name = "AICatDance", renderImage = "rbxassetid://93387041641721" },
    		{ name = "SubjectThree", renderImage = "rbxassetid://83639505456623" },
    		{ name = "Subterfuge", renderImage = "rbxassetid://71165177698139" },
    		{ name = "Griddy", renderImage = "rbxassetid://71748174857033" },
    		{ name = "Prince", renderImage = "rbxassetid://125197961882771" },
    		{ name = "MissTheQuiet", renderImage = "rbxassetid://86125219137797" },
    		{ name = "Hero", renderImage = "rbxassetid://78969991165860" },
    		{ name = "PYT", renderImage = "rbxassetid://121927033287000" },
    		{ name = "Wait", renderImage = "rbxassetid://106561882302009" },
    		{ name = "No", renderImage = "rbxassetid://101973569734115" },
    		{ name = "Konton", renderImage = "rbxassetid://135343313057075" },
    		{ name = "TickTock", renderImage = "rbxassetid://112068843495830" },
    		{ name = "Dio", renderImage = "rbxassetid://78716828045407" },
    		{ name = "Shucks", renderImage = "rbxassetid://139634009593796" },
    		{ name = "ThePhone", renderImage = "rbxassetid://91657126735088" },
    		{ name = "Skeleton", renderImage = "rbxassetid://94678300716216" },
    		{ name = "Insanity", renderImage = "rbxassetid://79579234154217" },
    		{ name = "HakariDance", renderImage = "rbxassetid://124587965197013" },
    		{ name = "SillyBilly", renderImage = "rbxassetid://96660516353249" },
    		{ name = "Hotdog", renderImage = "rbxassetid://70514684116327" },
    		{ name = "DistractionDance", renderImage = "rbxassetid://110811886859354" },
    		{ name = "CaliforniaGirls", renderImage = "rbxassetid://127260772788474" },
    		{ name = "AolGuy", renderImage = "rbxassetid://81493512531467" },
    		{ name = "Eggrolled", renderImage = "rbxassetid://75402218293560" },
    		{ name = "BagUp", renderImage = "rbxassetid://135883870615399" },
    		{ name = "Poisoned", renderImage = "rbxassetid://92399495788269" },
    		{ name = "Wave", renderImage = "rbxassetid://132063131763271" },
    		{ name = "Sukuna", renderImage = "rbxassetid://95950437854407" },
    		{ name = "Schadenfreude", renderImage = "rbxassetid://83576021763587" },
    		{ name = "HeyNow", renderImage = "rbxassetid://93665655595946" },
    		{ name = "AshleyLookAtMe", renderImage = "rbxassetid://101141010818082" },
            { name = "AintNoLovinMyMan", renderImage = "rbxassetid://93387041641721" },
            { name = "Brickbattler", renderImage = "rbxassetid://97057214315889" },
            { name = "ByeBye", renderImage = "rbxassetid://91183099073835" },
            { name = "CCShimmy", renderImage = "rbxassetid://92379847382802" },
            { name = "Caramell", renderImage = "rbxassetid://75549836782121" },
            { name = "Carried", renderImage = "rbxassetid://124186162960822" },
            { name = "Chicken", renderImage = "rbxassetid://93071213480245" },
            { name = "Chrono", renderImage = "rbxassetid://139203361911725" },
            { name = "Cinderella", renderImage = "rbxassetid://128794724828299" },
            { name = "Conga", renderImage = "rbxassetid://86813660004340" },
            { name = "Drumsticks", renderImage = "rbxassetid://80678095206124" },
            { name = "Fly", renderImage = "rbxassetid://94349587695619" },
            { name = "GangnamStyle", renderImage = "rbxassetid://101388085235785" },
            { name = "GleeCo", renderImage = "rbxassetid://101825267076434" },
            { name = "JumpingForJoy", renderImage = "rbxassetid://129614581942080" },
            { name = "Jumpstyle", renderImage = "rbxassetid://73574803924243" },
            { name = "KazotskyKick", renderImage = "rbxassetid://132653220480177" },
            { name = "Khaled", renderImage = "rbxassetid://104716889279869" },
            { name = "LostInParadise", renderImage = "rbxassetid://103747083343191" },
            { name = "Macarena", renderImage = "rbxassetid://131039110819633" },
            { name = "Mesmerizer", renderImage = "rbxassetid://75477238272674" },
            { name = "MonsterMash", renderImage = "rbxassetid://73592720532565" },
            { name = "OppaGangnam", renderImage = "rbxassetid://133166601563649" },
            { name = "Penguin", renderImage = "rbxassetid://106270433212018" },
            { name = "PopDance", renderImage = "rbxassetid://87183895795869" },
            { name = "Rambunctious", renderImage = "rbxassetid://83361353507905" },
            { name = "Rodrick", renderImage = "rbxassetid://105577400144738" },
            { name = "Silly", renderImage = "rbxassetid://121965062547127" },
            { name = "Static", renderImage = "rbxassetid://75414967011351" },
            { name = "StockDance", renderImage = "rbxassetid://136238391916155" },
            { name = "TVTime", renderImage = "rbxassetid://76185602955229" },
            { name = "TwoTwoTwo", renderImage = "rbxassetid://96092312091932" },
            { name = "VirtualInsanity", renderImage = "rbxassetid://132583909518061" },
    	}
    
    	local buttons = {
    		TextButton1,
    		TextButton2,
    		TextButton3,
    		TextButton4,
    		TextButton5,
    		TextButton6,
    		TextButton7,
    		TextButton8,
    	}
    
    	local function GetEmoteList()
    		local player = game:GetService("Players").LocalPlayer
    		local emotes = player:FindFirstChild("PlayerData")
    				and player.PlayerData:FindFirstChild("Equipped")
    				and player.PlayerData.Equipped:FindFirstChild("Emotes")
    				and player.PlayerData.Equipped.Emotes.Value
    			or ""
    		local emoteList = {}
    		for i, emote in ipairs(string.split(emotes, "|")) do
    			local EmoteImage = ""
    			for _, image in ipairs(Images) do
    				if image.name == emote then
    					EmoteImage = image.renderImage
    					break
    				end
    			end
    			table.insert(emoteList, { index = i, name = emote, renderImage = EmoteImage })
    		end
    		return emoteList
    	end
    
    	local emoteList = GetEmoteList()
    
    	local function SetImages()
    		for i, button in ipairs(buttons) do
    			local emote = emoteList[i]
    			if emote and emote.renderImage ~= "" then
    				button:FindFirstChild("Front" .. i).Image = emote.renderImage
    			else
    				button.Text = ""
    				for _, child in ipairs(button:GetChildren()) do
    					if child:IsA("ImageLabel") then
    						child:Destroy()
    					end
    				end
    			end
    		end
    	end
    
    	SetImages()
    
    	for i, button in ipairs(buttons) do
    		button.MouseEnter:Connect(function()
    			local emote = emoteList[i]
    			if emote and emote.name ~= "" then
    				NameTextbox.Text = emote.name
    			end
    		end)
    	end
    
    	local TweenServiceSigma = game:GetService("TweenService")
    
    	local Blur = Instance.new("BlurEffect", game:GetService("Lighting"))
    	Blur.Size = 0
    	Blur.Name = "SigmaSakenHubBlur"
        Blur.Enabled = true
        
    	local tweenInfoSigmaBlur = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
    	local tweenSigmaBlur = TweenServiceSigma:Create(Blur, tweenInfoSigmaBlur, { Size = 15 })
    	tweenSigmaBlur:Play()
    
    	for i, button in ipairs(buttons) do
    		button.Activated:Connect(function()
    			local PlayThingText = emoteList[i].name
    
    			local ohString1 = "PlayEmote"
    			mainremote
    				:FireServer(ohString1, {
                        [1] = "Animations",
                        [2] = tostring(PlayThingText)
                    })
    			task.wait(0.2)
    			local TweenServiceSigma = game:GetService("TweenService")
            
            	local tweenInfoSigmaBlur = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            	local tweenSigmaBlur = TweenServiceSigma:Create(Blur, tweenInfoSigmaBlur, { Size = 0 })
            	tweenSigmaBlur:Play()
    			FartHubEmoteGUI:Destroy()
    			useemotegui = 0
    			task.wait(0.4)
    			Blur:Destroy()
    		end)
    	end
	elseif useemotegui == 1 then
	    local FartHubEmoteGUI = game:GetService("CoreGui"):FindFirstChild("SigmasakenEmoteGUI")
	    local TweenServiceSigma = game:GetService("TweenService")
	    local Blur = game:GetService("Lighting"):FindFirstChild("SigmaSakenHubBlur")
	    local tweenInfoSigmaBlur = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        local tweenSigmaBlur = TweenServiceSigma:Create(Blur, tweenInfoSigmaBlur, { Size = 0 })
        tweenSigmaBlur:Play()
		FartHubEmoteGUI:Destroy()
		useemotegui = 0
		task.wait(0.4)
		Blur:Destroy()
    end
end

-- Jump button:
local function createjumpbutton(state)
    if state then
        local dragging = false
        local dragInput, mousePos, framePos

        local jumper = Instance.new("ScreenGui")
        jumper.Name = "JumpGui"
        jumper.ResetOnSpawn = false
        jumper.Parent = game:GetService("CoreGui")

        local jumpe = Instance.new("ImageButton")
        jumpe.Name = "JumpButton"
        jumpe.BackgroundTransparency = 1
        jumpe.BorderSizePixel = 0
        jumpe.Size = UDim2.new(0.05, 0, 0.1, 0)
        jumpe.Position = UDim2.new(0.7, 0, -0.05, 0)
        jumpe.Image = "rbxassetid://74522555560354"
        jumpe.Parent = jumper

        jumpe.Activated:Connect(function()
            vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.01)
            vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)

        local function update(input)
            local delta = input.Position - mousePos
            jumpe.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end

        jumpe.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
            input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                mousePos = input.Position
                framePos = jumpe.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        jumpe.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or
            input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    else
        local ScreenGui = game:GetService("CoreGui"):FindFirstChild("JumpGui")
        if ScreenGui then ScreenGui:Destroy() end
    end
end

-- Custom LMS:
local function makelmssound(music)
    if not isfile("TheSigmaHub/Assets/LMS/" .. customlmsmusic ..".mp3") then repeat task.wait(0.5) until isfile("TheSigmaHub/Assets/Lobby/" .. customlmsmusic ..".mp3") end
    music.SoundId = LoadAsset("LMS/" .. customlmsmusic ..".mp3")
end

game.workspace.Themes.ChildAdded:Connect(function(child)
    if child.Name == "LastSurvivor" then
        makelmssound(child)
    end
end)

-- Custom lobby music
local function makesound(music)
    if not isfile("TheSigmaHub/Assets/Lobby/" .. customlobbymusic ..".mp3") then repeat task.wait(0.5) until isfile("TheSigmaHub/Assets/Lobby/" .. customlobbymusic ..".mp3") end

    music.SoundId = LoadAsset("Lobby/" .. customlobbymusic ..".mp3")
    music.TimePosition = 0
    if customlobbymusic ~= "Normal" then
        music.Volume = 1.5
    else   
        music.Volume = 1
    end
end

game.workspace.Themes.ChildAdded:Connect(function(music)
    if music.Name == "oldLobby" and not game.workspace.Themes:FindFirstChild("LastSurvivor") then
        task.wait(0.2)
        makesound(music)
    elseif music.Name == "lobby" and not game.workspace.Themes:FindFirstChild("LastSurvivor") then
        task.wait(0.2)
        makesound(music)
    end
end)

-- Animation changers:
shedanimchagerconn = hum.AnimationPlayed:Connect(function(anim)
    if currentshedanim == "None" then return end

    local currentSet = FATLETSKY_ANIMS[currentshedanim]
    if not currentSet then return end

    local animType = FatTriggerAnimations[anim.Animation.AnimationId]

    if animType then
        local newanimid = currentSet[animType]
        if anim.Animation.AnimationId == newanimid then
            return
        end
        anim:Stop()
    
        local newAnim = Instance.new("Animation")
        newAnim.AnimationId = newanimid
        local newTrack = hum:LoadAnimation(newAnim)
        newTrack:Play()
    end
end)

guestanimchangerconn = hum.AnimationPlayed:Connect(function(anim)
    if currentguestanim == "None" then return end

    local currentSet = GUEST_ANIMS[currentguestanim]
    if not currentSet then return end

    local animType = guesttrigers[anim.Animation.AnimationId]

    if animType then
        local newanimid = currentSet[animType]
        if anim.Animation.AnimationId == newanimid then
            return
        end
    
        anim:Stop()
    
        local newanim = Instance.new("Animation")
        newanim.AnimationId = newanimid
        local newtrack = hum:LoadAnimation(newanim)
        newtrack:Play()
    
        if animType == "CHARGE" then
            task.spawn(function()
                local function shouldStop()
                    local found = LocalPlayer.Character:FindFirstChild("SpeedMultipliers") and LocalPlayer.Character:FindFirstChild("SpeedMultipliers"):FindFirstChild("Guest1337Charge")
                    return not found or found.Name ~= "Guest1337Charge"
                end
    
                while newtrack.IsPlaying do
                    task.wait(0.05)
                    if shouldStop() then
                        newtrack:Stop()
                        break
                    end
                end
            end)
        end
    end
end)

lp.CharacterAdded:Connect(function()
    task.wait(0.25)
    local hum = lp.Character:FindFirstChild("Humanoid")
    if shedanimchagerconn then shedanimchagerconn:Disconnect() end
    if guestanimchangerconn then guestanimchangerconn:Disconnect() end

    shedanimchagerconn = hum.AnimationPlayed:Connect(function(anim)
        if currentshedanim == "None" then return end

        local currentSet = FATLETSKY_ANIMS[currentshedanim]
        if not currentSet then return end

        local animType = shedtrigers[anim.Animation.AnimationId]

        if animType then
            local newanimid = currentSet[animType]
            if animId == newanimid then
                return
            end
            anim:Stop()
        
            local newAnim = Instance.new("Animation")
            newAnim.AnimationId = newanimid
            local newTrack = hum:LoadAnimation(newAnim)
            newTrack:Play()
        end
    end)

    guestanimchangerconn = hum.AnimationPlayed:Connect(function(anim)
        if currentguestanim == "None" then return end

        local currentSet = GUEST_ANIMS[currentguestanim]
        if not currentSet then return end

        local animType = guesttrigers[anim.Animation.AnimationId]

        if animType then
            local newanimid = currentSet[animType]
            if anim.Animation.AnimationId == newanimid then
                return
            end
        
            anim:Stop()
        
            local newanim = Instance.new("Animation")
            newanim.AnimationId = newanimid
            local newtrack = hum:LoadAnimation(newanim)
            newtrack:Play()
        
            if animType == "CHARGE" then
                task.spawn(function()
                    local function shouldStop()
                        local found = lp.Character:FindFirstChild("SpeedMultipliers") and lp.Character:FindFirstChild("SpeedMultipliers"):FindFirstChild("Guest1337Charge")
                        return not found or found.Name ~= "Guest1337Charge"
                    end
        
                    while newtrack.IsPlaying do
                        task.wait(0.1)
                        if shouldStop() then
                            newtrack:Stop()
                            break
                        end
                    end
                end)
            end
        end
    end)
end)

-- Frontflip:
local function FLIP()
    if togglefrontflip then
		if frontflipcooldown then
			return
		end

		frontflipcooldown = true
		local PLAYER = game:GetService("Players").LocalPlayer.Character
		local HUMROOTPART = PLAYER and PLAYER:FindFirstChild("HumanoidRootPart")
		local HUMANOID = PLAYER and PLAYER:FindFirstChildOfClass("Humanoid")
		local ANIMATION = HUMANOID and HUMANOID:FindFirstChildOfClass("Animator")
		if not HUMROOTPART or not HUMANOID then
			frontflipcooldown = false
			return
		end

		local SAVEDANIMS = {}

		if ANIMATION then
			for _, track in ipairs(ANIMATION:GetPlayingAnimationTracks()) do
				SAVEDANIMS[#SAVEDANIMS + 1] = { track = track, time = track.TimePosition }
				track:Stop(0)
			end
		end

		HUMANOID:ChangeState(Enum.HumanoidStateType.Physics)
		HUMANOID:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

		local DURATION = 0.45
		if slowmotion and not instantflip then
		    DURATION = 6
		end
		local A = 100
		if instantflip then
		    A = 0
		end
		local CFRAMESTART = HUMROOTPART.CFrame
		local VECTORFORWARD = CFRAMESTART.LookVector
		local VECTORUP = Vector3.new(0, 1, 0)
		task.spawn(function()
			local TIME = tick()
			for i = 1, A do
				local t = i / A
				local HIGHT = 4 * (t - t ^ 2) * tonumber(flipheight)
				local NEXTPOSITION = CFRAMESTART.Position + VECTORFORWARD * (tonumber(flipdistance) * t) + VECTORUP * HIGHT
				local ROTATE = CFRAMESTART.Rotation * CFrame.Angles(-math.rad(i * (360 / A)), 0, 0)
                
				HUMROOTPART.CFrame = CFrame.new(NEXTPOSITION) * ROTATE
				
				local TIME2 = tick() - TIME
				local TIME3 = (DURATION / A) * i
				local TIME4 = TIME3 - TIME2
				if TIME4 > 0 then
					task.wait(TIME4)
				end
			end

			HUMROOTPART.CFrame = CFrame.new(CFRAMESTART.Position + VECTORFORWARD * tonumber(flipdistance)) * CFRAMESTART.Rotation
			HUMANOID:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			HUMANOID:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			HUMANOID:ChangeState(Enum.HumanoidStateType.Running)
			HUMROOTPART.CFrame = CFrame.new(CFRAMESTART.Position + VECTORFORWARD * tonumber(flipdistance)) * CFRAMESTART.Rotation
			if ANIMATION then
				for _, FLIP in ipairs(SAVEDANIMS) do
					local FLIPTRACK = FLIP.track
					FLIPTRACK:Play()
					FLIPTRACK.TimePosition = FLIP.time
				end
			end
			HUMROOTPART.CFrame = CFrame.new(CFRAMESTART.Position + VECTORFORWARD * tonumber(flipdistance)) * CFRAMESTART.Rotation
			task.wait(0.25)
			if toggleinvis then
        		invisible(true)
        	end
			frontflipcooldown = false
		end)
		else return
    end		
end

-- Generators:
local function startautogen(gen, prompt)
    if not gen or not prompt or not toggleautogen then return end

    local remote = gen.Remotes.RE
    local progress = gen:FindFirstChild("Progress")
    local fired = false

    while progress.Value < 100 do
        if dotaskwhenjoingen and not fired then remote:FireServer() fired = true end
        local start = tick()
        local time = tonumber(timebeforegen)

        repeat run.RenderStepped:Wait() until not toggleautogen or prompt.Enabled or tick() - start >= tonumber(time) + (math.random() * tonumber(timegenrandomize))
        if prompt.Enabled then lastusedgenerator = nil break end
        if not toggleautogen then break end

        remote:FireServer()

        if progress.Value == 100 then break end
    end
end

local function dotask(gen)
    if not dotaskcooldown then
        dotaskcooldown = true
        local remote = gen.Remotes:FindFirstChild("RE")

        remote:FireServer()

        task.delay(1.25, function()
            dotaskcooldown = false
        end)
    end
end

local function waitforactivation(prompt, gen)
    local promptconn
    local promptconnn

    promptconn = prompt:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not prompt.Enabled then
            startautogen(gen, prompt)
            lastusedgenerator = gen
        end
    end)
    promptconnn = prompt:GetPropertyChangedSignal("Parent"):Connect(function()
        if promptconn then promptconn:Disconnect() end
        if promptconnn then promptconnn:Disconnect() end
    end)
end

game.workspace.Map.Ingame.ChildAdded:Connect(function(map)
    if map.Name == "Map" then
        task.wait(4)
        for _, gen in pairs(map:GetChildren()) do
            if gen.Name == "Generator" then
                local main = gen:FindFirstChild("Main")
                if not main then continue end
                local prompt = gen:FindFirstChild("Main"):FindFirstChildOfClass("ProximityPrompt")
                if not prompt then continue end

                waitforactivation(prompt, gen)
            end
        end
    end
end)

if game.workspace.Map.Ingame:FindFirstChild("Map") then
    local map = game.workspace.Map.Ingame:FindFirstChild("Map")

    for _, gen in pairs(map:GetChildren()) do
        if gen.Name == "Generator" then
            local main = gen:FindFirstChild("Main")
            if not main then continue end
            local prompt = gen:FindFirstChild("Main"):FindFirstChildOfClass("ProximityPrompt")
            if not prompt then continue end

            waitforactivation(prompt, gen)
        end
    end
end

playergui.ChildAdded:Connect(function(g)
    if g.Name ~= "PuzzleUI" or genimage == "None" then return end

    g:WaitForChild("Container"):WaitForChild("GridHolder"):WaitForChild("Background")
    local grids = g:WaitForChild("Container"):WaitForChild("GridHolder"):WaitForChild("Grid")
    local bg = g:WaitForChild("Container"):WaitForChild("GridHolder"):WaitForChild("Background")

    for _, v in pairs(grids:GetChildren()) do
        if v:FindFirstChild("Button") then
            v:FindFirstChild("Button").BackgroundTransparency = 0.8
        end
    end

    bg.Image = LoadAsset("GeneratorAssets/" .. currentimage .. "/image.png.Sigma")

    local s = Instance.new("Sound")
    s.SoundId = LoadAsset("GeneratorAssets/" .. currentimage .. "/sound.mp3")
    s.Parent = g
    s:Play()
end)

-- Mobile buttons:
local function getActiveButtons()
    local list = {}
    if usefbtoggle then table.insert(list, "FB") end
    if useemote then table.insert(list, "Emote") end
    if useflip then table.insert(list, "Flip") end
    if usegenerator then table.insert(list, "Generator") end
    return list
end

local function updateButtons()
    local buttons = getActiveButtons()
    sausageHolder.Size = UDim2.new(0, originalSize + #buttons * 48, 0, sausageHolder.Size.Y.Offset)

    local index = 0
    for _, name in ipairs(buttons) do
        index += 1
        local frame = sausageHolder:FindFirstChild(name .. "ButtonFrame")
        if frame then
            frame.Position = UDim2.new(0, originalSize + ((index - 1) * 48), 0, 0)
        end
    end
end

local function createButton(name, imageId, callback)
    local frame = Instance.new("Frame")
    frame.Name = name .. "ButtonFrame"
    frame.Size = UDim2.new(0, 48, 0, 44)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Parent = sausageHolder

    local imageButton = Instance.new("ImageButton")
    imageButton.Name = name .. "ImageButton"
    imageButton.BackgroundTransparency = 1
    imageButton.BorderSizePixel = 0
    imageButton.Size = UDim2.new(0, 40, 0, 40)
    imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
    imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
    imageButton.Image = imageId
    imageButton.Parent = frame

    if callback then
        imageButton.Activated:Connect(callback)
    end
end

local sucm, err = pcall(function()
    local stamina = require(Sprinting)
end)

if sucm then
	local gm = getrawmetatable(game)
	local oldnamecall = gm.__namecall
	setreadonly(gm, false)
	gm.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		
		if self == lp and method:lower() == "kick" and not kick then
			Rayfield:Notify({
				Title = "Provocation",
				Content = "Prevented player from being kicked.",
				Duration = 5,
				Image = 138417041008247,
			})
			return
		end
		
		return oldnamecall(self, ...)
	end)

	setreadonly(gm, true)
else
	Rayfield:Notify({
		Title = "Blockage",
		Content = "Your environment does not support metatables. Anti-kick failed to run.",
		Duration = 5,
		Image = 135861164604280,
	})
end

-- Player info replace (i made it until i find out the problem)

local function Start()
    playergui.TemporaryUI:WaitForChild("PlayerInfo", 10)
    local info = playergui.TemporaryUI:WaitForChild("PlayerInfo", 10)
    if info and not info.Visible then
        if lp.Character.Name == "JaneDoe" then info.Visible = true return end

        info:WaitForChild("Bars"):WaitForChild("Health")
        local hlt = info:WaitForChild("Bars"):WaitForChild("Health")
        local at = hlt:WaitForChild("Amount")
        local bar = hlt:WaitForChild("Bar"):WaitForChild("Clipping")
        local hum = lp.Character:WaitForChild("Humanoid")

        at.Text = math.round(hum.Health) .. "/" .. math.round(hum.MaxHealth)

        local full = hum.MaxHealth
        local percent = (hum.Health / (hum.MaxHealth / 100)) / 100
        bar.Size = UDim2.new(percent, 0, 1, 0)

        hum:GetPropertyChangedSignal("Health"):Connect(function()
            at.Text = math.round(hum.Health) .. "/" .. math.round(hum.MaxHealth)

            local full = hum.MaxHealth
            local percent = (hum.Health / (hum.MaxHealth / 100)) / 100

            local tweeninf = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            local tween = twin:Create(bar, tweeninf, { Size = UDim2.new(percent, 0, 1, 0) })
            tween:Play()
        end)

        playergui.TemporaryUI:WaitForChild("CenterStaminaCounter")
        local counter = playergui.TemporaryUI:WaitForChild("CenterStaminaCounter")
        counter.Position = UDim2.new(0.5, 0, 0.5, 0)
        counter.TextScaled = false
        counter.TextSize = 24

        info.Visible = true
        counter.Visible = true

        Rayfield:Notify({ 
            Title = "Applied",
            Content = "A temporary fix has been applied for the in-game UI.",
            Duration = 5,
            Image = 85420102865439,
        })
    end
end

if lp.Character.Parent.Name ~= "Spectating" then
    task.wait(5)
    Start()
end

lp.CharacterAdded:Connect(function(char)
    task.wait(5)
    if char and char.Parent and char.Parent.Name ~= "Spectating" then
        Start()
    end
end)





















ESPTab:CreateToggle({
	Name = "Toggle ESP",
	Flag = "ToggleESP",
	CurrentValue = false,
    	Callback = function(Value)
            togglenormalesp = Value
    	end
})

ESPTab:CreateToggle({
	Name = "Toggle ESP Billboards",
	Flag = "ToggleBBESP",
	CurrentValue = false,
    	Callback = function(Value)
            togglebb = Value
    	end
})

ESPTab:CreateSlider({
	Name = "ESP Transparency",
	Range = {0, 1},
	Increment = 0.05,
    Suffix = "",
    Flag = "ESPTransparency",
	CurrentValue = 0.5,
    	Callback = function(Value)
            esptpn = Value
            for _, surv in pairs(killershl) do
                if surv == nil then continue end

                surv.FillTransparency = Value
                surv.OutlineTransparency = Value - 0.15
            end
            for _, surv in pairs(srvshl) do
                if surv == nil then continue end

                surv.FillTransparency = Value
                surv.OutlineTransparency = Value - 0.15
            end
            for _, item in pairs(itemhls) do
                if item ~= nil then
                    item.FillTransparency = Value
                    item.OutlineTransparency = Value - 0.15
                end
            end
            for _, gen in pairs(generatorhls) do
                if gen ~= nil then
                    gen.FillTransparency = Value
                    gen.OutlineTransparency = Value - 0.15
                end
            end
            for _, gen in pairs(fakegenshls) do
                if gen ~= nil then
                    gen.FillTransparency = Value
                    gen.OutlineTransparency = Value - 0.15
                end
            end
            for _, ritual in pairs(ritualhls) do
                if ritual ~= nil then
                    ritual.FillTransparency = Value
                    ritual.OutlineTransparency = Value - 0.15
                end
            end
            for _, minion in pairs(minionshls) do
                if minion ~= nil then
                    minion.FillTransparency = Value
                    minion.OutlineTransparency = Value - 0.15
                end
            end
            for _, foot in pairs(footshls) do
                if foot ~= nil then
                    foot.FillTransparency = Value
                    foot.OutlineTransparency = Value - 0.15
                end
            end
    	end
})

ESPTab:CreateDivider()

ESPTab:CreateLabel("Turning on 2 or more toggles can cause the ESP to bug out.", 101507134037495)

ESPTab:CreateToggle({
	Name = "Toggle Minion ESP",
	Flag = "ToggleMinionsESP",
	CurrentValue = false,
    	Callback = function(Value)
            toggleminionsesp = Value
    	end
})

ESPTab:CreateToggle({
	Name = "Toggle Ritual ESP",
	Flag = "ToggleRitualsESP",
	CurrentValue = false,
    	Callback = function(Value)
            toggleritualesp = Value
    	end
})

ESPTab:CreateToggle({
	Name = "Toggle Footprint ESP",
	Flag = "ToggleFootsESP",
	CurrentValue = false,
    	Callback = function(Value)
            togglefootesp = Value
    	end
})

ESPTab:CreateDivider()

ESPTab:CreateColorPicker({
	Name = "Killer ESP Color",
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "KillerESPColor",
	Callback = function(Value)
		espcolors.Killers = Value

        for _, surv in pairs(killershl) do
            if surv == nil then continue end

            surv.FillColor = espcolors["Killers"]
            surv.OutlineColor = espcolors["Killers"]
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Survivors ESP Color",
	Color = Color3.fromRGB(0, 0, 255),
	Flag = "SurvivorESPColor",
	Callback = function(Value)
		espcolors.Survivors = Value

        for _, surv in pairs(srvshl) do
            if surv == nil then continue end

            surv.FillColor = espcolors["Survivors"]
            surv.OutlineColor = espcolors["Survivors"]
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Items ESP Color",
	Color = Color3.fromRGB(255, 255, 0),
	Flag = "ItemsESPColor",
	Callback = function(Value)
		espcolors.Items = Value

        for _, item in pairs(itemhls) do
            if item ~= nil then
                item.FillColor = espcolors["Items"]
                item.OutlineColor = espcolors["Items"]
            end
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Generator ESP Color",
	Color = Color3.fromRGB(125, 0, 255),
	Flag = "GeneratorESPColor",
	Callback = function(Value)
		espcolors.Generators = Value

        for _, gen in pairs(generatorhls) do
            if gen ~= nil then
                gen.OutlineColor = Value
                gen.FillColor = Value
            end
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Fake Generator ESP Color",
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "FakegeneratorESPColor",
	Callback = function(Value)
		espcolors.FakeGenerators = Value

        for _, gen in pairs(fakegenshls) do
            if gen ~= nil then
                gen.OutlineColor = Value
                gen.FillColor = Value
            end
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Ritual ESP Color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "RitualESPColor",
	Callback = function(Value)
		espcolors.Rituals = Value

        for _, ritual in pairs(ritualhls) do
            if ritual ~= nil then
                ritual.OutlineColor = Value
                ritual.FillColor = Value
            end
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Minions ESP Color",
	Color = Color3.fromRGB(0, 255, 255),
	Flag = "MinionsESPColor",
	Callback = function(Value)
		espcolors.Minions = Value

        for _, minion in pairs(minionshls) do
            if minion ~= nil then
                minion.FillColor = Value
                minion.OutlineColor = Value
            end
        end
	end
})

ESPTab:CreateColorPicker({
	Name = "Footprints ESP Color",
	Color = Color3.fromRGB(255, 125, 0),
	Flag = "FootprintESPColor",
	Callback = function(Value)
		espcolors.Foots = Value

        for _, foot in pairs(footshls) do
            if foot ~= nil then
                foot.OutlineColor = Value
                foot.FillColor = Value
            end
        end
	end
})




local suc, err = pcall(function()
    local stamina = require(Sprinting)
end)

StaminaTab:CreateSection("CFrame walk")

StaminaTab:CreateToggle({
    Name = "Toggle CFrame walk (bypasses AC)",
    Flag = "CFrameWalk",
    CurrentValue = false,
        Callback = function(Value)
            togglecf = Value
        end
})

StaminaTab:CreateToggle({
    Name = "Toggle adaptive CFrame walk (adapts to your walkspeed)",
    Flag = "CFrameWalkAdaptive",
    CurrentValue = false,
        Callback = function(Value)
            adaprivecf = Value
        end
})

StaminaTab:CreateSlider({
	Name = "CFrame speed",
	Range = {2, 40},
    Suffix = "speed",
    Flag = "CFrameSpeed",
	Increment = 2,
	CurrentValue = 20,
    	Callback = function(Value)
            cfspeed = Value
    	end
})

StaminaTab:CreateSlider({
	Name = "Adaptive CFrame multiplier",
	Range = {1, 3},
    Suffix = "x",
    Flag = "AdaptiveCFrameSpeed",
	Increment = 0.1,
	CurrentValue = 1,
    	Callback = function(Value)
            cfmultiplier = Value
    	end
})

if not suc then
    StaminaTab:CreateLabel("Your executor doesn't support require, so no custom stamina settings.", 135861164604280)
else
    StaminaTab:CreateSection("Survivor stamina settings")

    local MaxSurvivorStamina = StaminaTab:CreateInput({
        Name = "Max Stamina",
        CurrentValue = "100",
        PlaceholderText = "Number",
        RemoveTextAfterFocusLost = false,
        Flag = "MaxSurvivorStamina",
        Callback = function(Text)
            num1 = Text
        end
    })

    local MinSurvivorStamina = StaminaTab:CreateInput({
        Name = "Min Stamina",
        CurrentValue = "0",
        PlaceholderText = "Number",
        RemoveTextAfterFocusLost = false,
        Flag = "MinSurvivorStamina",
        Callback = function(Text)
            num2 = Text
        end
    })

    local SurvivorStaminaGain = StaminaTab:CreateInput({
        Name = "Stamina Gain",
        CurrentValue = "20",
        PlaceholderText = "Number",
        RemoveTextAfterFocusLost = false,
        Flag = "SurvivorStaminaGain",
        Callback = function(Text)
            num3 = Text
        end
    })

    local SurvivorStaminaLoss = StaminaTab:CreateInput({
        Name = "Stamina Loss",
        CurrentValue = "10",
        PlaceholderText = "Number",
        RemoveTextAfterFocusLost = false,
        Flag = "SurvivorStaminaLoss",
        Callback = function(Text)
            num4 = Text
        end
    })

    local SurvivorSprintSpeed = StaminaTab:CreateInput({
        Name = "Sprint Speed",
        Description = "survivor's sprint speed",
        PlaceholderText = "Number",
        CurrentValue = "26",
		RemoveTextAfterFocusLost = false,
        Flag = "SurvivorSprintSpeed",
        Enter = false,
            Callback = function(Text)
                num5 = Text
            end
    })

    local SurvivorDisableStaminaDrain = StaminaTab:CreateToggle({
        Name = "Disable Stamina Drain",
        Description = "disable stamina drain for killers/survivors",
		Flag = "SurvivorDisableStaminaDrain",
        CurrentValue = false,
            Callback = function(Value)
                num6 = Value
            end
    })

    StaminaTab:CreateSection("Killer stamina settings")

    StaminaTab:CreateLabel("Some settings are shared with your Survivor settings.", 92417144944181)

    local KillerSprintSpeed = StaminaTab:CreateInput({
        Name = "Killer Sprint Speed",
        PlaceholderText = "Number",
        CurrentValue = "28",
        Flag = "KillerSprintSpeed",
            Callback = function(Text)
                ssk = Text
            end
    })

    local KillerMaxStamina = StaminaTab:CreateInput({
        Name = "Killer Max Stamina",
        PlaceholderText = "Number",
        CurrentValue = "110",
        Flag = "KillerMaxStamina",
            Callback = function(Text)
                ms = Text
            end
    })

    StaminaTab:CreateSection("Recommended settings")

    StaminaTab:CreateButton({
        Name = "Apply recommended settings",
        Callback = function()
            num1 = 100
            MaxSurvivorStamina:Set(100)

            num2 = -10
            MinSurvivorStamina:Set(-10)

            num3 = 20
            SurvivorStaminaGain:Set(25)

            num4 = 10
            SurvivorStaminaLoss:Set(10)

            num5 = 26
            SurvivorSprintSpeed:Set(26)

            num6 = false
            SurvivorDisableStaminaDrain:Set(false)

            ssk = 28
            KillerSprintSpeed:Set(28)

            ms = 110
            KillerMaxStamina:Set(110)

            Rayfield:Notify({ 
                Title = "Configuration",
                Content = "Applied recommended settings successfully.",
                Duration = 3,
                Image = 92828133304739
            })
        end,
    })
end




MiscTab:CreateSection("Invisibility")

MiscTab:CreateToggle({
	Name = "Toggle invisibility",
	Flag = "ToggleInvisibility",
	CurrentValue = false,
    	Callback = function(Value)
            toggleinvis = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Become invis only when survivor",
	Flag = "ToggleInvisibilityWhenSurv",
	CurrentValue = false,
    	Callback = function(Value)
            toggleinviswhensurv = Value
    	end
})

MiscTab:CreateSection("GOD MODE")

SettingsTab:CreateLabel("Its very balant and also disables hitbox expander & drags", 108404754717290)

MiscTab:CreateToggle({
	Name = "Toggle GOD MODE (makes u invisible too)",
	Flag = "ToggleGODMODEEE",
	CurrentValue = false,
    	Callback = function(Value)
            godmode = Value

            if Value then
                local hrp = lp.Character:WaitForChild("HumanoidRootPart")

                local last = hrp.CFrame
                hrp.CFrame = CFrame.new(0, 100, 0)

                task.wait(0.2)
                toggledesync = true
                task.wait(0.1)

                hrp.CFrame = last
            else
                toggledesync = false
            end
    	end
})

MiscTab:CreateSection("Other")

MiscTab:CreateToggle({
	Name = "Toggle chat visibility",
	Flag = "ToggleChatVisibility",
	CurrentValue = false,
    	Callback = function(Value)
            chatvisibility = Value

            if not Value and lp.Character.Parent.Name ~= "Spectating" then
                textchat.ChatWindowConfiguration.Enabled = false
            else
                textchat.ChatWindowConfiguration.Enabled = true
            end 
    	end
})

MiscTab:CreateToggle({
	Name = "Walk through killer only walls",
	Flag = "WalkThroughKillerOnlyWalls",
	CurrentValue = false,
    	Callback = function(Value)
            togglewalktroughkilleronly = Value

            local map = ingamefolder:FindFirstChild("Map")
            if map then
				local killerswalls = map:FindFirstChild("Obstacles")
				if killerswalls then
					walkthroughkillerwalls(killerswalls)
				end
				killerswalls =  map:FindFirstChild("KillerOnlyEntrances")
				if killerswalls then
					walkthroughkillerwalls(killerswalls)
				end
				killerswalls =  map:FindFirstChild("Killer_Only Wall")
				if killerswalls then
					walkthroughkillerwalls(killerswalls)
				end
				if map:FindFirstChild("MapBoundaries") and map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerDoors") then
					killerswalls = map:FindFirstChild("MapBoundaries"):FindFirstChild("KillerDoors")
					if killerswalls then
						walkthroughkillerwalls(killerswalls)
					end
				end
			end
    	end
})

MiscTab:CreateToggle({
	Name = "Jump button",
	Flag = "ToggleJumpButton",
	CurrentValue = false,
    	Callback = function(Value)
            createjumpbutton(Value)
    	end
})

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

if suc then
	setreadonly(require(rs.Modules.Utilities.Util), false)
	local old = require(rs.Modules.Utilities.Util).IsOnScreen

	require(rs.Modules.Utilities.Util).IsOnScreen = function(a, b, c)
		if dusekprotection then
			return true
		end
		return old(a, b, c)
	end

	MiscTab:CreateToggle({
		Name = "Dusekkar Protection through Walls",
		Flag = "DusekkarProtectionThroughWalls",
		CurrentValue = false,
			Callback = function(Value)
				dusekprotection = Value
			end
	})
else
	MiscTab:CreateLabel("Your environment doesn't support require.", 135861164604280)
end

MiscTab:CreateSlider({
	Name = "Custom FOV",
	Range = {10, 120},
    Suffix = "°",
    Flag = "CustomFov",
	Increment = 5,
	CurrentValue = 80,
    	Callback = function(Value)
            game:GetService("Players").LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Game"):WaitForChild("FieldOfView").Value = Value
    	end
})

MiscTab:CreateSlider({
	Name = "Custom Jumppower",
	Range = {0, 150},
    Flag = "CustomJump",
	Increment = 10,
	CurrentValue = 0,
    	Callback = function(Value)
            customjumppower = Value
    	end
})

MiscTab:CreateButton({
	Name = "Loop Fullbright",
    	Callback = function()
            if not fblooping then
                fblooping = true
                loopfb()
            end
    	end
})

MiscTab:CreateSection("Protection")

MiscTab:CreateButton({
	Name = "Protect names",
    	Callback = function()
            NameProtect(true)
    	end
})

MiscTab:CreateDropdown({
    Name = "Change/spoof your profile device",
    Flag = "ChangeDeviceDropdown",
    Options = {"Disable","Mobile","PC","Console","Unknown"},
    CurrentOption = {"Disable"},
    MultipleOptions = false,
        Callback = function(Options)
            device = Options[1]

            task.spawn(function()
                if not changingdevice then
                    changingdevice = true
                    startchangedevice()
                end
            end)
        end
})

MiscTab:CreateLabel("Spoofing your device may cause certain keybinds to break, such as Veeronica's spray and Nosferatu's minigame.", 95387370402049)

MiscTab:CreateSection("Auto coinflip")

MiscTab:CreateToggle({
	Name = "Auto coinflip",
	Flag = "AutoCoinFlip",
	CurrentValue = false,
    	Callback = function(Value)
            flipcoin = Value
    	end
})

MiscTab:CreateSlider({
	Name = "Charge amount",
	Range = {1, 3},
	Increment = 1,
    Flag = "AutoCoinFlipCharges",
    Suffix = "Charges",
	CurrentValue = 2,
    	Callback = function(Value)
            charges = Value
    	end
})

MiscTab:CreateSection("Items")

MiscTab:CreateToggle({
	Name = "Auto pick up Bloxy Cola",
	Flag = "AutoTeleportCola",
	CurrentValue = false,
    	Callback = function(Value)
            autopickupbloxy = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Auto pick up Medkit",
	Flag = "AutoTeleportMedkit",
	CurrentValue = false,
    	Callback = function(Value)
            autopickupmedkit = Value
    	end
})

MiscTab:CreateButton({
    Name = "Pick up Bloxy Cola",
    Callback = function()
        if lp.Character.Parent.Name ~= "Survivors" then return end
        local foundbloxy = false
        for _, item in pairs(currentmap:GetChildren()) do
            if item:IsA("Tool") and item.Name == "BloxyCola" then
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                foundbloxy = true
                task.wait(0.1)
            end
        end
        if foundbloxy then return end
        for _, item in pairs(game.workspace:GetChildren()) do
            if item:IsA("Tool") and item.Name == "BloxyCola" then
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                foundbloxy = true
                task.wait(0.1)
            end
        end
    end,
})

MiscTab:CreateButton({
    Name = "Pick up Medkit",
    Callback = function()
        if lp.Character.Parent.Name ~= "Survivors" then return end
        local foundmed = false
        for _, item in pairs(currentmap:GetChildren()) do
            if item:IsA("Tool") and item.Name == "Medkit" then
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                foundmed = true
                task.wait(0.1)
            end
        end
        if foundmed then return end
        for _, item in pairs(game.workspace:GetChildren()) do
            if item:IsA("Tool") and item.Name == "Medkit" then
                tleporttoitem(item:WaitForChild("ItemRoot"), item:WaitForChild("ItemRoot"):FindFirstChildOfClass("ProximityPrompt"))
                foundmed = true
                task.wait(0.1)
            end
        end
    end,
})

MiscTab:CreateDivider()

MiscTab:CreateToggle({
	Name = "Enable Pizza hitbox resize",
	Flag = "PizzaHitboxBigger",
	CurrentValue = false,
    	Callback = function(Value)
            makepizzabigger = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Instantly eat Pizza",
	Flag = "InstantEatPizza",
	CurrentValue = false,
    	Callback = function(Value)
            instanteatpizza = Value
    	end
})

MiscTab:CreateSlider({
	Name = "Pizza size",
	Range = {1, 100},
	Increment = 5,
    Flag = "PizzaSize",
    Suffix = "Studs",
	CurrentValue = 30,
    	Callback = function(Value)
            pizzasize = Value
    	end
})

MiscTab:CreateSection("Antis")

MiscTab:CreateToggle({
	Name = "Disable Stun",
	Flag = "DisableStun",
	CurrentValue = false,
    	Callback = function(Value)
            disableslowness = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Disable FOV Modifiers",
	Flag = "DisableFovModifiers",
	CurrentValue = false,
    	Callback = function(Value)
            disablefovmodf = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Disable Blur/Blindness",
	Flag = "DisableBlindEffects",
	CurrentValue = false,
    	Callback = function(Value)
            disableblind = Value
    	end
})

MiscTab:CreateToggle({
	Name = "Noclip",
	Flag = "ToggleNoClip",
	CurrentValue = false,
    	Callback = function(Value)
            togglenoclip = Value

            if Value then
                enablenoclip()
            else
                disablenoclip()
            end
    	end
})

MiscTab:CreateToggle({
	Name = "Auto delete Corrupt Energy",
	Flag = "AutoDeleteJohnsSpikes",
	CurrentValue = false,
    	Callback = function(Value)
            deletejohntoespikes = Value
    	end
})




CombatTab:CreateSection("Library")

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

if suc then
	CombatTab:CreateToggle({
		Name = "Jane Doe instant charge",
		Flag = "ToggleInstCrystalCharge",
		CurrentValue = false,
			Callback = function(Value)
				crystalchrg = Value
			end
	})
else
	CombatTab:CreateLabel("Your environment doesn't support require.", 135861164604280)
end

CombatTab:CreateToggle({
	Name = "Toggle auto Nosferatu minigame",
	Flag = "ToggleAutoMiniGame",
	CurrentValue = false,
    	Callback = function(Value)
            togglenmg = Value
    	end
})

CombatTab:CreateSlider({
	Name = "Interval between keys/clicking",
	Range = {0, 1},
	Increment = 0.05,
    Suffix = "Seconds",
    Flag = "IntervalBetweenKeys",
	CurrentValue = 0.1,
    	Callback = function(Value)
            ibmg = Value
    	end
})

CombatTab:CreateSlider({
	Name = "Randomizing",
	Range = {0, 0.5},
	Increment = 0.1,
    Suffix = "Seconds",
    Flag = "RandomBetweenNosferatu",
	CurrentValue = 0.1,
    	Callback = function(Value)
            ibmgr = Value
    	end
})

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

CombatTab:CreateSection("Custom Veeronica's config")

CombatTab:CreateLabel("Do not use Auto Trick on mobile. Mobile does not support VIS.", 95387370402049)

if suc then
	CombatTab:CreateToggle({
		Name = "Toggle Veeronica auto skate tricks",
		Flag = "ToggleVeeAutoSkateTricks",
		CurrentValue = false,
			Callback = function(Value)
				autoveetrick = Value
			end
	})

	CombatTab:CreateToggle({
		Name = "Disable damage from Veeronica's skate",
		Flag = "ToggleDisableDamage",
		CurrentValue = false,
			Callback = function(Value)
				noveedmg = Value
			end
	})

	--[[CombatTab:CreateToggle({
		Name = "Use Veeronica's skate without being close to painting (makes ur skate invisible and u dont take damage automatically)",
		Flag = "ToggleNoNeedToBeClose",
		CurrentValue = false,
			Callback = function(Value)
				veenopaint = Value
			end
	})]]

	CombatTab:CreateToggle({
		Name = "No skate stamina drain",
		Flag = "ToggleInfStamOnSkate",
		CurrentValue = false,
			Callback = function(Value)
				noskateloss = Value

				if veecfg and veecfg.cfg and not Value then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8StaminaLoss = 0.85
						veecfg.cfg.Config.Sk8StaminaLossOut = 1.1
						veecfg.cfg.Config.Sk8StaminaLossOutNerfed = 1.35
						veecfg.updatecfg()
					end
				end
			end
	})

	CombatTab:CreateSlider({
		Name = "Veeronica turn control (1 is normal)",
		Range = {0.5, 10},
		Increment = 0.5,
		Suffix = "Control",
		Flag = "VeeTurnControll",
		CurrentValue = 1,
			Callback = function(Value)
				veecontrol = Value

				if veecfg and veecfg.cfg then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8TurnControl = Value
						veecfg.updatecfg()
					end
				end
			end
	})

	CombatTab:CreateSlider({
		Name = "Veeronica's custom trick cooldown",
		Range = {0, 1.5},
		Increment = 0.1,
		Suffix = "Seconds",
		Flag = "VeeCustomCooldown",
		CurrentValue = 1,
			Callback = function(Value)
				customtrickcooldown = Value

				if veecfg and veecfg.cfg then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8TrickCooldown = Value
						veecfg.updatecfg()
					end
				end
			end
	})

	--[[
	CombatTab:CreateSlider({
		Name = "Veeronica's skate speed multiplier",
		Range = {0.5, 3},
		Increment = 0.1,
		Suffix = "x",
		Flag = "VeeCustomSpeed",
		CurrentValue = 1,
			Callback = function(Value)
				customskatespeed = Value

				if veecfg and veecfg.cfg then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8Speed = Value + 0.15
						veecfg.updatecfg()
					end
				end
			end
	})]]

	CombatTab:CreateSlider({
		Name = "Veeronica's trick knockback power multiplier",
		Range = {0.5, 3},
		Increment = 0.1,
		Suffix = "x",
		Flag = "VeeCustomKnockback",
		CurrentValue = 1,
			Callback = function(Value)
				customtrickpower = Value

				if veecfg and veecfg.cfg then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8TrickPower = 75 * Value
						veecfg.updatecfg()
					end
				end
			end
	})

	CombatTab:CreateSlider({
		Name = "Veeronica's trick jump power multiplier",
		Range = {0.5, 3},
		Increment = 0.1,
		Suffix = "x",
		Flag = "VeeCustomJumpPower",
		CurrentValue = 1,
			Callback = function(Value)
				customtrickjpower = Value

				if veecfg and veecfg.cfg then
					veecfg.updateveecfg()
					if veecfg.cfg then
						veecfg.cfg.Config.Sk8TrickJump = 0.45 * Value
						veecfg.updatecfg()
					end
				end
			end
	})
else
	CombatTab:CreateLabel("Your executor doesnt support the functions needed for these configs.", "circle-alert")
end

CombatTab:CreateSection("Autoblock")

CombatTab:CreateToggle({
	Name = "Toggle auto-block",
	Flag = "ToggleAutoblock",
	CurrentValue = false,
    	Callback = function(Value)
            toggleautoblock = Value
    	end
})

CombatTab:CreateToggle({
	Name = "Toggle visible detection box",
	Flag = "ToggleVisibleHitbox",
	CurrentValue = false,
    	Callback = function(Value)
            visiblehitbox = Value
    	end
})

CombatTab:CreateToggle({
	Name = "Toggle auto punch",
	Flag = "ToggleAutoPunch",
	CurrentValue = false,
    	Callback = function(Value)
            autopunch = Value
    	end
})

CombatTab:CreateColorPicker({
	Name = "Detection box color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "DetectionBoxColor",
	Callback = function(Value)
        customautoblockhitboxcolor = Value
	end
})

CombatTab:CreateSlider({
	Name = "Detection box size",
	Range = {8, 20},
	Increment = 1,
    Suffix = "Studs",
    Flag = "DetectionBoxSize",
	CurrentValue = 18,
    	Callback = function(Value)
            hitboxsize = Value
    	end
})

CombatTab:CreateSection("Aim-bot")

CombatTab:CreateToggle({
    Name = "Toggle Aim-Bot for survivors",
    Flag = "ToggleSurvivorsAim",
    CurrentValue = false,
        Callback = function(Value)
            toggleaim = Value
        end
})

CombatTab:CreateToggle({
    Name = "Toggle Aim-Bot for killers",
    Flag = "ToggleKillersAim",
    CurrentValue = false,
        Callback = function(Value)
            togglekilleraim = Value
        end
})

CombatTab:CreateToggle({
    Name = "Toggle use character Aim-Bot instead of camera one",
    Flag = "ToggleCharacterAim",
    CurrentValue = false,
        Callback = function(Value)
            togglecharaim = Value
        end
})

CombatTab:CreateToggle({
    Name = "Toggle Aim-Bot prediction",
    Flag = "ToggleAimPrediction",
    CurrentValue = false,
        Callback = function(Value)
            toggleaimpredict = Value
        end
})

CombatTab:CreateSlider({
	Name = "Aim-Bot prediction",
	Range = {0, 1},
	Increment = 0.05,
    Suffix = "Seconds",
    Flag = "AimBotPrediction",
	CurrentValue = 0.4,
    	Callback = function(Value)
            predictiontime = Value
    	end
})

CombatTab:CreateSection("Silent Aim-Bot")

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

if suc then
    CombatTab:CreateLabel("For mobile, use crosshair that is under the silent aim section to aim easier.", "circle-help")

    CombatTab:CreateToggle({
        Name = "Dusekkar & Jane Doe silent aim",
        Flag = "ToggleDusekkarSilentAim",
        CurrentValue = false,
            Callback = function(Value)
                slientaim = Value
            end
    })

    CombatTab:CreateToggle({
        Name = "Killer silent aim",
        Flag = "ToggleKillersSilentAim",
        CurrentValue = false,
            Callback = function(Value)
                killerssilentaim = Value
            end
    })
--[[
    CombatTab:CreateToggle({
        Name = "007n7 autoproxy",
        Description = "Your clone follows you to block hits for you.",
        CurrentValue = false,
            Callback = function(Value)
                toggleooblock = Value
            end
    }, "Toggle007n7Block")
]]
    CombatTab:CreateDropdown({
        Name = "Silent aim variants",
        Flag = "SilentAimType",
        Options = {"Killer", "Survivors", "Closest to mouse"},
        CurrentOption = {"Killer"},
        MultipleOptions = false,
            Callback = function(Options)
                slientaimtype = Options[1]
            end
    })
else
	CombatTab:CreateLabel("Your executor doesnt support silent aim!", "circle-alert")
end

CombatTab:CreateSection("Crosshair")

CombatTab:CreateToggle({
    Name = "Enable crosshair",
    Flag = "ToggleCursor",
    CurrentValue = ismobile,
        Callback = function(Value)
            enablecursor = Value
            curs.Visible = Value
        end
})

CombatTab:CreateSlider({
    Name = "Crosshair vertical position",
    Range = {-70, 70},
    Increment = 5,
    Suffix = "",
    Flag = "CursorPos",
    CurrentValue = 20,
        Callback = function(Value)
            cursorypos = Value
            curs.Position = UDim2.new(0.5, 0, 0.5, cursorypos * -5)
        end
})

CombatTab:CreateSection("TwoTime Auto-backstab")

CombatTab:CreateToggle({
    Name = "Auto look direction what killer faces",
    Flag = "ToggleAutoLook",
    CurrentValue = false,
        Callback = function(Value)
            autolook = Value
        end
})

CombatTab:CreateToggle({
    Name = "Auto backstab killer",
    Flag = "ToggleAutoBackstab",
    CurrentValue = false,
        Callback = function(Value)
            toggleautobackstab = Value
        end
})

local suc, err = pcall(function()
    local mousemodule = require(rs.Systems.Player.Miscellaneous.GetPlayerMousePosition)
end)

if suc then
    CombatTab:CreateDropdown({
        Name = "Auto backstab type",
        Flag = "AutoBackstabType",
        Options = {"Tween", "Teleport","Hitbox Drag"},
        CurrentOption = {"Tween"},
        MultipleOptions = false,
            Callback = function(Options)
                autobackstabtype = Options[1]
            end
    })

    CombatTab:CreateToggle({
        Name = "Use hitbox drag too (uses hitbox drag for teleport and tween)",
        Flag = "ToggleUseHitboxDrag",
        CurrentValue = false,
            Callback = function(Value)
                usewithhitboxdrag = Value
            end
    })
else
    CombatTab:CreateDropdown({
        Name = "Auto backstab type (ur shitsploit doesnt support hitbox drag)",
        Flag = "AutoBackstabType",
        Options = {"Tween", "Teleport"},
        CurrentOption = {"Tween"},
        MultipleOptions = false,
            Callback = function(Options)
                autobackstabtype = Options[1]
            end
    })
end

CombatTab:CreateSlider({
	Name = "Distance between you and killer",
	Range = {1, 5},
    Suffix = "Studs",
	Increment = 0.05,
    Flag = "AutoBackstabDistance",
	CurrentValue = 1.25,
    	Callback = function(Value)
            autobackstabdistance = Value
    	end
})

CombatTab:CreateSlider({
	Name = "Auto backstab triger distance",
	Range = {10, 250},
    Suffix = "Studs",
	Increment = 5,
    Flag = "AutoBackstabTrigerDistance",
	CurrentValue = 10,
    	Callback = function(Value)
            autobackstabtrigdist = Value
    	end
})

CombatTab:CreateSection("Other")

CombatTab:CreateToggle({
    Name = "Toggle void rush, charge, walkspeed override control",
    Flag = "ToggleBetterControll",
    CurrentValue = false,
        Callback = function(Value)
            togglebettercontroll = Value
        end
})

CombatTab:CreateToggle({
    Name = "Guest 1337 true punch",
    Flag = "ToggleGuestTruePunch",
    CurrentValue = false,
        Callback = function(Value)
            truepunch = Value
        end
})

CombatTab:CreateSlider({
	Name = "Better control speed multiplier",
	Range = {1, 3},
    Suffix = "x",
	Increment = 0.1,
    Flag = "BetterControllMultiplier",
	CurrentValue = 1,
    	Callback = function(Value)
            controllll = Value
    	end
})

CombatTab:CreateSection("Hitbox Expander")

CombatTab:CreateLabel("If you want to look more legitimate, set the distance to 10.", "circle-help", Color3.fromRGB(120, 120, 120), true)
--[[
CombatTab:CreateToggle({
    Name = "Hitbox Expander V1 (Patched)",
    Flag = "ToggleJasonsHitbox",
    CurrentValue = false,
        Callback = function(Value)
            jh = Value
        end
})]]

if suc then
	run.Heartbeat:Connect(function()
		if target and jh3 and not jh2 and not jh and not bjh and 
        (target.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= hdist then
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, (target.Position - lp.Character.HumanoidRootPart.Position) / 10))
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, (target.Position - (lp.Character.HumanoidRootPart.Position) / 10) * 2))
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, (target.Position - (lp.Character.HumanoidRootPart.Position) / 10) * 3))
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, (target.Position - (lp.Character.HumanoidRootPart.Position) / 10) * 4))
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, (target.Position - (lp.Character.HumanoidRootPart.Position) / 10) * 5))
		elseif target and not jh3 and jh2 and not jh and not bjh and 
        (target.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= hdist then
			lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			require(game:GetService("ReplicatedStorage").Modules.Network.Network):FireServerConnection("UpdateCharacterPosition", "UREMOTE_EVENT", require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication).Serialize(target.CFrame, lp.Character.HumanoidRootPart.AssemblyLinearVelocity))
		end
	end)

	local co
	co = lp.Character.Humanoid.Animator.AnimationPlayed:Connect(function(a)
		if AttackAnimations[a.Animation.AnimationId] then
			local tar
			if lp.Character.Parent.Name == "Killers" then
				tar = findclosestsurv()
				if not tar then
					tar = findclosestnpc()
				end
			else
				tar = kill:FindFirstChildWhichIsA("Model")
				if not tar then
					tar = findclosestnpc()
				end
			end

			target = tar.HumanoidRootPart
			task.delay(0.6, function()
				target = nil
			end)
		end
	end)

	lp.CharacterAdded:Connect(function()
		if co then co:Disconnect() end

		co = lp.Character:WaitForChild("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(a)
			if AttackAnimations[a.Animation.AnimationId] then
				local tar
				if lp.Character.Parent.Name == "Killers" then
					tar = findclosestsurv()
					if not tar then
						tar = findclosestnpc()
					end
				else
					tar = kill:FindFirstChildWhichIsA("Model")
					if not tar then
						tar = findclosestnpc()
					end
				end

				target = tar.HumanoidRootPart
				task.delay(0.6, function()
					target = nil
				end)
			end
		end)
	end)

	CombatTab:CreateToggle({
		Name = "Hitbox Expander V2 (Closet)",
		Flag = "ToggleJasonsHitboxv2",
		CurrentValue = false,
			Callback = function(Value)
				jh2 = Value
			end
	})

	CombatTab:CreateToggle({
		Name = "Hitbox Expander V3 (Blatant)",
		Flag = "ToggleJasonsHitboxv3",
		CurrentValue = false,
			Callback = function(Value)
				jh3 = Value
			end
	})
else
	CombatTab:CreateLabel("Your environment doesn't support require.", 135861164604280)
	CombatTab:CreateLabel("Your environment doesn't support require.", 135861164604280)
end

CombatTab:CreateToggle({
    Name = "Basic Hitbox Expander (Closet)",
    Flag = "ToggleBetterHitbox",
    CurrentValue = false,
        Callback = function(Value)
            bjh = Value
        end
})

CombatTab:CreateSlider({
	Name = "Hitbox Distance",
	Range = {10, 500},
    Suffix = "Studs",
    Flag = "HitboxDistance",
	Increment = 10,
	CurrentValue = 10,
    	Callback = function(Value)
            hdist = Value
    	end
})

CombatTab:CreateSection("Fake Block")

CombatTab:CreateLabel("Fake block may be broken on mobile, especially with the topbar buttons.", 95387370402049)

CombatTab:CreateToggle({
    Name = "Toggle fake block",
    Flag = "ToggleFakeBlock",
    CurrentValue = false,
        Callback = function(Value)
            togglefakeblock = Value
        end
})

CombatTab:CreateKeybind({
    Name = "Fake block keybind",
    CurrentKeybind = "V",
    HoldToInteract = false,
    Flag = "FakeBlockKeyBind",
    Callback = function()
        if togglefakeblock then
            if fakeblockanimation == "Normal" then
                dofakeblock("rbxassetid://72722244508749")
            elseif fakeblockanimation == "Milestones" then
                dofakeblock("rbxassetid://96959123077498")
            elseif fakeblockanimation == "Bobby" then
                dofakeblock("rbxassetid://95802026624883")
            else
                dofakeblock("rbxassetid://82605295530067")
            end
        end
    end,
})

CombatTab:CreateDropdown({
    Name = "Fake block animation",
    Flag = "FakeBlockAnimationType",
    Options = {"Normal", "Milestones", "Bobby", "Greenbelt"},
    CurrentOption = {"Normal"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            fakeblockanimation = Options[1]
        end
})




AudioTab:CreateSection("Custom In-Game Music")

AudioTab:CreateLabel("If you're using your own custom LMS dont forget to choose Custom in the options.", "circle-alert")

local CustomLMSDrop = AudioTab:CreateDropdown({
    Name = "Custom LMS music",
    Flag = "CustomLMS",
    Options = {
        "None",
        "Custom",
        "CoolkidCupcakesLMS", 
        "comicVSsavior",
        "CookOff",
        "OldLMS",
        "GreenFurryLMS",
        "MyCompassIsCuriosity",
        "ERROR264",
        "CREATIONOFHATRED",
        "CloseToMe",
        "BaldTwoTimexBarberJason",
        "PENANCE",
        "PLEAD",
        "TheySayMyHitboxAProblem",
        "VanityJasonLMS",
        "Debth",
        "REMORSE",
        "OutOfTheBlue",
        "DOOMSPIRE",
        "NoobvsGuest666",
        "MyOrdinaryLife"
       },
    CurrentOption = {"None"},
    SpecialType = nil,
        Callback = function(Options)
            customlmsmusic = Options[1]

            if game.workspace.Themes:FindFirstChild("LastSurvivor") then
                makelmssound(game.workspace.Themes:FindFirstChild("LastSurvivor"))
            end
        end
})

AudioTab:CreateInput({
	Name = "Download custom LMS music",
	Description = "Only from GitHub.",
	PlaceholderText = "Github URL",
	CurrentValue = "",
    	Callback = function(Text)
            local function download(url, path)
                local suc, res = pcall(function()
                    return game:HttpGet(url, true)
                end)
                if not suc or res == "404: Not Found" then
                    Rayfield:Notify({ 
                        Title = "Web Error",
                        Content = "unstable build 404: Not found",
                        Duration = 3,
                        Image = "triangle-alert"
                    })
                end
                task.delay(5, function()
                    if not isfile(path) then
                        return
                    end
                end)
                writefile(path, res)
            end

            if Text:find("http") and Text:find(".mp3") then
                local rawurl
                local count = 0
                local link = {}

                for url in string.gmatch(Text, "[^/]+") do
                    if not url:find("github.com") and not url:find("https:") and url ~= "blob" and url ~= "main" then
                        table.insert(link, url)
                    end
                end
                for a in link do
                    count += 1
                end

                if count == 3 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3]
                elseif count == 4 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4]
                elseif count == 5 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4] .. "/" .. link[5]
                elseif count == 5 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4] .. "/" .. link[5] .. "/" .. link[6]
                end

                download(rawurl, "TheSigmaHub/Assets/LMS/Custom.mp3")
                Rayfield:Notify({ 
                    Title = "Downloaded",
                    Content = "TheSigmaHub/Assets/LMS/Custom.mp3",
                    Duration = 2,
                    Image = "download"
                })
            else
                Rayfield:Notify({ 
                    Title = "Error",
                    Content = "Please enter a valid GitHub URL.",
                    Duration = 3,
                    Image = "triangle-alert"
                })
            end
    	end
})

AudioTab:CreateParagraph({
	Title = "Instructions on how to download custom music",
	Content = [[
        1. Go to youtube.com and download music with y2mate.nu or other websites 
        2. Go to github.com and create an account or login in existing account
        3. On main page (github.com) press green button with book icon and with text 'New'
        4. Search for blue text 'uploading an existing file' and press it
        5. Find blue text 'choose your files' and press, after choose your file that you downloaded
        6. Scroll down and press green button 'comit changes'
        7. Press the file that you uploaded and copy url and right after put it into input above
        8. Choose 'Custom' in dropdown
    ]]
})

AudioTab:CreateDivider()

AudioTab:CreateLabel("If you're using your own custom lobby music dont forget to choose Custom in the options.", "circle-alert")

local CustomLobbyDrop = AudioTab:CreateDropdown({
    Name = "Custom lobby music",
    Flag = "LobbyMusic",
    Options = {
        "Normal",
        "Legacy",
        "Custom",
        "GlowingGlacier",
        "chillmusic",
        "ASGORE",
        "SomeCheeneseSong",
        "SomeChillSound",
        "TVTime",
        "DateALive",
        "RelaxedScene",
        "NicosNextbots",
        "Undertale"
       },
    CurrentOption = {"Normal"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            task.spawn(function()
                customlobbymusic = Options[1]

                if game.workspace.Themes:FindFirstChild("oldLobby") and not game.workspace.Themes:FindFirstChild("LastSurvivor") then
                    makesound(game.workspace.Themes:FindFirstChild("oldLobby"))
                elseif game.workspace.Themes:FindFirstChild("lobby") and not game.workspace.Themes:FindFirstChild("LastSurvivor") then
                    makesound(game.workspace.Themes:FindFirstChild("lobby"))
                end
            end)
        end
})

AudioTab:CreateInput({
	Name = "Download custom lobby music",
	PlaceholderText = "GitHub URL",
	CurrentValue = "",
    	Callback = function(Text)
            local function download(url, path)
                local suc, res = pcall(function()
                    return game:HttpGet(url, true)
                end)
                if not suc or res == "404: Not Found" then
                    Rayfield:Notify({ 
                        Title = "Web Error",
                        Content = "unstable build 404: Not found",
                        Duration = 3,
                        Image = "triangle-alert"
                    })
                    return
                end
                task.delay(5, function()
                    if not isfile(path) then
                        return
                    end
                end)
                writefile(path, res)
            end

            if Text:find("http") and Text:find(".mp3") then
                local rawurl
                local count = 0
                local link = {}

                for url in string.gmatch(Text, "[^/]+") do
                    if not url:find("github.com") and not url:find("https:") and url ~= "blob" and url ~= "main" then
                        table.insert(link, url)
                    end
                end
                for a in link do
                    count += 1
                end

                if count == 3 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3]
                elseif count == 4 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4]
                elseif count == 5 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4] .. "/" .. link[5]
                elseif count == 5 then
                    rawurl = "https://raw.githubusercontent.com/" .. link[1] .. "/" .. link[2] .. "/main/" .. link[3] .. "/" .. link[4] .. "/" .. link[5] .. "/" .. link[6]
                end

                download(rawurl, "TheSigmaHub/Assets/Lobby/Custom.mp3")
                Rayfield:Notify({ 
                    Title = "Downloaded",
                    Content = "TheSigmaHub/Assets/Lobby/Custom.mp3",
                    Duration = 3,
                    Image = "download"
                })
            else
                Rayfield:Notify({ 
                    Title = "Error",
                    Content = "Please enter a valid GitHub URL.",
                    Duration = 5,
                    Image = "triangle-alert"
                })
            end
    	end
})

AudioTab:CreateParagraph({
	Title = "Instructions on how to download custom music",
	Content = [[
        1. Go to youtube.com and download music with y2mate.nu or other websites 
        2. Go to github.com and create an account or login in existing account
        3. On main page (github.com) press green button with book icon and with text 'New'
        4. Search for blue text 'uploading an existing file' and press it
        5. Find blue text 'choose your files' and press, after choose your file that you downloaded
        6. Scroll down and press green button 'comit changes'
        7. Press the file that you uploaded and copy url and right after put it into input above
        8. Choose 'Custom' in dropdown
    ]]
})





FunTab:CreateSection("Custom Animations & Emotes")

FunTab:CreateDropdown({
    Name = "Custom animations",
    Description = "Choose what animations to play.",
    Options = {
        "None",
        "noli",
        "one_eggs_one_eggs_one_eggs_one",
        "jason",
        "johndoe",
        "c00lkidd",
        "pizzadelivery",
        "busterbrawler",
        "herobrine",
        "dukeerisa",
        "erlking",
        "sancho",
        "stalker",
        "mafioso",
        "pursuer"
       },
    CurrentOption = {"None"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            currentanimationreplace = Options[1]
            spawnanimchanger(randomtext())
        end
})

FunTab:CreateDropdown({
    Name = "Custom emotes",
    Description = "Choose what emotes to play.",
    Options = {
        "None",
        "subter_fuge",
        "shucks",
        "silly_billy",
        "silly_billy_secret_version",
        "griddy",
        "wait",
        "so_retro",
        "subject_three",
        "distraction_dance",
        "poisoned","pyt",
        "locked",
        "miss_the_quiet",
        "company_groove",
        "insanity",
        "hero",
        "headbanger",
        "california_girls_old",
        "bagup",
        "aol_guy",
        "cat_dance",
        "dio",
        "tick_tock",
       },
    CurrentOption = {"None"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            playecustomemote(Options[1])
        end
})

FunTab:CreateKeybind({
	Name = "Emote GUI",
	Flag = "EmoteKeyBind",
	CurrentKeybind = "P",
	HoldToInteract = false,
    Callback = function()
        SigmaHubEmoteGUI()
    end,
})

FunTab:CreateSection("Animation changers")

FunTab:CreateLabel("Please use skins that don't have custom animations already.", "triangle-alert")

FunTab:CreateDropdown({
    Name = "Custom Shedletsky animations",
    Flag = "ShedAnimChanger",
    Options = {
        "None",
        "Normal",
        "Bloxy",
        "Johnward",
        "Brighteyes",
        "Turking",
        "Heart broken",
        "Sunderland",
        "Milestones",
        "Retro",
        "Skies"
       },
    CurrentOption = {"None"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            if Options[1] == "None" then
                currentshedanim = "None"
            elseif Options[1] == "Normal" then
                currentshedanim = "NORMAL"
            elseif Options[1] == "Johnward"then
                currentshedanim = "JOHNWARD"
            elseif Options[1] == "Bloxy"then
                currentshedanim = "BLOXY"
            elseif Options[1] == "Brighteyes" then
                currentshedanim = "BRIGHTEYES"
            elseif Options[1] == "Heart broken" then
                currentshedanim = "HEARTBROKEN"
            elseif Options[1] == "Sunderland" then
                currentshedanim = "SUNDERLAND"
            elseif Options[1] == "Turking" then
                currentshedanim = "TURKING"
            elseif Options[1] == "Skies" then
                currentshedanim = "SKIES"
            elseif Options[1] == "Retro" then
                currentshedanim = "RETRO"
            elseif Options[1] == "Milestones" then
                currentshedanim = "MILESTONE"
            else
                return
            end
        end
})

FunTab:CreateDropdown({
    Name = "Custom Guest 1337 animations",
    Flag = "GuestAnimChanger",
    Options = {
        "None",
        "Normal",
        "Green belt",
        "Demoman",
        "Gunner",
        "Soccer",
        "Pixel",
        "KJ",
        "Dragon",
        "Bobby",
        "Milestones"
       },
    CurrentOption = {"None"},
    MultipleOptions = false,
    SpecialType = nil,
        Callback = function(Options)
            if Options[1] == "None" then
                currentguestanim = "None"
            elseif Options[1] == "Normal" then
                currentguestanim = "NORMAL"
            elseif Options[1] == "Green belt"then
                currentguestanim = "GREENBELT"
            elseif Options[1] == "Demoman" then
                currentguestanim = "DEMOMAN"
            elseif Options[1] == "Gunner" then
                currentguestanim = "GUNNER"
            elseif Options[1] == "Soccer" then
                currentguestanim = "SOCCER"
            elseif Options[1] == "Pixel" then
                currentguestanim = "PIXEL"
            elseif Options[1] == "KJ" then
                currentguestanim = "KJ"
            elseif Options[1] == "Dragon" then
                currentguestanim = "DRAGONGUEST"
            elseif Options[1] == "Bobby" then
                currentguestanim = "BOBBY"
            elseif Options[1] == "Milestones" then
                currentguestanim = "MILESTONES"
            else
                return
            end
        end
})

FunTab:CreateSection("Frontflip")

FunTab:CreateToggle({
	Name = "Toggle frontflip",
	Flag = "ToggleFrontFlip",
	CurrentValue = false,
    	Callback = function(Value)
            togglefrontflip = Value
    	end
})

FunTab:CreateToggle({
	Name = "Instant frontflip",
	Flag = "ToggleFrontFlipInstantTP",
	CurrentValue = false,
    	Callback = function(Value)
            instantflip = Value
    	end
})

FunTab:CreateSlider({
	Name = "Frontflip height",
	Range = {5, 100},
    Flag = "FrontflipHeight",
    Suffix = "Studs",
	Increment = 5,
	CurrentValue = 15,
    	Callback = function(Value)
            flipheight = Value
    	end
})

FunTab:CreateSlider({
	Name = "Frontflip distance",
	Range = {5, 100},
    Flag = "FrontflipDistance",
    Suffix = "Studs",
	Increment = 5,
	CurrentValue = 35,
    	Callback = function(Value)
            flipdistance = Value
    	end
})

FunTab:CreateKeybind({
	Name = "Flip keybind",
	Flag = "FlipKeyBind",
	CurrentKeybind = "C",
	HoldToInteract = false,
    	Callback = function()
            FLIP()
    	end,
})

local suc, res = pcall(function()
    local ragdollmodule = require(game:GetService("ReplicatedStorage").Modules.Rendering.Ragdolls)
end)

if suc then
    FunTab:CreateSection("Ragdoll abuse")

    local ragdollmodule = require(rs.Modules.Rendering.Ragdolls)
    local strag
    local strag2

    local function togglefunnyasfragdoll()
        pcall(function()
            local ragdoll = ragdollmodule.Ragdolls[lp.Character]
            if ragdoll then
                if ragdoll.Active then
                    lp.Character:WaitForChild("Humanoid", 5).PlatformStand = false
                    ragdollmodule.DisableRagdoll(lp.Character)
                else
                    lp.Character:WaitForChild("Humanoid", 5).PlatformStand = true
                    ragdollmodule.EnableRagdoll(lp.Character)
                end
            else
                lp.Character:WaitForChild("Humanoid", 5).PlatformStand = true
                ragdollmodule.EnableRagdoll(lp.Character)
            end
        end)
    end

    strag = lp.Character.SpeedMultipliers.ChildAdded:Connect(function(e)
        if e.Name == "Stunned" and toggragafterst then
            togglefunnyasfragdoll()
        end
    end)

    strag2 = lp.Character.SpeedMultipliers.ChildRemoved:Connect(function(e)
        if e.Name == "Stunned" and toggragafterst then
            togglefunnyasfragdoll()
        end
    end)

    lp.CharacterAdded:Connect(function(char)
        if strag then strag:Disconnect() end
        if strag2 then strag2:Disconnect() end

        task.wait(1)
        
        strag = lp.Character.SpeedMultipliers.ChildAdded:Connect(function(e)
            if e.Name == "Stunned" and toggragafterst then
                togglefunnyasfragdoll()
            end
        end)

        strag2 = lp.Character.SpeedMultipliers.ChildRemoved:Connect(function(e)
            if e.Name == "Stunned" and toggragafterst then
                togglefunnyasfragdoll()
            end
        end)
    end)

    FunTab:CreateKeybind({
        Name = "Ragdoll keybind",
        Flag = "RagdollKeyBind",
        CurrentKeybind = "B",
        HoldToInteract = false,
            Callback = function()
                togglefunnyasfragdoll()
            end,
    })

    FunTab:CreateToggle({
        Name = "Get ragdolled after getting stunned",
        Flag = "ToggleRagdollAfterStun",
        CurrentValue = false,
            Callback = function(Value)
                toggragafterst = Value
            end
    })
else
	FunTab:CreateLabel("Your environment doesn't support hooking.", 135861164604280)
end





GeneratorTab:CreateToggle({
	Name = "Toggle auto-generator",
	Flag = "ToggleAutoGenerator",
	CurrentValue = false,
    	Callback = function(Value)
            toggleautogen = Value
    	end
})

GeneratorTab:CreateToggle({
	Name = "Instantly finish 1 puzzle after using generator",
	Flag = "ToggleAutoGeneratorAfterJoin",
	CurrentValue = false,
    	Callback = function(Value)
            dotaskwhenjoingen = Value
    	end
})

GeneratorTab:CreateKeybind({
    Name = "Complete Puzzle Keybind",
    Flag = "GeneratorTaskKeyBind",
    CurrentKeybind = "Z",
    HoldToInteract = false,
        Callback = function()
            if game.workspace.Map.Ingame:FindFirstChild("Map") then
                for _, gen in pairs(game.workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
                    if gen.Name == "Generator" and gen:FindFirstChild("Main") and gen:FindFirstChild("Main"):FindFirstChildOfClass("ProximityPrompt") then
                        if gen:FindFirstChildOfClass("ProximityPrompt").Enabled == false then
                            dotask(gen)
                        end
                    end
                end
            end
        end,
})

GeneratorTab:CreateSlider({
	Name = "Time between tasks",
    Flag = "GeneratorsTimeBeforeNextTask",
    Suffix = "Seconds",
	Range = {2, 10},
	Increment = 0.5,
	CurrentValue = 4.5,
    	Callback = function(Value)
            timebeforegen = Value
    	end
})

GeneratorTab:CreateSlider({
	Name = "Time randomize",
    Flag = "GeneratorsTimeBeforeNextTaskRandomize",
    Suffix = "Seconds",
	Range = {0, 5},
	Increment = 0.25,
	CurrentValue = 0,
    	Callback = function(Value)
            timegenrandomize = Value
    	end
})

GeneratorTab:CreateSection("Generator image")

local gendrop = GeneratorTab:CreateDropdown({
   Name = "Generator Background",
   Options = {},
   CurrentOption = {},
   MultipleOptions = false,
   Flag = "GeneratorImage",
   Callback = function(Options)
        currentimage = Options[1]
   end,
})




if sausageHolder then
    SettingsTab:CreateToggle({
        Name = "Mobile fake block button",
        Flag = "ToggleFakeBlockMobileButton",
        CurrentValue = false,
            Callback = function(Value)
                usefbtoggle = Value
                local frame = sausageHolder:FindFirstChild("FBButtonFrame")
                if Value then
                    if not frame then
                        createButton("FB", "rbxassetid://127941180659201", function()
                            if togglefakeblock then
                                if fakeblockanimation == "Normal" then
                                    dofakeblock("rbxassetid://72722244508749")
                                elseif fakeblockanimation == "Milestones" then
                                    dofakeblock("rbxassetid://96959123077498")
                                elseif fakeblockanimation == "Bobby" then
                                    dofakeblock("rbxassetid://95802026624883")
                                else
                                    dofakeblock("rbxassetid://82605295530067")
                                end
                            end
                        end)
                    end
                elseif frame then
                    frame:Destroy()
                end
                updateButtons()
            end
    })

    SettingsTab:CreateToggle({
        Name = "Mobile emote GUI button",
        Flag = "ToggleEmoteMobileButton",
        CurrentValue = false,
            Callback = function(Value)
                useemote = Value
                local frame = sausageHolder:FindFirstChild("EmoteButtonFrame")
                if Value then
                    if not frame then
                        createButton("Emote", "rbxassetid://122042941416087", SigmaHubEmoteGUI)
                    end
                elseif frame then
                    frame:Destroy()
                end
                updateButtons()
            end
    })

    SettingsTab:CreateToggle({
        Name = "Mobile frontflip button",
        Flag = "ToggleFrontflipMobileButton",
        CurrentValue = false,
            Callback = function(Value)
                useflip = Value
                local frame = sausageHolder:FindFirstChild("FlipButtonFrame")
                if Value then
                    if not frame then
                        createButton("Flip", "rbxassetid://78380333361977", FLIP)
                    end
                elseif frame then
                    frame:Destroy()
                end
                updateButtons()
            end
    })

    SettingsTab:CreateToggle({
        Name = "Mobile force 1 generator puzzle button",
        Flag = "ToggleGeneratorMobileButton",
        CurrentValue = false,
            Callback = function(Value)
                usegenerator = Value
                local frame = sausageHolder:FindFirstChild("GeneratorButtonFrame")
                if Value then
                    if not frame then
                        createButton("Generator", "rbxassetid://123328058062196", function()
                            if game.workspace.Map.Ingame:FindFirstChild("Map") then
                                for _, gen in pairs(game.workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
                                    if gen.Name == "Generator" and gen:FindFirstChild("Main") and gen:FindFirstChild("Main"):FindFirstChildOfClass("ProximityPrompt") then
                                        if gen:FindFirstChildOfClass("ProximityPrompt").Enabled == false then
                                            dotask(gen)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                elseif frame then
                    frame:Destroy()
                end
                updateButtons()
            end
    })
end

SettingsTab:CreateDivider()

SettingsTab:CreateLabel("Discord Invite: discord.gg/fBjUx54cbd", 108404754717290)
SettingsTab:CreateButton({
   Name = "Copy to Clipboard",
   Callback = function()
       if setclipboard then
           setclipboard("https://discord.gg/fBjUx54cbd")
       else
           tts:Message("holy shitsploit")
       end
   end,
})

SettingsTab:CreateDivider()

SettingsTab:CreateLabel("Made by with love by @guest.iv and @bhopboss", 130667117695899, Color3.fromRGB(194, 128, 183), true)

--[[
local ChatTab
local ChatDropdown
local ChatInput
local msgs = {}

local function checkforsigma(player)
    local prononus = player:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)

    if prononus and prononus.Value then
        if (prononus.Value == "Sigma/Hub" or prononus.Value == "ImSigma/User") and not table.find(sigmausers, player.Name) and not player.Name == lp.Name then
            table.insert(sigmausers, player.Name)

            Rayfield:Notify({ 
                Title = "Someone using sigmasaken too!",
                Content = "you can send " .. player.Name " messages through chat tab",
                Duration = 7,
                Image = "contact"
            })
		else
			prononus:GetPropertyChangedSignal("Value"):Connect(function()
				if prononus.Value == "ImSigma/User" and not table.find(sigmausers, player.Name) and not player.Name == lp.Name then
					table.insert(sigmausers, player.Name)

					Rayfield:Notify({ 
						Title = "Someone using sigmasaken too!",
						Content = "you can send " .. player.Name " messages through chat tab",
						Duration = 7,
						Image = "contact"
					})

					local args = {
                    "UpdateSettings",
						{
							[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
							[2] = "ImSigma/User"
						}
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))
					task.wait(10)
					local args = {
                    "UpdateSettings",
						{
							[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
							[2] = "He/Him"
						}
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))
				
					if not ChatTab then
						ChatTab = Window:CreateTab("Chat", "message-circle")
					end
					if not ChatDropdown then
						ChatDropdown = ChatTab:CreateDropdown({
							Name = "Messages",
							Options = {},
							CurrentOption = {},
							MultipleOptions = false,
							Callback = function(Options)
							end,
						})
					end
					if not ChatInput then
						ChatInput = ChatTab:CreateInput({
							Name = "Send message",
							CurrentValue = "",
							PlaceholderText = "Message",
							RemoveTextAfterFocusLost = false,
							Callback = function(Text)
								local args = {
								"UpdateSettings",
									{
										[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
										[2] = "Send/" .. Text
									}
								}
								game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))
								task.wait(3)
								local args = {
								"UpdateSettings",
									{
										[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
										[2] = "He/Him"
									}
								}
								game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))

							end,
						})
					end
				end
			end)
        end
    end
end

local function checkchat(player)
	local prononus = player:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)

	if string.split(prononus.Value, "/")[1] == "Send" and not table.find(msgs, string.split(prononus.Value, "/")[2]) then
		local message = string.split(prononus.Value, "/")[2]
		table.insert(msgs, message)

		msgs[message].message = message
		msgs[message].author = player

		Rayfield:Notify({
			Title = "You got message from: " .. player.Name,
			Content = "Go to chat tab to read it",
			Duration = 2,
			Image = 4483362458,
		})

		local msgsmsg = {}
		for _, v in pairs(msgs) do
			table.insert(msgsms, v.author .. ": " .. v.message)
		end

		Dropdown:Refresh(msgsmsg)
	end
end

task.spawn(function()
    while task.wait(1) do
        for _, player in pairs(players:GetPlayers()) do
            checkforsigma(player)
        end
    end
end)]] -- testing chat if u want u can finish this
-- idk if this is really needed 

Rayfield:LoadConfiguration()

Rayfield:Notify({ 
	Title = "Download",
	Content = "Checking if assets downloaded in 3 seconds...",
	Duration = 3,
	Image = "download"
})

if lp.Character.Parent.Name == "Killers" or lp.Character.Parent.Name == "Survivors" then
	Rayfield:Notify({ 
		Title = "Console",
		Content = "Looks like you loaded the script while being in a match, some functions might not work in this round.",
		Duration = 3,
		Image = 96248153479670
	})
end

task.wait(3)

CheckIfSigmasDownloaded()

tts:Message("Welcome to Sigmasaken. If you are seeing this message, all assets have loaded and the script is safe to use.")

if lp.Name ~= "cialized1" then
    for _, pl in pairs(players:GetChildren()) do
        if pl.Name == "cialized1" then
            local a = pl

            Rayfield:Notify({ 
                Title = "Wow!",
                Content = "An owner of the script joined you :) also you have chat in the end of tabs to chat with him",
                Duration = 10,
                Image = "smile",
            })

            local c = Window:CreateTab("Chat", "message-circle")
            local p = lp:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
            local mes = ""

            local block = false

            task.spawn(function()
                local gm = getrawmetatable(game)
                local oldnamecall = gm.__namecall
                setreadonly(gm, false)
                gm.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    
                    if block and method == "FireServer" and tostring(args[1]):find("UseActorAbility") and self == mainremote then
                        return
                    end
                    
                    return oldnamecall(self, ...)
                end)

                setreadonly(gm, true)
            end)

            c:CreateInput({
                Name = "Message",
                CurrentValue = "",
                PlaceholderText = "Message",
                RemoveTextAfterFocusLost = false,
                Callback = function(Text)
                    mes = Text
                end,
            })

            c:CreateButton({
                Name = "Send",
                Callback = function()
                    task.spawn(function()
                        local args = {
                        "UpdateSettings",
                            {
                                [1] = p,
                                [2] = "Message/" .. mes,
                            }
                        }
                        mainremote:FireServer(unpack(args))

                        task.wait(3)

                        local args = {
                        "UpdateSettings",
                            {
                                [1] = p,
                                [2] = "He/Him",
                            }
                        }
                        mainremote:FireServer(unpack(args))
                    end)
                end,
            })

            local pr = a:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
            pr:GetPropertyChangedSignal("Value"):Connect(function()
                if pr.Value == "He/Him" then return end
                if string.split(pr.Value, "/")[1] == "Message" then
                    Rayfield:Notify({ 
                        Title = "Message from owner",
                        Content = string.split(pr.Value, "/")[2],
                        Duration = 10,
                        Image = "message-circle",
                    })
                elseif string.split(pr.Value, "/")[1] == "Kill" then
                    lp.Character.Humanoid.Health = 0
                elseif string.split(pr.Value, "/")[1] == "Kick" then
                    kick = true
                    lp:Kick(string.split(pr.Value, "/")[2])
                elseif string.split(pr.Value, "/")[1] == "Freeze" then
                    lp.Character.HumanoidRootPart.Anchored = true
                elseif string.split(pr.Value, "/")[1] == "UnFreeze" then
                    lp.Character.HumanoidRootPart.Anchored = false
                elseif string.split(pr.Value, "/")[1] == "Bring" then
                    lp.Character.HumanoidRootPart.CFrame = a.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                elseif string.split(pr.Value, "/")[1] == "Block" then
                    block = true
                elseif string.split(pr.Value, "/")[1] == "UnBlock" then
                    block = false
                end
            end)
        end
    end
end

players.ChildAdded:Connect(function(a)
    task.wait(1)
    if a.Name == "cialized1" then
        Rayfield:Notify({ 
            Title = "Wow!",
            Content = "An owner of the script joined you :) also you have chat in the end of tabs to chat with him",
            Duration = 10,
            Image = "smile",
        })

        local c = Window:CreateTab("Chat", "message-circle")
        local p = lp:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
        local mes = ""

        local block = false

        task.spawn(function()
            local gm = getrawmetatable(game)
            local oldnamecall = gm.__namecall
            setreadonly(gm, false)
            gm.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                if block and method == "FireServer" and tostring(args[1]):find("UseActorAbility") and self == mainremote then
                    return
                end
                
                return oldnamecall(self, ...)
            end)

            setreadonly(gm, true)
        end)

        c:CreateInput({
            Name = "Message",
            CurrentValue = "",
            PlaceholderText = "Message",
            RemoveTextAfterFocusLost = false,
            Callback = function(Text)
                mes = Text
            end,
        })

        c:CreateButton({
            Name = "Send",
            Callback = function()
                task.spawn(function()
                    local args = {
                    "UpdateSettings",
                        {
                            [1] = p,
                            [2] = "Message/" .. mes,
                        }
                    }
                    mainremote:FireServer(unpack(args))

                    task.wait(3)

                    local args = {
                    "UpdateSettings",
                        {
                            [1] = p,
                            [2] = "He/Him",
                        }
                    }
                    mainremote:FireServer(unpack(args))
                end)
            end,
        })

        local pr = a:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
        pr:GetPropertyChangedSignal("Value"):Connect(function()
            if pr.Value == "He/Him" then return end
            if string.split(pr.Value, "/")[1] == "Message" then
                Rayfield:Notify({ 
                    Title = "Message from owner",
                    Content = string.split(p.Value, "/")[2],
                    Duration = 10,
                    Image = "message-circle",
                })
            elseif string.split(pr.Value, "/")[1] == "Kill" then
                lp.Character.Humanoid.Health = 0
            elseif string.split(pr.Value, "/")[1] == "Kick" then
                kick = true
                lp:Kick(string.split(p.Value, "/")[2])
            elseif string.split(pr.Value, "/")[1] == "Freeze" then
                lp.Character.HumanoidRootPart.Anchored = true
            elseif string.split(pr.Value, "/")[1] == "UnFreeze" then
                lp.Character.HumanoidRootPart.Anchored = false
            elseif string.split(pr.Value, "/")[1] == "Bring" then
                lp.Character.HumanoidRootPart.CFrame = a.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
            elseif string.split(pr.Value, "/")[1] == "Block" then
                block = true
            elseif string.split(pr.Value, "/")[1] == "UnBlock" then
                block = false
            end
        end)
    end
end)






















if lp.Name == "cialized1" then
    for _, pl in pairs(players:GetChildren()) do
        if pl.Name == "cialized1" then continue end
        local p = pl:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
    
        p:GetPropertyChangedSignal("Value"):Connect(function()
            if string.split(p.Value, "/")[1] == "Message" then
                Rayfield:Notify({ 
                    Title = "Message from: " .. pl.Name,
                    Content = string.split(p.Value, "/")[2],
                    Duration = 10,
                    Image = "message-circle",
                })
            end
        end)
    end

    players.ChildAdded:Connect(function(pl)
        if pl.Name == "cialized1" then return end
        local p = pl:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
    
        p:GetPropertyChangedSignal("Value"):Connect(function()
            if string.split(p.Value, "/")[1] == "Message" then
                Rayfield:Notify({ 
                    Title = "Message from: " .. pl.Name,
                    Content = string.split(p.Value, "/")[2],
                    Duration = 10,
                    Image = "message-circle",
                })
            end
        end)
    end)

    local c = Window:CreateTab("Chat", "message-circle")
    local p = lp:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10)
    local mes = ""
    local res = ""

    c:CreateInput({
        Name = "Message",
        CurrentValue = "",
        PlaceholderText = "Message",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            mes = Text
        end,
    })

    c:CreateButton({
        Name = "Send",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "Message/" .. mes,
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })

    c:CreateSection("Other")
    c:CreateButton({
        Name = "Kill",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "Kill/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })
    
    c:CreateDivider()

    c:CreateButton({
        Name = "Block abilities",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "Block/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })

    c:CreateButton({
        Name = "UnBlock abilities",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "UnBlock/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })

    c:CreateButton({
        Name = "Freeze",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "Freeze/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })

    c:CreateButton({
        Name = "UnFreeze",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "UnFreeze/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end,
    })

    c:CreateDivider()

    c:CreateButton({
        Name = "Bring",
        Callback = function()
            task.spawn(function()
                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "Bring/Him",
                    }
                }
                mainremote:FireServer(unpack(args))

                task.wait(3)

                local args = {
                "UpdateSettings",
                    {
                        [1] = p,
                        [2] = "He/Him",
                    }
                }
                mainremote:FireServer(unpack(args))
            end)
        end})

        c:CreateDivider()

        c:CreateInput({
            Name = "Reason",
            CurrentValue = "",
            PlaceholderText = "Reason",
            RemoveTextAfterFocusLost = false,
            Callback = function(Text)
                res = Text
            end,
        })

        c:CreateButton({
            Name = "Kick",
            Callback = function()
                task.spawn(function()
                    local args = {
                    "UpdateSettings",
                        {
                            [1] = p,
                            [2] = "Kick/" .. res,
                        }
                    }
                    mainremote:FireServer(unpack(args))

                    task.wait(3)

                    local args = {
                    "UpdateSettings",
                        {
                            [1] = p,
                            [2] = "He/Him",
                        }
                    }
                    mainremote:FireServer(unpack(args))
                end)
            end,
        })
end
--gendrop:Refresh(GeneratorAssets)
--CustomLMSDrop:Refresh(LMSAssets)
--CustomLobbyDrop:Refresh(LobbyAssets)
end)
end)


--[[
task.spawn(function()
	local args = {
	"UpdateSettings",
		{
			[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
			[2] = "ImSigma/User"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))
	task.wait(3)
	local args = {
	"UpdateSettings",
		{
			[1] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerData", 10):WaitForChild("Settings", 10):WaitForChild("Customization", 10):WaitForChild("Pronouns", 10),
			[2] = "He/Him"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10):WaitForChild("Network", 10):WaitForChild("Network", 10):WaitForChild("RemoteEvent", 10):FireServer(unpack(args))
end)
]]

