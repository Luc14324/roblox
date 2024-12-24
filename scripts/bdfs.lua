local USE_BETA_FEATURES = false

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
task.spawn(function()
	if fireclickdetector then
		local msg = Instance.new("Hint", workspace)
		msg.Text = "Started loading nick7 hub, please wait.. // "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
		task.wait(5)
		msg:Destroy()
	else
		localPlayer:Kick("(nick7 hub) Your exploit doesn't support fireclickdetector!")
	end
end)
local GC = getconnections or get_signal_cons
if GC then
	for _,v in pairs(GC(localPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	localPlayer.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

local trash
for _,v in pairs(workspace:GetChildren()) do
	if v:IsA("UnionOperation") and v.Name=="Trashcan" and v:FindFirstChild("ClickDetector") then
		trash = v
	end
end

function tcount(inst,tool)
	local x = 0
	for _,v in pairs(inst:GetChildren()) do
		if v.Name == tool and v:IsA("Tool") then
			x+=1
		end
	end
	return x
end

--[[local hint = Instance.new("Hint", workspace)

function hint_text(text)
	hint.Text = text
end]]

local defaults = {
	autofarm = false,
	eat = false,
	frhead = false,
	heal = false,
	health = 100,
	garbagefarm = true,
	burgerfarm = not not fireproximityprompt,
	burgerfarmcage = true,
	burger_minimum = 0
	--avoid = true,
}
local g = {}
if getgenv then
	getgenv().n7 = defaults
	g = getgenv()
else
	g.n7 = defaults
	task.spawn(function()
		local m=Instance.new("Message", workspace)
		local txt="nick7 hub | WARNING\n\nYour exploit DOES NOT support getgenv function!\nThis could lead to detecting you and possible ban\nnick7 hub will load now.\n\n"
		m.Text=txt
		for i=15,0,-1 do
			m.Text=txt..i
			task.wait(1)
		end
		m:Destroy()
	end)
end

local cageModel
local CagePosition

function CageGen()
	local folder = Instance.new("Folder", workspace)
	folder.Name = "Cage (nick7hub)"
	
	cageModel = folder

	local offset = Vector3.new(math.random(-100000, 100000), workspace.Buildings.DeadBurger.DumpsterMoneyMaker.FoodBox.Position or math.random(-50,1500), math.random(-100000,100000))
	local floor = Instance.new("Part", folder)
	local wall1 = Instance.new("Part", folder)
	local wall2 = Instance.new("Part", folder)
	local wall3 = Instance.new("Part", folder)
	local wall4 = Instance.new("Part", folder)
	local ceiling = Instance.new("Part", folder)
	local light = Instance.new("PointLight", ceiling)
	
	local parts = {floor, wall1, wall2, wall3, wall4, ceiling}
	
	for _, part in ipairs(parts) do
		part.Anchored = true
		part.Transparency = 0.4
		part.Position = offset
		part.Color = Color3.fromRGB(79, 79, 79)
		part.Name = "discord.gg/6tgCfU2fX8"
	end
	
	floor.Position += Vector3.new(0, 0, 0)
	floor.Size = Vector3.new(10,1,10)
	
	wall1.Position += Vector3.new(5, 5, 0)
	wall1.Size = Vector3.new(1, 10, 10)
	
	wall2.Position += Vector3.new(-5, 5, 0)
	wall2.Size = Vector3.new(1, 10, 10)
	
	wall3.Position += Vector3.new(0, 5, -5)
	wall3.Size = Vector3.new(10, 10, 1)
	
	wall4.Position += Vector3.new(0, 5, 5)
	wall4.Size = Vector3.new(10, 10, 1)
	
	ceiling.Position += Vector3.new(0, 10, 0)
	ceiling.Size = Vector3.new(10,1,10)
	
	light.Range = 20
	light.Brightness = 10
	light.Shadows = false
	
	local frame = offset + Vector3.new(0,4,0)
	CagePosition = CFrame.new(frame)
end

CageGen()

local danger = false -- I will not cut out these lines, they don't affect on autofarm perfomance.
local positionToCheck

function ifdanger()
	repeat
		task.wait()
	until not danger
end

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
    SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Dark"
})

local Tabs = {
	Main = Window:AddTab({ Title = "Farming", Icon = "factory" }),
	Misc = Window:AddTab({ Title = "Misc", Icon = "user"}),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}

local player = Tabs.Misc:AddSection("Player")

local autofarm = Tabs.Main:AddToggle("Autofarm", {
	Title = "Autofarm",
	Description = USE_BETA_FEATURES and fireproximityprompt and "Autofarms garbage, burgers and clicks monitors." or "Autofarms garbage and clicks monitors.",
	Default = g.n7.autofarm
})

local eat = player:AddToggle("eat", {
	Title = "Auto-eat",
	Default = g.n7.eat
})

player:AddButton({
	Title = "Teleport to cage",
	Description = "Spawns in random position that is far away from main map",
	Callback = function()
		if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			localPlayer.Character.HumanoidRootPart.CFrame = CagePosition
		end
	end
})

player:AddButton({
	Title = "Teleport to map",
	Description = "Teleports you near deadburgers",
	Callback = function()
		if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-121, 17, 112)
		end
	end
})

player:AddButton({
	Title = "Change cage & teleport to cage",
	Description = "Re-spawns cage, changes position and teleports character to cage.",
	Callback = function()
		if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			CageGen()
			localPlayer.Character.HumanoidRootPart.CFrame = CagePosition
		end
	end
})

player:AddButton({Title = "Clear cages", Description = "Don't clear cages while being in cage!", Callback = function()
	repeat
		if workspace:FindFirstChild("Cage (nick7hub)") then
			workspace:FindFirstChild("Cage (nick7hub)"):Destroy()
		end
	until not (workspace:FindFirstChild("Cage (nick7hub)"))
end})

autofarm:OnChanged(function(Value)
	g.n7.autofarm = Value
	task.spawn(function() -- garbage autofarm
		if g.n7.garbagefarm then
			local mhb = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox
			while g.n7.autofarm and not Fluent.Unloaded do
				pcall(function()
					if localPlayer.Character and localPlayer.Character.Values.Joy.Value >= 50 then
						repeat
							trash.ClickDetector.MaxActivationDistance = math.huge
							fireclickdetector(trash.ClickDetector, 1)
							task.wait()
						until localPlayer.Backpack:FindFirstChild("Garbage Bag") or localPlayer.Character:FindFirstChild("Garbage Bag") or Fluent.Unloaded or not g.n7.autofarm
						if localPlayer.Backpack:FindFirstChild("Garbage Bag") or localPlayer.Character:FindFirstChild("Garbage Bag") then
							if not localPlayer.Character:FindFirstChild("Garbage Bag") then
								local garbage = localPlayer.Backpack:FindFirstChild("Garbage Bag") or localPlayer.Character:FindFirstChild("Garbage Bag")
								garbage.Parent = localPlayer.Character
							end
							repeat
								trash.ClickDetector.MaxActivationDistance = math.huge
								fireclickdetector(trash.ClickDetector, 1)
								mhb.Position = localPlayer.Character.HumanoidRootPart.Position
								task.wait()
								mhb.Position = localPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
								task.wait()
							until not localPlayer.Character:FindFirstChild("Garbage Bag") or Fluent.Unloaded or not g.n7.autofarm
						else
							repeat
								trash.ClickDetector.MaxActivationDistance = math.huge
								fireclickdetector(trash.ClickDetector, 1)
								task.wait()
							until localPlayer.Backpack:FindFirstChild("Garbage Bag") or localPlayer.Character:FindFirstChild("Garbage Bag") or Fluent.Unloaded or not g.n7.autofarm
						end
					end
				end)
				task.wait()
			end
		end
	end)
	task.spawn(function() -- monitor clicker
		while g.n7.autofarm and not Fluent.Unloaded do
			local click = {workspace.Buildings["Green House"].Computer.Monitor.Part.ClickDetector}
			for _,v in workspace.Buildings.CleaningServices:GetDescendants() do
				if v:IsA("ClickDetector") and v.Parent.Parent.Parent.Name == "Computer" then
					table.insert(click, v)
				end
			end
			pcall(function()
				for _,v in pairs(click) do
					fireclickdetector(v, 1)
				end
			end)
			task.wait()
		end
	end)
	if USE_BETA_FEATURES then
		task.spawn(function() -- burger autofarm | beta
			if g.n7.burgerfarm and localPlayer.Character.Values.Joy.Value > 50 then
				while g.n7.autofarm and not Fluent.Unloaded do
					if workspace.Buildings.DeadBurger.DumpsterMoneyMaker.NumberOfBags.Value >= g.n7.burger_minimum or 0 then
						repeat
							if localPlayer.Character and fireproximityprompt and firesignal then
								if not (localPlayer.Backpack:FindFirstChild("FoodBox") or localPlayer.Character:FindFirstChild("FoodBox")) then
									repeat
										positionToCheck = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.FoodBox.Position
										localPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.FoodBox.CFrame
										fireproximityprompt(workspace.Buildings.DeadBurger.DumpsterMoneyMaker.FoodBox.ProximityPrompt)
										ifdanger()
										task.wait()
									until localPlayer.Backpack:FindFirstChild("FoodBox") or localPlayer.Character:FindFirstChild("FoodBox") or Fluent.Unloaded or not g.n7.autofarm or localPlayer.Character.Values.Joy.Value < 50
									positionToCheck = nil
								end
								if not (localPlayer.Backpack:FindFirstChild("MadeBurger") or localPlayer.Character:FindFirstChild("MadeBurger")) then
									local FoodMakeInteract = workspace.Buildings.DeadBurger.FoodMakeInteract
									FoodMakeInteract.ProximityPrompt.HoldDuration = 0.001

									repeat
										positionToCheck = FoodMakeInteract.Position
										local tool = localPlayer.Backpack:FindFirstChild("FoodBox") or localPlayer.Character:FindFirstChild("FoodBox")
										tool.Parent = localPlayer.Character
										FoodMakeInteract.ProximityPrompt:InputHoldBegin()
										ifdanger()
										task.wait(0.2)
									until localPlayer.Backpack:FindFirstChild("MadeBurger") or localPlayer.Character:FindFirstChild("MadeBurger") or Fluent.Unloaded or not g.n7.autofarm
									positionToCheck = nil
								end
								local tool = localPlayer.Backpack:FindFirstChild("MadeBurger") or localPlayer.Character:FindFirstChild("MadeBurger")
								if tool then
									tool.Parent = localPlayer.Character
									localPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace.Buildings.DeadBurger.Tray.CFrame
									repeat
										positionToCheck = workspace.Buildings.DeadBurger.Tray.Position
										local tool = localPlayer.Backpack:FindFirstChild("MadeBurger") or localPlayer.Character:FindFirstChild("MadeBurger")
										tool.Parent = localPlayer.Character
										fireproximityprompt(workspace.Buildings.DeadBurger.Tray.ProximityPrompt)
										ifdanger()
										task.wait()
									until not (localPlayer.Backpack:FindFirstChild("MadeBurger") or localPlayer.Character:FindFirstChild("MadeBurger")) or Fluent.Unloaded or not g.n7.autofarm
									positionToCheck = nil
								end
							elseif not fireproximityprompt then
								warn("fireproximityprompt is unsupported! Skipping burger autofarm")
								break
							end
							task.wait()
						until workspace.Buildings.DeadBurger.DumpsterMoneyMaker.NumberOfBags.Value <= 0 or Fluent.Unloaded or not g.n7.autofarm or not localPlayer.Character
					else
						if localPlayer.Character and g.n7.burgerfarmcage then
							localPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CagePosition
						end
					end
					task.wait()
				end
			end
		end)
	end
end)

workspace.Buildings.DeadBurger.burgre.ClickDetector.MaxActivationDistance = math.huge
local eatworking = false
eat:OnChanged(function(Value)
	g.n7.eat = Value
	while g.n7.eat and not Fluent.Unloaded do
		pcall(function()
			if localPlayer.PlayerGui.Hunger.Hunger.Value <= 100 then
				if not (localPlayer.Backpack:FindFirstChild("Burger") or localPlayer.Character:FindFirstChild("Burger")) then
					eatworking = true
					fireclickdetector(workspace.Buildings.DeadBurger.burgre.ClickDetector, 1)
					local c = 0
					repeat task.wait(0.5);c+=1 until localPlayer.Backpack:FindFirstChild("Burger") or localPlayer.Character:FindFirstChild("Burger") or c>=5
				end
				if localPlayer.Backpack:FindFirstChild("Burger") or localPlayer.Character:FindFirstChild("Burger") and not eatworking and localPlayer.PlayerGui.Hunger.Hunger.Value <= 100 then
					local burger = localPlayer.Backpack:FindFirstChild("Burger") or localPlayer.Character:FindFirstChild("Burger")
					burger.Parent = localPlayer.Character
					if tcount(localPlayer.Character,'Burger') == 1 and tcount(localPlayer.Backpack,'Burger') == 0 then
						burger:Activate()
					end
					task.wait(0.2)
					burger.Parent = localPlayer.Backpack
					task.wait(5)
					eatworking = false
				end
			end
		end)
		task.wait()
	end
end)

local heal = player:AddToggle("AutoHeal", {
	Title = "Auto-heal",
	Description = "Automatically heals character when health below selected number",
	Default = g.n7.heal
})

player:AddSlider("AutoHealHealth", {
	Title = "Auto-heal min",
	Description = "Starts healing when below selected number\nDefault: 100",
	Default = 100,
	Min = 1,
	Max = 100,
	Rounding = 1,
	Callback = function(Value)
		g.n7.health = Value
	end
})

heal:OnChanged(function(Value)
	g.n7.heal = Value
	while g.n7.heal do
		pcall(function()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
				if localPlayer.Character:FindFirstChild("Humanoid").Health < g.n7.health then
					workspace["Meshes/Medkit"].ClickDetector.MaxActivationDistance = math.huge
					fireclickdetector(workspace["Meshes/Medkit"].ClickDetector, 1)
					local c = 0
					repeat task.wait(0.3)
						c+=1
					until localPlayer.Backpack:FindFirstChild("Medkit") or localPlayer.Character:FindFirstChild("Medkit") or Fluent.Unloaded or not g.n7.heal or c>=5
					local tool = localPlayer.Backpack:FindFirstChild("Medkit") or localPlayer.Character:FindFirstChild("Medkit")
					tool.Parent = localPlayer.Character
					tool:Activate()
					tool.Parent = localPlayer.Backpack
				end
			end
			task.wait(0.1)
		end)
		task.wait(0.1)
	end
end)

if localPlayer.Character:FindFirstChild("HeadScript") then
	local freeze_head = player:AddToggle("frHead", { Title = "Freeze head", Description = "Stops sending head update event to server.\nDon't leave enabled when going afk. Adonis may kick you.", Default = g.n7.frhead })
	freeze_head:OnChanged(function(Value)
		g.n7.frhead = not Value
		localPlayer.Character:FindFirstChild("HeadScript").Enabled = g.n7.frhead
	end)
end

player:AddButton({Title="Get joy info", Description = "Useful for autofarm\nIf below 50, you need to kill character.", Callback = function()
	local likely = "could autofarm."
	if localPlayer.Character.Values.Joy.Value < 50 then
		likely = "couldn't autofarm."
	end
	Fluent:Notify({
        Title = "nick7 hub | Info",
        Content = `Joy: {localPlayer.Character.Values.Joy.Value}\nMost likely {likely}`,
        Duration = 5
    })
end})

--[[local avoid = player:AddToggle("Avoid", { Title = 'Avoid killing', Description = "Will avoid players with bats/grenades equipped.", Default = g.n7.avoid })
avoid:OnChanged(function(Value)
	g.n7.avoid = Value
	local markedPlayers = {}
	task.spawn(function()
		local function IsDangerous(player)
			if player.Character and (localPlayer.UserId ~= player.UserId) then
				if (player.Backpack:FindFirstChild("Bat") or player.Character:FindFirstChild("Bat")) or (player.Backpack:FindFirstChild("Grenade") or player.Character:FindFirstChild("Grenade")) then
					table.insert(markedPlayers, player)
				end
			end
		end
		for _, player in ipairs(Players:GetPlayers()) do -- loaded
			IsDangerous(player)
		end
		Players.PlayerAdded:Connect(function(player)
			IsDangerous(player)
		end)

		local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		
		local localRoot = character:WaitForChild("HumanoidRootPart")

		while g.n7.avoid and not Fluent.Unloaded do
			pcall(function()
				for _, player in ipairs(Players:GetPlayers()) do
					if not (table.find(markedPlayers, player) and player.Character) then
						continue
					end
					
					local markedRoot = player.Character:FindFirstChild("HumanoidRootPart")
					
					if not markedRoot then
						continue
					end
					
					local rootPosition = localRoot.Position
					
					if positionToCheck ~= nil then
						rootPosition = positionToCheck
					end
					
					if (rootPosition - markedRoot.Position).Magnitude <= 10 then
						
						hint_text(`DETECTED ({(rootPosition - markedRoot.Position).Magnitude} studs): {player.Name}`)
						
						if player.Character:FindFirstChild("Bat") or player.Character:FindFirstChild("Grenade") then
							if (rootPosition - CagePosition.Position).Magnitude > 10 then
								continue
							end
							
							if not cageModel then
								CageGen()
							end
							
							localRoot.CFrame = CagePosition
							
							inDanger = true
							
							repeat
								task.wait(0.3)
							until not (player.Character:FindFirstChild("Bat") or player.Character:FindFirstChild("Grenade"))
							
							inDanger = false
							
							localRoot.CFrame = rootPosition
						end
					else
						hint_text(`Closest marked ({(rootPosition - markedRoot.Position).Magnitude} studs): {player.Name}`)
					end
				end
			end)
			task.wait(0.5)
		end
	end)
end)]]


local UISection = Tabs.Settings:AddSection("Farm")

UISection:AddToggle("GarbageFarm", {
	Title = "Include garbage farm",
	Description = "When enabled, will farm garbage\nRequires 50+ joy.",
	Default = g.n7.garbagefarm,
	Callback = function(Value)
		g.n7.garbagefarm = Value
	end
})

if fireproximityprompt and USE_BETA_FEATURES then
	UISection:AddToggle("BurgerFarm", {
		Title = "Include burger farm",
		Description = "When enabled, will farm burgers using teleport\nWorks better with garbage farm enabled.\nRequires 50+ joy. Possibly drains joy",
		Default = g.n7.burgerfarm,
		Callback = function(Value)
			g.n7.burgerfarm = Value
		end
	})

	UISection:AddToggle("BurgerFarmCage", {
		Title = "(Burger farm) Teleport to cage when idle",
		Description = "When enabled, will teleport character to cage when no food boxes avaliable",
		Default = g.n7.burgerfarmcage,
		Callback = function(Value)
			g.n7.burgerfarmcage = Value
		end
	})

	UISection:AddInput("BurgerActMin", {
        Title = "(Burger) Minimum boxes to continue",
		--Description = "Will wait for value and then continue farming until 0 boxes count.",
		Description = "WIP",
        Placeholder = 0,
        Numeric = true,
        Finished = true,
        Callback = function(Value)
            g.n7.burger_minimum = tonumber(Value)
        end
    })
else
    UISection:AddParagraph({
        Title = "[INFO] Using stable version.",
        Content = 'If you want to use burger autofarm - go to source code and change "USE_BETA_FEATURES" to true.'
    })
end

local UISection = Tabs.Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift"})
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

Tabs.Credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script is made by Stonifam\nUsing forked Fluent UI lib by @ttwiz_z"
})
if setclipboard then
	Tabs.Credits:AddButton({
		Title = "Copy discord invite",
		Description = "nick7 community",
		Callback = function()
			setclipboard("https://discord.gg/6tgCfU2fX8")
		end
	})
else
	Tabs.Credits:AddButton({
		Title = "Notify discord invite",
		Description = "nick7 community",
		Callback = function()
			Fluent:Notify({
				Title = "https://discord.gg/6tgCfU2fX8",
				Content = "nick7 discord invite",
				Duration = 20
			})
		end
	})
end

Window:SelectTab(1)

Fluent:Notify({
	Title = "nick7 hub | Fluent",
	Content = "The script has been loaded.",
	Duration = 8
})

repeat task.wait(0.5) until Fluent.Unloaded
g.n7 = nil
--[[hint:Destroy()]]