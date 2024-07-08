if game.PlaceId ~= 3411100258 then
	warn("Game is not supported!")
	wait(604800)
end


local GuiService = game:GetService("GuiService")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

do -- protection in case if wiggles is smarter than a rock
	if getfenv().getconnections then
		for _, Connection in next, getfenv().getconnections(game:GetService("ScriptContext").Error) do
			Connection:Disable()
		end
		for _, Connection in next, getfenv().getconnections(game:GetService("LogService").MessageOut) do
			Connection:Disable()
		end
	end
end

local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	game.Players.LocalPlayer.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

--

getgenv().n7 = {
	saveable = {
		use_cage = true,
		check_admins = true,
		webhook = {
			use = false,
			link = "",
			cfg = {
				ping = "@everyone",
				on_admin = true,
				on_sale = false,
				on_cap = false,
				on_cap_kick = false
			}
		}
	},
	autofarm = false,
	fish = false,
    cage = CFrame.new(0,0,0),
}
function getAvatarUrl(user)
	local thumbnail_request = string.format("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds=%d&size=48x48&format=png", user.UserId)
	local response = request({
		Url = thumbnail_request,
		Method = "GET"
	})
	local b = response.Body
	return b:match('"https://tr.rbxcdn.com/.+["]'):gsub('"', "")
end
local local_pfp = getAvatarUrl(player)
function SendMessage(message)
	local url = getgenv().n7.saveable.webhook.link
	if url ~= "" or url ~= " " then
		local http = game:GetService("HttpService")
		local headers = {
			["Content-Type"] = "application/json"
		}
		local data = {
			["content"] = message,
			["username"] = player.Name,
			["avatar_url"] = local_pfp
		}
		local body = http:JSONEncode(data)
		local response = request({
			Url = url,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	end
end

function SendWarn(admin, was)
	local needEmbed = false
	if admin ~= nil and admin ~= false then
		needEmbed = true
	end
	local _was = "is on"
	if was then
		_was = "**is on**"
	elseif not was then
		_was = "**joined**"
	end
	local url = getgenv().n7.saveable.webhook.link
	if url ~= "" or url ~= " " then
		local http = game:GetService("HttpService")
		local headers = {
			["Content-Type"] = "application/json"
		}
		local data = {
			["content"] = getgenv().n7.saveable.webhook.cfg.ping.." Admin ".._was.." the server! Kicked `"..player.Name.."`.",
			["username"] = player.Name,
			["avatar_url"] = local_pfp
		}
		if needEmbed then
			data = {
				["content"] = getgenv().n7.saveable.webhook.cfg.ping.." Admin ".._was.." the server! Kicked `"..player.Name.."`.",
				["username"] = player.Name,
				["avatar_url"] = local_pfp,
				["embeds"] = {
					{
						["title"] = "Admin that joined",
						["description"] = "Admins [profile](https://www.roblox.com/users/"..admin.UserId.."/profile)\nDisplay: "..admin.DisplayName.."\nUsername: "..admin.Name,
						["color"] = 16711680,
						["thumbnail"] = {
						["url"] = getAvatarUrl(admin)
						}
					}
				}
			}
		end
		local body = http:JSONEncode(data)
		local response = request({
			Url = url,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	end
end

pcall(function()
    if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
        getgenv().n7.saveable = HttpService:JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
    end
end)
function cage()
	if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
	local folder = Instance.new("Folder", workspace)
	folder.Name = "Cage (nick7hub)"
	local _color = Color3.fromRGB(79, 79, 79)
	local _offset = Vector3.new(math.random(-100000, 10000), 6, math.random(-100000,10000))
	--+ Creating
	local parts = {}
	local floor = Instance.new("Part", folder)
	local wall1 = Instance.new("Part", folder)
	local wall2 = Instance.new("Part", folder)
	local wall3 = Instance.new("Part", folder)
	local wall4 = Instance.new("Part", folder)
	local ceiling = Instance.new("Part", folder)
	local parts = {floor,wall1,wall2,wall3,wall4,ceiling}
	--+ sum things
	for _,v in pairs(parts) do
		v.Anchored = true
		v.Transparency = 0.4
		v.Color = _color
		v.Name = "discord.gg/6tgCfU2fX8"
	end
	--+ Position
	floor.Position = Vector3.new(0, 0, 0) + _offset
	wall1.Position = Vector3.new(5, 5, 0) + _offset
	wall2.Position = Vector3.new(-5, 5, 0) + _offset
	wall3.Position = Vector3.new(0, 5, -5) + _offset
	wall4.Position = Vector3.new(0, 5, 5) + _offset
	ceiling.Position = Vector3.new(0, 10, 0) + _offset
	--+ Size
	floor.Size = Vector3.new(10,1,10)
	wall1.Size = Vector3.new(1, 10, 10)
	wall2.Size = Vector3.new(1, 10, 10)
	wall3.Size = Vector3.new(10, 10, 1)
	wall4.Size = Vector3.new(10, 10, 1)
	ceiling.Size = Vector3.new(10,1,10)
	--
	local frame = _offset + Vector3.new(0,4,0)
	getgenv().n7.cage = CFrame.new(frame)
	return CFrame.new(frame)
end

cage()

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()
Fluent.ShowCallbackErrors = true

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
	SubTitle = "bordr | by stonifam",
	TabWidth = 100,
	Size = UDim2.fromOffset(470, 300),
	Acrylic = false,
	Theme = "Amethyst"
})

function get_exp()
	local most = 0
	local str = ""
	local CargoInfo = game.ReplicatedStorage.CargoInfo
	local island = 0
	local list_brick = {CargoInfo.BricklandiaCargoTrader.Sell.coal, CargoInfo.BricklandiaCargoTrader.Sell.fish, CargoInfo.BricklandiaCargoTrader.Sell.gold, CargoInfo.BricklandiaCargoTrader.Sell.gunpowder, CargoInfo.BricklandiaCargoTrader.Sell.lumber, CargoInfo.BricklandiaCargoTrader.Sell.potions}
	local list_far = {CargoInfo.FarlandsCargoTrader.Sell.chalices, CargoInfo.FarlandsCargoTrader.Sell.fish, CargoInfo.FarlandsCargoTrader.Sell.flowers, CargoInfo.FarlandsCargoTrader.Sell.gold, CargoInfo.FarlandsCargoTrader.Sell.gunpowder, CargoInfo.FarlandsCargoTrader.Sell.iron}
	local list_pirate = {CargoInfo.PirateCargoTrader.Sell.chalices, CargoInfo.PirateCargoTrader.Sell.coal, CargoInfo.PirateCargoTrader.Sell.flowers, CargoInfo.PirateCargoTrader.Sell.iron, CargoInfo.PirateCargoTrader.Sell.lumber, CargoInfo.PirateCargoTrader.Sell.potions}
	for i,v in pairs(list_brick) do
		if v then
			if v.Value > most then
				most = v.Value
				str = v.Name
				island = 1
			end
		end
	end
	for i,v in pairs(list_far) do
		if v.Value > most then
			most = v.Value
			str = v.Name
			island = 2
		end
	end
	for i,v in pairs(list_pirate) do
		if v.Value > most then
			most = v.Value
			str = v.Name
			island = 3
		end
	end
	return str, island
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

Farm = Window:AddTab({Title = "Farming", Icon = "carrot"})
local FarmToggle = Farm:AddToggle("FarmToggle", { Title = "Cargo autofarm", Description = "Toggles money autofarm using cargo", Default = false })
local FishFarmToggle = Farm:AddToggle("FishFarmToggle", { Title = "Fish autofarm (WIP)", Description = "Toggles money autofarm using fishing", Default = false })

local status = Farm:AddParagraph({
	Title = "Autofarm status will be here", Content = ""
})

local cap = 1000000
local gp_cap = player.Gamepasses:GetAttribute("CoinCap")
if gp_cap then
	cap = 2000000
end

local function bar()
	local coins = player.leaderstats.coins.Value
	local empty_tile = "░"
	local filled_tile = "█"
	local percentage = coins / cap * 100
	local bar = ""
	for i = 1, 7 do
		if percentage >= (i / 7) * 100 then
			bar = bar .. filled_tile
		else
			bar = bar .. empty_tile
		end
	end
	return "[ "..bar.." ] "..string.format(" %d%%", percentage)
end

local function comma(Value) -- stolen from KDanHudds (YT)
	local Number
	local Formatted = Value
	while true do
		Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (Number == 0) then
			break
		end
	end
	return Formatted
end

FarmToggle:OnChanged(function(Value)
	getgenv().n7.autofarm = Value
	if getgenv().n7.autofarm then
		if player.leaderstats.coins.Value >= 50 then
			if player.Team.Name ~= "choosing" then
				while getgenv().n7.autofarm do
					if getgenv().n7.saveable.webhook.cfg.on_cap then
						local coins = player.leaderstats.coins.Value
						if coins > cap then
							SendMessage(getgenv().n7.saveable.webhook.cfg.ping.." Hitted a coin cap!")
							if getgenv().n7.saveable.webhook.cfg.on_cap_kick then
								player:Kick("hitted coin cap.")
							end
						end
					end
					local exp, tp = get_exp()
					game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, true)
					for i=10,1,-1 do
						status:SetTitle("Waiting "..i.." seconds...")
						status:SetDesc("")
						task.wait(1)
						if not getgenv().n7.autofarm then
							status:SetTitle("Finished farming!")
							status:SetDesc("")
							break
						end
					end
					if not getgenv().n7.autofarm then
						break
					end
					local char = player.Character
					local pre = getRoot(char).CFrame
					char:FindFirstChild("Humanoid").Sit = false
					local of = Vector3.new(0,0,0)
					local noise = math.random(-50,30)
					local fs = Vector3.new(noise,10000 + noise,noise)
					if tp == 1 then
						of = workspace.Map.Islands.Bricklandia.BricklandiaCargoTrader.Sell.Position
					elseif tp == 2 then
						of = workspace.Map.Islands.Farlands.FarlandsCargoTrader.Sell.Position
					elseif tp == 3 then
						of = Vector3.new(-961, 10, -132)
					end
					of = of +fs
					if char and getRoot(char) then
						pcall(function()
							getRoot(char).CFrame = CFrame.new(of)
							status:SetTitle("Teleported to selling point")
							status:SetDesc("")
							task.wait(.25)
							local bef = player.leaderstats.coins.Value
							game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, false)
							if getgenv().n7.saveable.webhook.cfg.on_sale then
								local aft_money = player.leaderstats.coins.Value
								SendMessage("[[!](<https://www.roblox.com/users/"..player.UserId..">)] Sold for `"..aft_money-bef.."`. Total coins: `"..comma(aft_money).."` | Progress: "..bar())
							end
							status:SetTitle("Teleporting back")
							status:SetDesc("")
							task.wait(.01)
							getRoot(char).AssemblyLinearVelocity = Vector3.new(0,0,0)
							getRoot(char).AssemblyAngularVelocity = Vector3.new(0,0,0)
							if getgenv().n7.saveable.use_cage then
								getRoot(char).CFrame = getgenv().n7.cage
							else
								getRoot(char).CFrame = pre
							end
						end)
					else
						Fluent:Notify({
							Title = "nick7 hub | ERROR",
							Content = "Can't find character.",
							SubContent = "bordr autofarm",
							Duration = 5
						})
					end
				end
			else
				Fluent:Notify({
					Title = "nick7 hub | WARN",
					Content = "You can't farm as choosing!\nChoose a team first!",
					SubContent = "bordr autofarm",
					Duration = 5
				})
			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "Not enough coins! You need 50 coins",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
end)

FishFarmToggle:OnChanged(function(Value)
	local function getClosestObject(objects)
		local playerPosition = player.Character.HumanoidRootPart.Position
		local closestObject = nil
		local closestDistance = math.huge
		for _, object in pairs(objects) do
			local distance = (playerPosition - object.Position).Magnitude
			if distance < closestDistance then
				closestDistance = distance
				closestObject = object
			end
		end
		return closestObject, closestDistance
	end
	getgenv().n7.fish = Value
	if getgenv().n7.fish then
		local count = 0
		local count_cap = 10
		if not getgenv().n7.autofarm then
			if player.Team.Name ~= "choosing" then
				if player.Backpack:FindFirstChild("fishing pol") or player.Character:FindFirstChild("fishing pol") then
					if player.Character and getRoot(player.Character) then
						getRoot(player.Character).CFrame = getgenv().n7.cage
					end
					task.wait(1)
					while getgenv().n7.fish do
						count = count + 1
						status:SetDesc(count.."/"..count_cap.." until sale")
						if not player.Character:FindFirstChild("fishing pol") then
							player.Backpack:FindFirstChild("fishing pol").Parent = player.Character
						end
						task.wait()
						game:GetService("ReplicatedStorage").Packages.Knit.Services.FishingService.RF.Fire:InvokeServer(0)
						local bait
						for i=20,0,-1 do
							task.wait(0.1)
							local baits = {}
							task.spawn(function()
								for _,v in workspace.Debris:GetChildren() do
									if v.Name == "Bait" and v:IsA("BasePart") then
										table.insert(baits, v)
									end
								end
							end)
							local obj, dist = getClosestObject(baits)
							if dist < 15 then
								bait = obj
							end
							status:SetTitle("Waiting 2 seconds... ("..i..")")
							if not getgenv().n7.fish then status:SetTitle("Finished farming!");continue end
						end
						status:SetTitle("Waiting...")
						repeat task.wait() until bait.Position.Y ~= 5
						game:GetService("ReplicatedStorage").Packages.Knit.Services.FishingService.RF.Fire:InvokeServer(0)
						status:SetTitle("Caught fish")
						if count >= count_cap then
							count = 0
							if player.Character and getRoot(player.Character) then
								local sellFish:ProximityPrompt
								getRoot(player.Character).CFrame = CFrame.new(-162.187378, 7.00013018, 261.008575, -0.995443881, 0.0953492895, -2.66988809e-06, 2.97220822e-06, 5.90309028e-05, 1, 0.0953492895, 0.995443881, -5.90453492e-05)
								do
									for _,v in workspace.Map.Islands.Bricklandia.Fishmonger.BakerDummy:GetChildren() do
										if v:FindFirstChild("SellAllFish") then
											sellFish = v:FindFirstChild("SellAllFish")
										end
									end
									sellFish.HoldDuration = 0
								end
								for _=0,5 do
									fireproximityprompt(sellFish, 0.3)
									task.wait(0.3)
								end
								getRoot(player.Character).CFrame = getgenv().n7.cage
								task.wait(1)
							end
						end
					end
				else
					game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer("fishing pol", false, true)
					Fluent:Notify({
						Title = "nick7 hub | WARN",
						Content = "No fishing pol has been found, re-run autofarm if it was bought.",
						SubContent = "bordr autofarm",
						Duration = 5
					})
				end
			else
				Fluent:Notify({
					Title = "nick7 hub | WARN",
					Content = "You can't farm as choosing!\nChoose a team first!",
					SubContent = "bordr autofarm",
					Duration = 5
				})
			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "Disable cargo autofarm to use fishing autofarm!",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
end)

Farm:AddParagraph({
	Title = "WARNING | Cargo autofarm",
	Content = "Don't do anything crazy with: your position and your tools\nAutofarm will remove tool from your hands (not from inventory)\nAutofarm will teleport you"
})

local UISection = Farm:AddSection("Misc")

UISection:AddButton({
	Title = "Become a peasant",
	Description = "When you don't have control on movement",
	Callback = function()
		if player.Team == game.Teams:FindFirstChild("choosing") then
			local char = player.Character
			local root = char:FindFirstChild("HumanoidRootPart")
			local sign = game:GetService("Workspace").Map.Islands["Choosing Island"].TeamChangers.Peasent.TeamPad
			if char and char:FindFirstChild("Humanoid") then
				local path = PathfindingService:CreatePath()
				path:ComputeAsync(root.Position, sign.Position)
				local waypoints = path:GetWaypoints()
				for _,v in waypoints do
					char:FindFirstChild("Humanoid"):MoveTo(v.Position)
					char:FindFirstChild("Humanoid").MoveToFinished:Wait(.2)
				end
			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "For choosing team only!",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
})

UISection:AddButton({
	Title = "Brew full belly potion",
	Description = "Full belly potion will stop hunger from draining",
	Callback = function()
		if player.Team ~= game.Teams:FindFirstChild("choosing") then
			if not player.Backpack:FindFirstChild("full belly potin") then
				local char = player.Character
				local root = char:FindFirstChild("HumanoidRootPart")
				if char and root then
					local _last = root.CFrame
					if not (player.Backpack:FindFirstChild("catapillah") and player.Backpack:FindFirstChild("bery") and player.Backpack:FindFirstChild("applee")) then
						local crp = nil
						local arp = nil
						do
							for _,v in workspace.Map.Islands.Farlands.catapillah:GetChildren() do
								if v:FindFirstChild("ClickDetector") then
									crp = v
								end
							end
							for _,v in workspace.Map.Islands.Farlands.applee:GetChildren() do
								if v:FindFirstChild("ClickDetector") then
									arp = v
								end
							end
						end
						repeat
							root.CFrame = crp.CFrame
							fireclickdetector(crp.ClickDetector)
							task.wait()
						until player.Backpack:FindFirstChild("catapillah")
						task.wait(0.1)
						repeat
							root.CFrame = workspace.Map.Islands.Farlands.bery.Part.CFrame
							fireclickdetector(workspace.Map.Islands.Farlands.bery.Part.ClickDetector)
							task.wait()
						until player.Backpack:FindFirstChild("bery")
						task.wait(0.1)
						repeat
							root.CFrame = arp.CFrame
							fireclickdetector(arp.ClickDetector)
							task.wait()
						until player.Backpack:FindFirstChild("applee")
					end
					task.wait(0.1)
					root.CFrame = CFrame.new(-172, 12, 339)
					repeat
						game:GetService("ReplicatedStorage").Remotes.BrewPotion:FireServer("FullBelly")
						task.wait(0.1)
					until player.Backpack:FindFirstChild("full belly potin")
					root.CFrame = _last
				end
			else
				Fluent:Notify({
					Title = "nick7 hub | WARN",
					Content = "You already have full belly potion!",
					SubContent = "bordr autofarm",
					Duration = 5
				})
			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "You must choose a team first!",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
})
--[[
Quests = Window:AddTab({Title = "Quests (WIP)", Icon = "boxes"})
Quests:AddParagraph({ 
	Title = "WARNING!!!", Content = "Penguin quest uses blatant (instant) teleport, so just don't get caught."
})
Quests:AddParagraph({ --btw remove me later
	Title = "WARNING!!!", Content = "This tab is unfinished, not ready for release and only \"db1\" works."
})
local UISection = Quests:AddSection("Penguin")

UISection:AddButton({
	Title = "db1",
	Description = "coconut",
	Callback = function()
		local coco = workspace.SummerEvent:FindFirstChild("coconut")
		local prev = player.Character.HumanoidRootPart.CFrame
		if player.Character and getRoot(player.Character) then
			getRoot(player.Character).CFrame = coco.Handle.CFrame
			task.wait(0.3)
			fireclickdetector(coco.Handle.ClickDetector)
			player.Character.HumanoidRootPart.CFrame = prev
		end
	end
})

UISection:AddButton({
	Title = "db2",
	Description = "ice",
	Callback = function()
		local ice1 = workspace.Map.Iceberg:FindFirstChild("Iceburg")
		local ice:Part
		for _,v in pairs(ice1:GetChildren()) do
			if v:FindFirstChild("CollectIce") then
				ice = v
				break
			end
		end
		local prev = player.Character.HumanoidRootPart.CFrame
		if player.Character and player.Character:FindFirstChild("aHumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = ice.CFrame
			task.wait(0.3)
			fireproximityprompt(ice.CollectIce)
			player.Character.HumanoidRootPart.CFrame = prev
		end
	end
})

UISection:AddButton({
	Title = "Complete quest",
	Description = "Will fully complete the quest",
	Callback = function()
		
	end
})
]]

Webhook = Window:AddTab({Title = "Webhook", Icon = "bell"})

local UseWebhook = Webhook:AddToggle("UseWebhook", { Title = "Use webhook", Description = "Will message on selected event(-s)", Default = getgenv().n7.saveable.webhook.use})
UseWebhook:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.use = Value
end)

Webhook:AddInput("WebhookLink", {
    Title = "Webhook link",
    Description = "After typing, press Enter",
	Default = #getgenv().n7.saveable.webhook.link > 0 and getgenv().n7.saveable.webhook.link or "",
    Numeric = false,
    Finished = true,
    Placeholder = "https://discord.com/api/webhooks/*",
    Callback = function(Value)
        getgenv().n7.saveable.webhook.link = Value
    end
})

Webhook:AddInput("WebhookPing", {
    Title = "Mention text",
    Description = "AKA ping",
	Default = getgenv().n7.saveable.webhook.cfg.ping,
    Numeric = false,
    Finished = true,
    Placeholder = "@everyone",
    Callback = function(Value)
        getgenv().n7.saveable.webhook.cfg.ping = Value
    end
})

Webhook:AddButton({
	Title = "Test webhook",
	Description = "Will send a test message to your webhook",
	Callback = function()
		SendMessage("Message sent from `".. player.Name.."`.")
	end
})

local UISection = Webhook:AddSection("Events")

local EventAdmin = UISection:AddToggle("EventAdmin", { Title = "Admin join/exists", Description = "Will message when admin is on the server", Default = getgenv().n7.saveable.webhook.cfg.on_admin})
EventAdmin:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.cfg.on_admin = Value
end)

local EventSale = UISection:AddToggle("EventSale", { Title = "Sale", Description = "Will message when you sell cargo (with autofarm)", Default = getgenv().n7.saveable.webhook.cfg.on_sale})
EventSale:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.cfg.on_sale = Value
end)

local EventCap = UISection:AddToggle("EventCap", { Title = "Cap", Description = "Will message when autofarm hits money cap", Default = getgenv().n7.saveable.webhook.cfg.on_cap})
EventCap:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.cfg.on_cap = Value
end)

local EventCapKick = UISection:AddToggle("EventCapKick", { Title = "(Cap) Kick after cap", Description = "Will kick you after autofarm hits money cap", Default = getgenv().n7.saveable.webhook.cfg.on_cap_kick})
EventCapKick:OnChanged(function(Value)
	getgenv().n7.saveable.webhook.cfg.on_cap_kick = Value
end)

local Settings = Window:AddTab({ Title = "Settings", Icon = "cog"})
local UISection = Settings:AddSection("Farming")

local FarmToggle = Settings:AddToggle("CageToggle", { Title = "Use cage", Description = "Teleports you to cage after selling", Default = getgenv().n7.saveable.use_cage})
FarmToggle:OnChanged(function(Value)
    getgenv().n7.saveable.use_cage = Value
end)

UISection:AddButton({
	Title = "Rebuild cage",
	Description = "Will delete previous cage",
	Callback = function()
		cage()
	end
})

local function check_1(plr)
	local role = plr:GetRoleInGroup(5069767)
	local bad = {"Admin", "Trial Admin", "Head Admin"}
	for _,b in pairs(bad) do
		if string.match(role, b) then
			player:Kick("found admin. code: 1")
			return true
		end
	end
	return false
end
local function check_2(plr)
	local role = plr:GetRoleInGroup(11566845)
	local bad = {"Admin", "Head Admin", "Owner"}
	for _,b in pairs(bad) do
		if string.match(role, b) then
			player:Kick("found admin. code: 2")
			return true
		end
	end
	return false
end
local function check_3()
	if game.Teams:FindFirstChild("admin") then
		player:Kick("found admin. code: 3")
		return true
	end
	return false
end

local AdminCheck = UISection:AddToggle("AdminCheck", { Title = "Check for admins", Description = "Checks for admins while you play", Default = getgenv().n7.saveable.check_admins})
AdminCheck:OnChanged(function(Value)
	getgenv().n7.saveable.check_admins = Value
    task.spawn(function()
		task.wait(.1)
		local warned = false
		if getgenv().n7.saveable.check_admins then
			local plrs = game.Players:GetPlayers()
			local cb = false
			local code = false
			local admin
            for _,v in plrs do
				if cb then
					break
				end
                cb = check_1(v)
				if cb then
					admin = v
					code = true
				end
				if not cb then
					cb = check_2(v)
					if cb then
						admin = v
						code = true
					end
				end
            end
			if not cb then
				cb = check_3()
			end
			if cb then
				if getgenv().n7.saveable.webhook.use then
					if not warned then
						SendWarn(admin, code)
						warned = true
					end
				end
			end
		end
    end)
end)

game.Players.PlayerAdded:Connect(function(plr)
	if getgenv().n7.saveable.check_admins then
		local cb = false
		local admin = plr
		local code = false
		cb = check_1(plr)
		if not cb then
			cb = check_2(plr)
		end
		if not cb then
			cb = check_3()
		end
		if cb then
			if getgenv().n7.saveable.webhook.use then
				SendWarn(admin, code)
			end
		end
	end
	task.wait()
end)

local UISection = Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Description = "Changes the UI Theme",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

if Fluent.UseAcrylic then
	UISection:AddToggle("AcrylicToggle", {
		Title = "Acrylic",
		Description = "Blurred Background requires Graphic Quality >= 8",
		Default = Fluent.Acrylic,
		Callback = function(Value)
			if not Value then
				Fluent:ToggleAcrylic(Value)
			else
				Window:Dialog({
					Title = "Warning",
					Content = "This Option can be detected! Activate it anyway?",
					Buttons = {
						{
							Title = "Confirm",
							Callback = function()
								Fluent:ToggleAcrylic(Value)
							end
						},
						{
							Title = "Cancel",
							Callback = function()
								Fluent.Options.AcrylicToggle:SetValue(false)
							end
						}
					}
				})
			end
		end
	})
end

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift" })
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
	local ConfigurationManager = Settings:AddSection("Configuration Manager")

	ConfigurationManager:AddButton({
		Title = "Export Configuration",
		Description = "Overwrites the Game Configuration File",
		Callback = function()
			xpcall(function()
				local ExportedConfiguration = HttpService:JSONEncode(getgenv().n7.saveable)

				getfenv().writefile(string.format("%s.n7", game.GameId), ExportedConfiguration)
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully overwritten!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end, function()
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("An Error occurred when overwriting the Configuration File %s.n7", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end)
		end
	})

	ConfigurationManager:AddButton({
		Title = "Delete Configuration File",
		Description = "Deletes the Game Configuration File",
		Callback = function()
			if getfenv().isfile(string.format("%s.n7", game.GameId)) then
				getfenv().delfile(string.format("%s.n7", game.GameId))
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully deleted!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			else
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 could not be found!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end
		end
	})
end

local Optimisation = Settings:AddSection("Optimisation")

Optimisation:AddToggle("3DRendering", {
	Title = "Toggle 3D rendering",
	Description = "Makes your screen white, excluding GUIs",
	Default = true,
	Callback = function(Value)
		RunService:Set3dRenderingEnabled(Value)
	end
})


Credits = Window:AddTab({Title = "Credits", Icon = "person-standing"})
Credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script was made by Stonifam with ttwiz_zs help\nUsing forked Fluent UI lib by @ttwiz_z"
})
Credits:AddButton({
	Title = "Copy discord invite",
	Description = "nick7 community",
	Callback = function()
		setclipboard("https://discord.gg/6tgCfU2fX8")
	end
})

Window:SelectTab(1)