if not game:IsLoaded() then
	print("[Auto-Farm] Waiting game to load...")
	repeat task.wait() until game:IsLoaded()
end

if _G.settings then
	getgenv().settings = _G.settings
elseif isfile("TheSigmaHub/AutoFarmSettings.sigma") then
	getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("TheSigmaHub/AutoFarmSettings.sigma"))
else
	warn("[Auto-Farm]: CRITICAL - No settings, please make sure u got puted settings")
	return
end

if not getgenv().settings then error("[Auto-Fram]: No settings are provided") return end

local players = game:GetService("Players")
local run = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")
local vim = game:GetService("VirtualInputManager")
local pathf = game:GetService("PathfindingService")
local uis = game:GetService("UserInputService")
local textchat = game:GetService("TextChatService")
local lp = players.LocalPlayer
local playergui = lp.PlayerGui
local mainremote = rs.Modules.Network.Network.RemoteEvent

_G.TotalEXP = _G.TotalEXP or 0
_G.TotalMoney = _G.TotalMoney or 0
_G.TotalTasks = _G.TotalTasks or 0
_G.StartedAutofarm = _G.StartedAutofarm or tick()
local gainedexp = 0
local gainedmoney = 0
local dealedtasks = 0

local kill = workspace.Players.Killers
local surv = workspace.Players.Survivors

local scriptdebug = _G.DebugEnabled or false --true
local gencooldown = nil
local going = false
local toggledesync = false
local minions = {}
local sprint
local support

local debugball1
local debugball2
local debughl

local suc, res = pcall(function()
    sprint = require(rs.Systems.Character.Game.Sprinting)
end)

if suc then sprint = require(rs.Systems.Character.Game.Sprinting) support = true end

local AttackAnimations = loadstring(game:HttpGet("https://raw.githubusercontent.com/gopnikjovana/animations-tables/refs/heads/main/atackanimations.luau"))()
local mappoints = loadstring(game:HttpGet("https://raw.githubusercontent.com/gopnikjovana/animations-tables/refs/heads/main/maplooppoints.luau"))()

if support then
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
else
    warn("[Auto-Farm]: Your shitsploit doesnt support metatables hooks, please swith to better one")
end

playergui.Notis.ChildAdded:Connect(function(notif)
    if notif.Name == "ProductPurchaseNotif" and notif:IsA("TextLabel") then
        --if scriptdebug then print("[DEBUG]: Notification added") end
        if notif.Text:find("$5") then
            _G.TotalMoney += 5
            gainedmoney += 5
        end
        if notif.Text:find("15 EXP") then
            _G.TotalEXP += 15
            gainedexp += 15
        end

        if notif.Text:find("$5 & 15 EXP") then
            _G.TotalTasks += 1
            dealedtasks += 1
        end

        if scriptdebug then print("[DEBUG]: Total money: $" .. _G.TotalMoney .. ", Total EXP: " .. _G.TotalEXP) end
    else
        if scriptdebug then print("[DEBUG]: Unknown notification added") end
    end
end)

game.workspace.Themes.ChildAdded:Connect(function(child)
    if child.Name == "LastSurvivor" and lp.Character.Parent.Name == "Survivors" then
        if getgenv().settings.AutoFarmSettings.ResetIfLMS then
            lp.Character.Humanoid.Health = 0
            if scriptdebug then print("[DEBUG]: Reseted because its LMS") end
        end
    end
end)

--+ $5 & 15 EXP & 0.5 Malice: Completed a generator puzzle (-3 seconds)

local function createball(pos, par, name)
    local a = Instance.new("Part")
    a.Shape = Enum.PartType.Ball
    a.Transparency = 0.65
	a.Anchored = true
	a.CanCollide = false
	a.Material = Enum.Material.Neon
    a.Name = name
    a.Size = Vector3.new(1, 1, 1)
    a.Position = pos
    a.Parent = par
end

local function createbarrier(pos, size, rot, par)
    local a = Instance.new("Part")
    a.Transparency = 0.8
	a.Anchored = true
    a.Name = "Barrier"
    a.Size = size
    a.Rotation = rot
    a.Position = pos
    a.Parent = par
end

local function createpoints(map)
    local main
    if workspace:FindFirstChild("LoopPoints") then
        for _, v in pairs(workspace.LoopPoints:GetChildren()) do
            v:Destroy()
        end
        main = workspace:FindFirstChild("LoopPoints")
    else
        main = Instance.new("Folder", workspace)
        main.Name = "LoopPoints"
    end

    local folder1 = Instance.new("Folder", main)
    folder1.Name = "loop1"

    local folder2 = Instance.new("Folder", main)
    folder2.Name = "loop2"

    local folder3 = Instance.new("Folder", main)
    folder3.Name = "loop3"

    local folder4 = Instance.new("Folder", main)
    folder4.Name = "barriers"

    local score = 0
    for _, v in pairs(map["loop1"]) do
        score += 1
        createball(v, folder1, "Point_" .. tostring(score))
    end

    score = 0
    for _, v in pairs(map["loop2"]) do
        score += 1
        createball(v, folder2, "Point_" .. tostring(score))
    end

    score = 0
    for _, v in pairs(map["loop3"]) do
        score += 1
        createball(v, folder3, "Point_" .. tostring(score))
    end
    if map["barriers"] then
        for _, v in pairs(map["barriers"]) do
            createbarrier(v.Position, v.Size, v.Rotation, folder4)
        end
    end
end

local function spawnstaminacontroller()
    local a
    a = playergui.TemporaryUI:WaitForChild("PlayerInfo").Bars.Stamina.Amount:GetPropertyChangedSignal("Text"):Connect(function()
        local text = playergui.TemporaryUI.PlayerInfo.Bars.Stamina.Amount.Text
        local splited = string.split(text, "/")

        local st = getgenv().settings.Stamina.StaminaManagment

        if tonumber(splited[1]) <= tonumber(st.StopSprintStamina) then
            if sprint.IsSprinting then
                if scriptdebug then print("[DEBUG]: Turned off stamina") end
                sprint.IsSprinting = false
                sprint.__sprintedEvent:Fire(false)
                sprint:Toggle(false)
            end
        elseif tonumber(splited[1]) >= tonumber(st.StartSprintStamina)  then
            if not sprint.IsSprinting then
                if scriptdebug then print("[DEBUG]: Turned on stamina") end
                sprint.IsSprinting = true
                sprint.__sprintedEvent:Fire(true)
                sprint:Toggle(true)
            end
        end
    end)

    local c
    c = lp.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
        if lp.Character.Humanoid.MoveDirection.Magnitude ~= 0 then
            local text = playergui.TemporaryUI.PlayerInfo.Bars.Stamina.Amount.Text
            local splited = string.split(text, "/")

            local st = getgenv().settings.Stamina.StaminaManagment

            if sprint.IsSprinting and tonumber(splited[1]) > tonumber(st.StartSprintStamina) and tonumber(splited[1]) <= tonumber(st.StopSprintStamina) then
                if scriptdebug then print("[DEBUG]: Turned on stamina") end
                sprint.IsSprinting = true
                sprint.__sprintedEvent:Fire(true)
                sprint:Toggle(true)
            end
        end
    end)

    local b
    b = playergui.TemporaryUI:WaitForChild("PlayerInfo"):GetPropertyChangedSignal("Visible"):Connect(function()
        if not playergui.TemporaryUI.PlayerInfo.Visible then
            if scriptdebug then print("[DEBUG]: Fixed stamina controller") end
            if a then a:Disconnect() a = nil end
            if b then b:Disconnect() b = nil end
            if c then c:Disconnect() c = nil end
        end
    end)
end

local function sendwebhook(sets)
    local Encode = game:GetService("HttpService")
    local player = game.Players.LocalPlayer
    local http = (http_request or request or syn.request or fluxus and fluxus.request)
    if http then
        local data = {
            ["username"] = sets.name,
            ["avatar_url"] = "https://cdn.discordapp.com/attachments/1492866989884964878/1502750993182359842/ico.png?ex=6a1be02c&is=6a1a8eac&hm=e7bda7adbba006bcdcb1ba6aeeff2f526c208f037ea873f6b9ec0397567e761a&",
            ["embeds"] = sets.embed
        }

        http({
            Url = sets.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = Encode:JSONEncode(data)
        })

        if scriptdebug then print("[DEBUG]: Sent webhook") end
    end
end

local function send(isnormal, data)
    if isnormal then
		local function format(s)
			local m = math.floor(s / 60)
			local scs = s % 60
			return string.format("%02d:%02d", m, scs)
		end
		
        local autotype = getgenv().settings.AutoFarmSettings.PathFindMethod and "Legit" or "Balant"
        local w = getgenv().settings.Webhook
        local embeds = {
            ["title"] = "Finished auto-farm (" .. autotype .. "):",
            ["color"] = 0xb475f2,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ["fields"] = {
{
["name"] = "EXP:",
["value"] = [[Total EXP gained: ]] .. _G.TotalEXP .. [[ 
EXP gained this round: ]] .. gainedexp,
["inline"] = false
},
{
["name"] = "Money:",
["value"] = [[Total money gained: $]] .. _G.TotalMoney .. [[ 
Money gained this round: $]] .. gainedmoney .. [[ 
You have $]] .. lp.PlayerData.Stats.Currency.Money.Value .. [[ money now.]],
["inline"] = false
},
{
["name"] = "Other:",
["value"] = [[Total time of auto-farm: ]] .. format(math.round(tick() - _G.StartedAutofarm)) .. [[ 
Time spent on this round: ]] .. data.time .. [[s 
Total tasks: ]] .. _G.TotalTasks .. [[ 
Tasks made this round: ]] .. dealedtasks .. [[]],
["inline"] = false
},
}
}

        sendwebhook({
            name = w.WebhookName,
            url = w.WebhookLink,
            embed = {embeds},
        })

        gainedmoney = 0
        gainedexp = 0
        dealedtasks = 0
    else
        local w = getgenv().settings.Webhook
        local embeds = {
            ["title"] = "Auto buy (" .. data.type .. "):",
            ["color"] = 0xb475f2,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ["fields"] = {
{
["name"] = "Bought:",
["value"] = [[Bought: ]] .. data.bought .. [[ for $]] .. data.amount .. [[ 
And u have $]] .. data.money .. [[ now.]],
["inline"] = false
},
}
        }

        sendwebhook({
            name = w.WebhookName,
            url = w.WebhookLink,
            embed = {embeds},
        })
    end
end

local function serverhop()
	writefile("TheSigmaHub/AutoFarmSettings.sigma", game:GetService("HttpService"):JSONEncode(getgenv().settings))

    local queue = queue_on_teleport or queueonteleport
    queue([[
        print("[Auto-ServerHOP]: Started waiting til game loaded")
        local start = tick() ;
		repeat task.wait(1) until game:IsLoaded() or tick() - start >= 15

		if tick() - start >= 15 then 
            print("[Auto-Farm-Loader]: Script timeout") 
        elseif game:IsLoaded() then
            print("[Auto-Farm-Loader]: Game loaded")
        end

        task.wait(5)
		
        _G.TotalEXP = ]] .. (_G.TotalEXP or 0) .. [[; 
        _G.TotalMoney = ]] .. (_G.TotalMoney or 0) .. [[; 
        _G.TotalTasks = ]] .. (_G.TotalTasks or 0) .. [[; 
        _G.StartedAutofarm = ]] .. (_G.StartedAutofarm or tick()) .. [[; 

        print("[Auto-Farm-Loader]: Loading script...")

        repeat loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/b81868b59ff466417e341a6f791bde9d6138c0f832cab2dba21c6de70cee5310/download"))() task.wait(10) until getgenv().AutoFarmLoaded
    ]])

    if getgenv().settings.FarmEnd.ServerHopOnLowServer then
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
        end
        function TPReturner()
            local Site;
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0;
            for i,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num > 85 then
                            if ID == tostring(Existing) then
                                Possible = false
                            end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    delfile("NotSameServers.json")
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                        end
                        num = num + 1
                    end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                            wait()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                        wait(4)
                    end
                end
            end
        end

        function Teleport()
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
            end
        end

        Teleport()
    else
        game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
    end
end

game:GetService("GuiService").ErrorMessageChanged:Connect(function(errorr)
    if errorr and errorr ~= "" then
		if lp then
			task.wait()
			serverhop()
		end
    end
end)

local function killerlooksonu(k, v)
    local sets = getgenv().settings.AutoFarmSettings.FarmSettings
    if (k.Position - v.Position).Magnitude > tonumber(sets.SaveFromKillerDist) then return false end

	local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
	params.IgnoreWater = true

	--[[local result = workspace:Raycast(k.Position, v.Position - k.Position, params)

    while result do
        local hit = result.Instance

		if not hit.CanCollide and not hit:IsDescendantOf(v.Parent) then
			table.insert(params.FilterDescendantsInstances, hit)

			result = workspace:Raycast(k.Position, v.Position - k.Position, params)
		else
			break
		end
    end

	if not result or not result.Instance:IsDescendantOf(v.Parent) then
        if scriptdebug then print("[DEBUG]: Bad cast") end
		return false
	end]]

    local dir = (v.Position - k.Position).Unit

    if k.CFrame.LookVector:Dot(dir) > 0.5 then
        if scriptdebug then print("[DEBUG]: Looking") end
        return true
    end
end

local function goto(obj, nttp, checkifneed)
    if obj == nil or not obj:IsA("BasePart") then return end
    going = true

    task.spawn(function()
        vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.05)
        vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end)

    local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
    local hum = lp.Character:FindFirstChild("Humanoid")

    if not hrp then 
        repeat
            task.wait()
        until lp.Character:FindFirstChild("HumanoidRootPart")
        hrp = lp.Character:FindFirstChild("HumanoidRootPart")
    end
    if not hum then 
        repeat
            task.wait()
        until lp.Character:FindFirstChild("HumanoidRootPart")
        hum = lp.Character:FindFirstChild("Humanoid")
    end

    local path = pathf:CreatePath({
        AgentRadius = 3.25,
        AgentHeight = 5,
        AgentCanJump = false
    })

    path:ComputeAsync(hrp.Position, obj.Position)

    if path.Status ~= Enum.PathStatus.Success then
        if scriptdebug then warn("[DEBUG]: Not found path") end
        hrp.CFrame = obj.CFrame
		going = false
        return false
    end

    local points = path:GetWaypoints()

    if scriptdebug then print("[DEBUG]: Starting pathfind") end

    local start = tick()

    if support then
        if support then
            local s = getgenv().settings.Stamina
            if not s.InfStamina then
                sprint.StaminaLoss = tonumber(s.CustomStaminaLoss)
                if scriptdebug then print("[DEBUG]: Set custom stamina loss") end
            end
            if lp.Character.Parent.Name == "Survivors" then
                sprint.SprintSpeed = tonumber(s.CustomSurvivorsRunSpeed)
                if scriptdebug then print("[DEBUG]: Set custom survivor run speed") end
            elseif lp.Character.Parent.Name == "Killers" then
                sprint.SprintSpeed = tonumber(s.CustomKillersRunSpeed)
                if scriptdebug then print("[DEBUG]: Set custom killer run speed") end
            end
            sprint.StaminaGain = tonumber(s.CustomStaminaGain)
            if scriptdebug then print("[DEBUG]: Set custom stamina gain") end
        end

        sprint.IsSprinting = true
        sprint.__sprintedEvent:Fire(true)
        sprint:Toggle(true)
    end

    for _, point in ipairs(points) do
        if scriptdebug then print("[DEBUG]: Going to: " .. tostring(point.Position)) end

        if tick() - start >= tonumber(getgenv().settings.AutoFarmSettings.PathFindTimeOut) then break end

        if checkifneed and kill:FindFirstChildWhichIsA("Model") then
            if killerlooksonu(kill:FindFirstChildWhichIsA("Model").HumanoidRootPart, hrp) then going = false return "RUN" end
        end

        if scriptdebug then
            if not debugball1 then
                debugball1 = Instance.new("Part")
                debugball1.Shape = Enum.PartType.Ball
                debugball1.Transparency = 0.65
                debugball1.Anchored = true
                debugball1.CanCollide = false
                debugball1.Color = Color3.fromRGB(0, 255, 0)
                debugball1.Material = Enum.Material.Neon
                debugball1.Name = "MovingTo"
                debugball1.Size = Vector3.new(1, 1, 1)
                debugball1.Position = point.Position
                debugball1.Parent = workspace
            else
                debugball1.Position = point.Position
            end

            if not debugball2 then
                debugball2 = Instance.new("Part")
                debugball2.Shape = Enum.PartType.Ball
                debugball2.Transparency = 0.65
                debugball2.Anchored = true
                debugball2.CanCollide = false
                debugball2.Color = Color3.fromRGB(255, 0, 0)
                debugball2.Material = Enum.Material.Neon
                debugball2.Name = "Destination"
                debugball2.Size = Vector3.new(1, 1, 1)
                debugball2.Position = point.Position
                debugball2.Parent = workspace
            else
                debugball2.Position = obj.Position
            end
        end

        hum:MoveTo(point.Position)
        hum.MoveToFinished:Wait(10)
    end

    if nttp then
        hrp.CFrame = obj.CFrame
    end

    going = false
    return true
end

local function runforurlife(killer)
    local loop1 = workspace.LoopPoints:WaitForChild("loop1", 5)
    local loop2 = workspace.LoopPoints:WaitForChild("loop2", 5)
    local loop3 = workspace.LoopPoints:WaitForChild("loop3", 5)

	local mem = {
		lastPos = nil,
		stillTime = 0,
	}

    local currentloop = nil
    local currentpoint = nil
    local lastloop = nil
	local hrp = killer:WaitForChild("HumanoidRootPart")
    local lhrp = lp.Character:WaitForChild("HumanoidRootPart")

	local function isthread(pos)
		if (hrp.Position - pos).Magnitude <= 4 then
			if scriptdebug then print("[DEBUG]: Thread") end
			return true
		end
		return false
	end

    local function findfurthestpoint()
		local function issave(pos)
			local path = pathf:CreatePath({
				AgentRadius = 2,
				AgentHeight = 5,
				AgentCanJump = false,
			})

			path:ComputeAsync(lhrp.Position, pos.Position)

			if path.Status ~= Enum.PathStatus.Success then
				return false
			end

			for _, wp in pairs(path:GetWaypoints()) do
				if isthread(wp.Position) then
					return false
				end
			end

			return true
		end

        local function scan(ig)
            local best = nil
            local hrp = kill:FindFirstChildWhichIsA("Model"):WaitForChild("HumanoidRootPart")
            local lhrp = lp.Character:WaitForChild("HumanoidRootPart")
            local bestsc = -math.huge

			if scriptdebug and lastloop and currentloop then print("[DEBUG]: Pre-Last loop point: " .. lastloop.Name .. " Pre-Current: " .. currentloop.Name) end

            if not ig then
                if loop1 ~= currentloop and loop1 ~= lastloop then
                    for _, v in pairs(loop1:GetChildren()) do
                        local disttk = (v.Position - hrp.Position).Magnitude
                        local disttp = (v.Position - lhrp.Position).Magnitude
 
                        local score = disttk - disttp
                        if score > bestsc then
                            bestsc = score
                            best = v
                        end
                    end
                else
                    if scriptdebug then print("[DEBUG]: Bad loop1") end
                end
                if loop2 ~= currentloop and loop2 ~= lastloop then
                    for _, v in pairs(loop2:GetChildren()) do
                        local disttk = (v.Position - hrp.Position).Magnitude
                        local disttp = (v.Position - lhrp.Position).Magnitude

                        local score = disttk - disttp
                        if score > bestsc then
                            bestsc = score
                            best = v
                        end
                    end
                else
                    if scriptdebug then print("[DEBUG]: Bad loop2") end
                end
                if loop3 ~= currentloop and loop3 ~= lastloop then
                    for _, v in pairs(loop3:GetChildren()) do
                        local disttk = (v.Position - hrp.Position).Magnitude
                        local disttp = (v.Position - lhrp.Position).Magnitude

                        local score = disttk - disttp
                        if score > bestsc then
                            bestsc = score
                            best = v
                        end
                    end
                else
                    if scriptdebug then print("[DEBUG]: Bad loop3") end
                end
            else
                for _, v in pairs(loop1:GetChildren()) do
                    local disttk = (v.Position - hrp.Position).Magnitude
                    local disttp = (v.Position - lhrp.Position).Magnitude

                    local score = disttk - disttp
                    if score > bestsc then
                        bestsc = score
                        best = v
                    end
                end
                for _, v in pairs(loop2:GetChildren()) do
                    local disttk = (v.Position - hrp.Position).Magnitude
                    local disttp = (v.Position - lhrp.Position).Magnitude

                    local score = disttk - disttp
                    if score > bestsc then
                        bestsc = score
                        best = v
                    end
                end
                for _, v in pairs(loop3:GetChildren()) do
                    local disttk = (v.Position - hrp.Position).Magnitude
                    local disttp = (v.Position - lhrp.Position).Magnitude

                    local score = disttk - disttp
                    if score > bestsc then
                        bestsc = score
                        best = v
                    end
                end
            end

            return best
        end

        local best = scan(false)

        if best then
            if scriptdebug then print("[DEBUG]: Best loop orb: " .. best:GetFullName()) end
        else
			lastloop = nil
            best = scan(false)
            if scriptdebug then warn("[DEBUG]: Best loop orb is nil, using fallback") end
        end

		if scriptdebug and best and lastloop then print("[DEBUG]: Last loop point: " .. lastloop.Name .. " Current: " .. currentloop.Name) end
        return best
    end

    local function getbestnextpoint(point)
        local khrp = kill:FindFirstChildWhichIsA("Model"):WaitForChild("HumanoidRootPart")
        local hrp = lp.Character.HumanoidRootPart
        local num = tonumber(string.split(point.Name, "_")[2])
        local best = nil
        local bests = -math.huge
        local par = point.Parent

        local minos = par:FindFirstChild("Point_" .. (num - 1))
        if not minos then
            local highest = -math.huge
            for _, p in ipairs(par:GetChildren()) do
                local n = tonumber(string.split(p.Name, "_")[2])
                if n and n > highest then
                    highest = n
                    minos = p
                end
            end
        end

        local high = par:FindFirstChild("Point_" .. (num + 1))
        if not high then
            local lowest = math.huge
            for _, p in ipairs(par:GetChildren()) do
                local n = tonumber(string.split(p.Name, "_")[2])
                if n and n < lowest then
                    lowest = n
                    high = p
                end
            end
        end

        local function score(pt)
            if not pt then return end

            local score = 0
            local disttk = (khrp.Position - pt.Position).Magnitude

            score += disttk * 2

            local ray = workspace:Raycast(
                khrp.Position,
                pt.Position - khrp.Position
            )

            if ray and ray.Instance.CanCollide
            and not ray.Instance:IsDescendantOf(khrp.Parent)
            and not ray.Instance:IsDescendantOf(lp.Character) then
                score += 30
            end

            if score > bests then
                bests = score
                best = pt
            end
        end

        score(minos)
        score(high)
		score(point)

		if best == point then
			return nil
		end

        return best
    end

	local function isalive()
		local hum = lp.Character:FindFirstChildOfClass("Humanoid")
		local hrp = lp.Character:FindFirstChild("HumanoidRootPart")

		if not hum or not hrp or hum.Health <= 0 then
			return nil, nil
		end

		return hum, hrp
	end

	local function killerisafk(dt)
		local pos = kill:FindFirstChildWhichIsA("Model"):WaitForChild("HumanoidRootPart").Position

		if mem.lastPos then
			local moved = (pos - mem.lastPos).Magnitude
			if moved < 0.35 then
				mem.stillTime += dt
			else
				mem.stillTime = 0
			end
		end

		mem.lastPos = pos
		return mem.stillTime >= 6.5
	end
    
    local besssstttpoint = findfurthestpoint()
    if besssstttpoint:IsDescendantOf(loop1) then
        currentloop = loop1
    elseif besssstttpoint:IsDescendantOf(loop2) then
        currentloop = loop2
    elseif besssstttpoint:IsDescendantOf(loop3) then
        currentloop = loop3
    else
        currentloop = loop1
        if scriptdebug then print("[DEBUG]: Bad loops") end
    end

    currentpoint = besssstttpoint

    goto(besssstttpoint, false, false)
    run.RenderStepped:Wait()

    local started = tick()

	while task.wait() do
		local hum, hrp = isalive()
		if not isalive() then
			return "died"
		end

        local sets = getgenv().settings.AutoFarmSettings.FarmSettings
        local afk = killerisafk(0.1)

		if killer:FindFirstChild("HumanoidRootPart") and 
        not afk and currentpoint and currentloop and
        tick() - started < tonumber(sets.TimeoutFor1LoopSpot) then
            local killerhrp = killer:FindFirstChild("HumanoidRootPart")

			local dist = (hrp.Position - killerhrp.Position).Magnitude
			if dist >= 80 then
				return true
			end

			local target = getbestnextpoint(currentpoint)

			if target then
				local ok = goto(target, false, false)

				if ok then
					currentpoint = target
				end
			end
			run.RenderStepped:Wait()
        elseif afk then
			local bp = findfurthestpoint()

			if bp then
				goto(bp, false, false)
				return true
			end
		else
            local bestpoint = findfurthestpoint()

            if bestpoint then
				lastloop = currentloop
				currentloop = bestpoint.Parent
				currentpoint = bestpoint

				goto(bestpoint, false, false)

				started = tick()
			end
		end

		if not isalive() then
			return "died"
		end
	end
end

local function findclosest(gens, gencd)
    local closest = nil
    local hrp = lp.Character:WaitForChild("HumanoidRootPart")
    local dist = math.huge

    for _, v in pairs(gens) do
        if v == gencd then
            continue
        end

        local progress = v.Progress.Value or 0
        if progress and (v.PrimaryPart.Position - hrp.Position).Magnitude < dist and progress < 100 then
            dist = (v.PrimaryPart.Position - hrp.Position).Magnitude
            closest = v
        end
    end

    if not closest and gencd and gencd:FindFirstChild("Progress") then 
        local progress = gencd.Progress.Value or 0
        if progress < 100 then
            closest = gencd 
        end
    end

    return closest
end

local function findrandom(gens, gencd)
    local best = nil
    local nicegens = {}

    for _, gen in pairs(gens) do
        if gen ~= gencd then
            local progress = gen.Progress.Value or 0

            if progress < 100 then
                table.insert(nicegens, gen)
            end
        end
    end

    if #nicegens == 0 and gencd and gencd:FindFirstChild("Progress") then
        local progress = gencd.Progress.Value or 0

        if progress < 100 then
            table.insert(nicegens, gencd)
        end
    end

    if #nicegens > 0 then
        return nicegens[math.random(#nicegens)]
    end

    return best
end

local function findfurthest(gens, killer, gencd)
	local closest = nil
	local hrp = killer:WaitForChild("HumanoidRootPart")
	local dists = -math.huge

	for _, v in pairs(gens) do
        if v == gencd then
            continue
        end

		local progress = v.Progress.Value or 0

		if progress < 100 then
			local dist = (v.PrimaryPart.Position - hrp.Position).Magnitude

			if dist > dists then
				dists = dist
				closest = v
			end
		end
	end

    if not closest and gencd and gencd:FindFirstChild("Progress") then 
        local progress = gencd.Progress.Value or 0
        if progress < 100 then
            closest = gencd 
        end
    end

	return closest
end

local function startautofarm(map)
    local hrp = lp.Character:WaitForChild("HumanoidRootPart")
    local hum = lp.Character:WaitForChild("Humanoid")

    if scriptdebug then print("[DEBUG]: Waiting to hrp to unanchor") end

    repeat
        task.wait(0.3)
    until hum and hrp and not hrp.Anchored and hum.WalkSpeed > 0

    if getgenv().settings.AutoFarmSettings.Desync.TeleportUrCameraToUrHitbox and
    getgenv().settings.AutoFarmSettings.Desync.Enabled and
    not getgenv().settings.AutoFarmSettings.PathFindMethod then
        workspace.CurrentCamera.CameraSubject = lp.Character.QueryHitbox 
    end

    task.wait(0.35)

    local autostart = tick()

    if support then
        local s = getgenv().settings.Stamina
        if not s.InfStamina then
            sprint.StaminaLoss = tonumber(s.CustomStaminaLoss)
            if scriptdebug then print("[DEBUG]: Set custom stamina loss") end
        end
        if lp.Character.Parent.Name == "Survivors" then
            sprint.SprintSpeed = tonumber(s.CustomSurvivorsRunSpeed)
            if scriptdebug then print("[DEBUG]: Set custom survivor run speed") end
        elseif lp.Character.Parent.Name == "Killers" then
            sprint.SprintSpeed = tonumber(s.CustomKillersRunSpeed)
            if scriptdebug then print("[DEBUG]: Set custom killer run speed") end
        end
        sprint.StaminaGain = tonumber(s.CustomStaminaGain)
        if scriptdebug then print("[DEBUG]: Set custom stamina gain") end
    end

    if getgenv().settings.Stamina.InfStamina and support then
        sprint.StaminaLoss = 0
        if scriptdebug then print("[DEBUG]: Set inf stamina") end
    elseif getgenv().settings.Stamina.StaminaManagment.Enabled then
        task.spawn(function()
            spawnstaminacontroller()
        end)
        if scriptdebug then print("[DEBUG]: Spawned stamina controller") end
    end

    if lp.Character.Parent.Name == "Survivors" then
        local gens = {}
        local gencd = nil
        local bestgentodo

        if scriptdebug then print("[DEBUG]: Starting searching gens") end

        for _, gen in pairs(workspace.Map.Ingame.Map:GetChildren()) do
            if gen.Name == "Generator" then
                table.insert(gens, gen)
                if scriptdebug then print("[DEBUG]: Found generator: " .. gen:GetFullName()) end
            end
        end

        if scriptdebug then print("[DEBUG]: Total: " .. #gens .. " generator(s)") end

        local a = getgenv().settings.AutoFarmSettings
        local b = a.FarmSettings
        local c = getgenv().settings.FarmOnlyWhenKillerIs
        local killer = kill:FindFirstChildWhichIsA("Model")

        if killer and c.Enabled then
            if not c[killer.Name] then
                if c.ServerHopIfWrongKiller then
                    serverhop()
                elseif c.ResetIfWrongKiller then
                    hum.Health = 0
                    if scriptdebug then print("[DEBUG]: Reseted") end
                end
            end
        end

        if a.BecomeInvisible and not a.PathFindMethod then
            local an = Instance.new("Animation")
            an.AnimationId = "rbxassetid://75804462760596"

            invis = hum:FindFirstChildWhichIsA("Animator"):LoadAnimation(an)
            invis:Play()
            invis:AdjustSpeed(0)
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Transparency = 0.8 end

            if scriptdebug then print("[DEBUG]: Turned on invisibility") end
        end

        if a.Desync.Enabled and not a.PathFindMethod then
            toggledesync = false

            local lastframe
            if a.Desync.DesyncInVoid then
                lastframe = hrp.CFrame
                hrp.CFrame = CFrame.new(0, 100, 0)
                if scriptdebug then print("[DEBUG]: Teleported to void") end
                task.wait(0.2)
            end

            toggledesync = true
            if scriptdebug then print("[DEBUG]: Turned on desync") end

			task.wait(0.2)

            if a.Desync.DesyncInVoid then
                hrp.CFrame = lastframe
                if scriptdebug then print("[DEBUG]: Teleported back") end
            end
        end

        task.delay(3, function()
            if a.AutoEatGhostBurgerOrCloneOrCrouch then
                if lp.Character.Name == "Noob" then
                    mainremote:FireServer("UseActorAbility", {
                        [1] = "Ghostburger"
                    })
                    if scriptdebug then print("[DEBUG]: Ghostburger eated") end
                elseif lp.Character.Name == "007n7" then
                    mainremote:FireServer("UseActorAbility", {
                        [1] = "Clone"
                    })
                    if scriptdebug then print("[DEBUG]: Cloned") end
                elseif lp.Character.Name == "TwoTime" then
                    mainremote:FireServer("UseActorAbility", {
                        [1] = "Crouch"
                    })
                    if scriptdebug then print("[DEBUG]: Crouched") end
                end
            end
        end)

        local hpcon

        local function dogens()
            if not hpcon then


            end

            for _, v in pairs(gens) do
                if b.SurvivorGeneratorFind == "Random" then
                    besttodo = findrandom(gens, gencd)
                elseif b.SurvivorGeneratorFind == "Closest" or not killer then
                    besttodo = findclosest(gens, gencd)
                elseif killer then
                    besttodo = findfurthest(gens, killer, gencd)
                end

                if not besttodo then return "FinishedAll" end

                if scriptdebug then
                    if not debughl then
                        debughl = Instance.new("Highlight", besttodo)
                    else
                        debughl.Parent = besttodo
                    end
                end

                local prompt = besttodo.Main:FindFirstChild("Prompt")

                if a.PathFindMethod then
                    if scriptdebug then print("[DEBUG]: Best generator: " .. besttodo:GetFullName()) end

                    prompt.HoldDuration = 0

                    repeat
                        task.wait(1)
                    until not hrp.Anchored

                    local res = goto(besttodo.Positions.Center, true, true)
                    if res == "RUN" then local a = runforurlife(killer) print(a) return a end
                    task.wait(0.1)
                    fireproximityprompt(prompt)
                    task.wait(0.2)

                    if not playergui:FindFirstChild("PuzzleUI") then
                        local res = goto(besttodo.Positions.Left, true, true)
                        if res == "RUN" then local a = runforurlife(killer) print(a) return a end
                        task.wait(0.1)
                        fireproximityprompt(prompt)
                        task.wait(0.2)
                        if not playergui:FindFirstChild("PuzzleUI") then
                            goto(besttodo.Positions.Right, true, true)
                            if res == "RUN" then local a = runforurlife(killer) print(a) return a end
                            task.wait(0.1)
                            fireproximityprompt(prompt)
                            task.wait(0.2)
                            if not playergui:FindFirstChild("PuzzleUI") then
                                continue
                            end
                        end
                    end
                else
                    if scriptdebug then print("[DEBUG]: Best generator: " .. besttodo:GetFullName()) end

                    prompt.HoldDuration = 0

                    repeat
                        task.wait(1)
                    until not hrp.Anchored

                    hrp.CFrame = besttodo.Positions.Center.CFrame
                    task.wait(0.2)
                    fireproximityprompt(prompt)
                    task.wait(0.3)
                    if not playergui:FindFirstChild("PuzzleUI") then
                        hrp.CFrame = besttodo.Positions.Left.CFrame
                        task.wait(0.2)
                        fireproximityprompt(prompt)
                        task.wait(0.3)
                        if not playergui:FindFirstChild("PuzzleUI") then
                            hrp.CFrame = besttodo.Positions.Right.CFrame
                            task.wait(0.2)
                            fireproximityprompt(prompt)
                            task.wait(0.3)
                            if not playergui:FindFirstChild("PuzzleUI") then
                                continue
                            end
                        end
                    end
                end

                task.wait(0.2)

                if lp.Character.CollisionHitbox.CFrame ~= hrp.CFrame then
                    task.spawn(function()
                        local hitbox = lp.Character.CollisionHitbox
                        hitbox.CollisionConnector.Enabled = false
                        hitbox.CFrame = hrp.CFrame
                        hitbox.CollisionConnector.Enabled = true

                        if scriptdebug then print("[DEBUG]: Fixed hitbox offset") end
                    end)
                end

                local function startdoinggen()
                    local remote = besttodo.Remotes.RE
                    local rf = besttodo.Remotes.RF
                    local progress = besttodo.Progress
                    local g = getgenv().settings.AutoGenerator

                    if g.AutoFinish1TaskWhenEntringGenerator then 
                        if scriptdebug then print("[DEBUG]: Fired") end 
                        remote:FireServer()
                        if b.GeneratorFarmType ~= "DoFullGen" and not a.PathFindMethod then
                            task.wait(0.1)

                            rf:InvokeServer("Enter")
                            if scriptdebug then print("[DEBUG]: Left") end 

                            return "TeleportPLZ", besttodo
                        end
                    end

                    if a.PathFindMethod then
                        if not killer then
                            while progress.Value < 100 do
                                local start = tick()
                                repeat
                                    run.RenderStepped:Wait()
                                    if lp.Character.Parent.Name == "Spectating" then return "died" end
                                until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                not prompt or 
                                not playergui:FindFirstChild("PuzzleUI")

                                if progress.Value == 100 then return "GeneratorDone" end
                                if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                remote:FireServer()
                                if scriptdebug then print("[DEBUG]: Fired") end

                                if progress.Value == 100 then return "GeneratorDone" end
                            end
                        else
                            while progress.Value < 100 do
                                local start = tick()
                                repeat
                                    run.RenderStepped:Wait()
                                    if lp.Character.Parent.Name == "Spectating" then return "died" end
                                until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                not prompt or 
                                not playergui:FindFirstChild("PuzzleUI") or
                                killerlooksonu(killer.HumanoidRootPart, hrp)

                                if killerlooksonu(killer.HumanoidRootPart, hrp) then
                                    rf:InvokeServer("Enter")
                                    if scriptdebug then print("[DEBUG]: Left") end 
                                    return "Run4UrLife", besttodo 
                                end
                                if progress.Value == 100 then return "GeneratorDone", nil end
                                if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                remote:FireServer()
                                if scriptdebug then print("[DEBUG]: Fired") end

                                if progress.Value == 100 then return "GeneratorDone", nil end
                            end
                        end
                    elseif not a.PathFindMethod then
                        if killer then
                            if b.GeneratorFarmType == "DoFullGen" then
                                while progress.Value <= 100 do
                                    local start = tick()
                                    repeat
                                        run.RenderStepped:Wait()
                                        if lp.Character.Parent.Name == "Spectating" then return "died" end
                                    until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                    not prompt or 
                                    not playergui:FindFirstChild("PuzzleUI") or
                                    killerlooksonu(killer.HumanoidRootPart, hrp)

                                    if killerlooksonu(killer.HumanoidRootPart, hrp) then 
                                        rf:InvokeServer("Enter")
                                        if scriptdebug then print("[DEBUG]: Left") end
                                        return "TeleportPLZ", besttodo 
                                    end
                                    if progress.Value >= 100 then return "GeneratorDone", nil end
                                    if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                    remote:FireServer()
                                    if scriptdebug then print("[DEBUG]: Fired") end

                                    if progress.Value == 100 then return "GeneratorDone" end
                                end
                            else
                                if not g.AutoFinish1TaskWhenEntringGenerator then
                                    local start = tick()
                                    repeat
                                        run.RenderStepped:Wait()
                                        if lp.Character.Parent.Name == "Spectating" then return "died" end
                                    until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                    not prompt or 
                                    not playergui:FindFirstChild("PuzzleUI") or
                                    killerlooksonu(killer.HumanoidRootPart, hrp)

                                    if killerlooksonu(killer.HumanoidRootPart, hrp) then
                                        rf:InvokeServer("Enter")
                                        if scriptdebug then print("[DEBUG]: Left") end 
                                        return "TeleportPLZ", besttodo 
                                    end
                                    if progress.Value == 100 then return "GeneratorDone", nil end
                                    --if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                    remote:FireServer()
                                    if scriptdebug then print("[DEBUG]: Fired") end

                                    task.wait(0.1)

                                    rf:InvokeServer("Enter")
                                    if scriptdebug then print("[DEBUG]: Left") end 

                                    return "TeleportPLZ", besttodo 
                                end
                            end
                        else
                            if b.GeneratorFarmType == "DoFullGen" then
                                while progress.Value <= 100 do
                                    local start = tick()
                                    repeat
                                        run.RenderStepped:Wait()
                                        if lp.Character.Parent.Name == "Spectating" then return "died" end
                                    until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                    not prompt or 
                                    not playergui:FindFirstChild("PuzzleUI")

                                    if progress.Value == 100 then return "GeneratorDone" end
                                    if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                    remote:FireServer()
                                    if scriptdebug then print("[DEBUG]: Fired") end

                                    if progress.Value == 100 then return "GeneratorDone" end
                                end
                            else
                                if not g.AutoFinish1TaskWhenEntringGenerator then
                                    local start = tick()
                                    repeat
                                        run.RenderStepped:Wait()
                                        if lp.Character.Parent.Name == "Spectating" then return "died" end
                                    until tick() - start >= g.Interval + (math.random() * g.Randomness) or 
                                    not prompt or 
                                    not playergui:FindFirstChild("PuzzleUI")

                                    if progress.Value == 100 then return "GeneratorDone", nil end
                                    --if not playergui:FindFirstChild("PuzzleUI") then if scriptdebug then print("[DEBUG]: Bad puzzle") end return "BadPuzzle" end

                                    remote:FireServer()
                                    if scriptdebug then print("[DEBUG]: Fired") end

                                    task.wait(0.1)

                                    rf:InvokeServer("Enter")
                                    if scriptdebug then print("[DEBUG]: Left") end

                                    return "TeleportPLZ", besttodo
                                end
                            end
                        end
                    end
                    if progress.Value == 100 then return "GeneratorDone" end
                end

                if not playergui:FindFirstChild("PuzzleUI") then continue end

                local status, gen = startdoinggen()
                local runstatus

                repeat task.wait() until status

                if gen then gencd = gen end

                if scriptdebug then print("[DEBUG]: Status: " .. status) end

                if lp.Character.Parent.Name == "Spectating" then return "died" end

                if status == "Run4UrLife" and a.PathFindMethod then
                    runstatus = runforurlife(killer)
                elseif status == "died" then
                    return "died"
                elseif status == "GeneratorDone" then
                    return "GeneratorDone"
                elseif status == "BadPuzzle" then
                    return "BadPuzzle"
                elseif status == "TeleportPLZ" then
                    return "TeleportPLZ"
                elseif status == "FinishedAll" then
                    return "FinishedAll"
                end

                if runstatus == "died" then return "died" end
            end
        end

        local co = 0
        local status
        repeat
            co += 1
			status = dogens()
            repeat task.wait() until status
        until co >= 50 or status == "died" or status == "FinishedAll" or lp.Character.Parent.Name == "Spectating"

        if getgenv().settings.FarmEnd.AutoResetAfterCompleating then
            hrp.CFrame = hrp.CFrame * CFrame.new(100, 100, 100)
            task.wait(0.8)
            hum.Health = 0
            task.wait(0.8)
            repeat hrp.CFrame = hrp.CFrame * CFrame.new(0, 100, 0) task.wait() until lp.CharacterAdded
        end

        task.wait(1)

        if getgenv().settings.Webhook.Enabled then
            send(true, {time = math.round(tick() - autostart)})
        end

        toggledesync = false

        task.wait(5)

        local ab = getgenv().settings.AutoBuy

        --[[local embeds = {
            ["title"] = "Auto buy (" .. data.type .. "):",
            ["color"] = 0xb475f2,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ["fields"] = {
                {
                    ["name"] = "Bought:",
                    ["value"] = [[Bought: ]]  --[[data.bought .. [[ for $]]  --[[data.amount .. [[ 
                    And u have $]]  --[[data.money .. [[ now.]]
                    --[["inline"] = false
                },
            }
        }]]

        if ab.Enabled and support then
            local block = {
                "1xFunny",
                "TwoTime_FortniteWay",
                "JohnDoeFunny",
                "c00lkiddFunny",
                "ShedletskyFunny",
                "SlasherSwift",
                "Jason",
                "JaneDoe",
            }

            if ab.Killers then
                for _, surv in pairs(game:GetService("ReplicatedStorage").Assets.Killers:GetChildren()) do
                    if lp.PlayerData.Purchased.Killers:FindFirstChild(surv.Name) or table.find(block, surv.Name) then continue end
                    if not surv.Name:find("!") and not surv.Name:find("#") then
                        local money = lp.PlayerData.Stats.Currency.Money.Value
                        local price = require(surv.Config).Price
                        local w = getgenv().settings.Webhook

                        if price < money then
                            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteFunction
                            Event:InvokeServer(
                                "PurchaseContent",
                                {
                                    surv
                                }
                            )

                            if w.SendWhenBoughtSomthing then                     
                                send(false, {
                                    type = "Killer",
                                    bought = surv.Name,
                                    amount = price,
                                    money = money - price
                                })
                            end

                            task.wait(1)
                        end
                    end
                end
            end

            if ab.Survivors then
                for _, surv in pairs(game:GetService("ReplicatedStorage").Assets.Survivors:GetChildren()) do
                    if lp.PlayerData.Purchased.Survivors:FindFirstChild(surv.Name) or table.find(block, surv.Name) then continue end
                    if not surv.Name:find("!") and not surv.Name:find("#") then
                        local money = lp.PlayerData.Stats.Currency.Money.Value
                        local price = require(surv.Config).Price
                        local w = getgenv().settings.Webhook

                        if price < money then
                            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteFunction
                            Event:InvokeServer(
                                "PurchaseContent",
                                {
                                    surv
                                }
                            )

                            if w.SendWhenBoughtSomthing then
                                send(false, {
                                    type = "Survivor",
                                    bought = surv.Name,
                                    amount = price,
                                    money = money - price
                                })
                            end

                            task.wait(1)
                        end
                    end
                end
            end
        elseif not support then
            warn("[Auto-Farm]: Your shitsploit doesnt support require, please swith to better one")
        end

        task.wait(4)

        if getgenv().settings.FarmEnd.ServerHopOnRandomServer or
        getgenv().settings.FarmEnd.ServerHopOnLowServer then
            serverhop()
        end
    end
end

lp.CharacterAdded:Connect(function()
    task.wait(1)
    if lp.Character.Parent.Name == "Killers" then
        if not getgenv().settings.FarmAsKiller.Enabled then
            local hrp = lp.Character:WaitForChild("HumanoidRootPart")
            local hum = lp.Character:WaitForChild("Humanoid")

            hrp.CFrame = hrp.CFrame * CFrame.new(100, 100, 100)
            task.wait(0.8)
            hum.Health = 0
            task.wait(0.8)
            repeat hrp.CFrame = hrp.CFrame * CFrame.new(0, 100, 0) task.wait() until lp.CharacterAdded
        end
    end
end)

players.ChildRemoved:Connect(function()
    task.wait(1)
    local a = 0
    for _, v in pairs(players:GetChildren()) do
        a += 1
    end
    if a == 1 then serverhop() end
end)

workspace.Map.Ingame.ChildAdded:Connect(function(a)
    task.wait(3)
    if a.Name == "Map" then
        if lp.Character.Parent.Name ~= "Spectating" then
            task.delay(1, function()
                local text = playergui.TemporaryUI:WaitForChild("MapCredits_PRESET"):WaitForChild("MapName").Text
                local res = string.gsub(text, "%s", "")
                if scriptdebug then print("[DEBUG]: Map name: " .. res) end
                createpoints(mappoints[res])
            end)
            task.delay(2, function()
                startautofarm(a) 
            end)
        end
    end
end)

task.spawn(function()
    if workspace.Map.Ingame:FindFirstChild("Map") then
        local a = workspace.Map.Ingame:FindFirstChild("Map")
        task.wait(3)
        if a.Name == "Map" then
            if lp.Character.Parent.Name ~= "Spectating" then
                task.delay(1, function()
                    local text = playergui.TemporaryUI:WaitForChild("MapCredits_PRESET"):WaitForChild("MapName").Text
                    local res = string.gsub(text, "%s", "")
                    if scriptdebug then print("[DEBUG]: Map name: " .. res) end
                    createpoints(mappoints[res])
                end)
                task.delay(2, function()
                    startautofarm(a) 
                end)
            end
        end
    end
end)

print("[Auto-Farm]: Started auto farm")
getgenv().AutoFarmLoaded = true

task.wait(1)
local a = 0
for _, v in pairs(players:GetChildren()) do
    a += 1
end
if a == 1 then serverhop() end
