local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

if game.PlaceId ~= 3411100258 then
	warn("Game is not supported!")
	player:Kick("(nick7 hub) Game is not supported!")
end

task.spawn(function()
	if getgenv then
		local msg = Instance.new("Hint", workspace)
		msg.Text = "Started loading nick7 hub, please wait.. // bordr gam"
		task.wait(5)
		msg:Destroy()
	else
		warn("getgenv is not supported!	")
		player:Kick("(nick7 hub) getgenv is not supported!")
	end
end)

local GC = getfenv().getconnections or get_signal_cons

if GC then
    --[[ removed, pointless until wiggles and his team (if he has) fights back.
	for _, Connection in next, GC(game:GetService("ScriptContext").Error) do
        Connection:Disable()
    end
	
    for _, Connection in next, GC(game:GetService("LogService").MessageOut) do
        Connection:Disable()
    end]]

    for i, v in pairs(GC(game.Players.LocalPlayer.Idled)) do
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

local g = getgenv()

g.n7 = {
	saveable = {
		potions = {
			multiplier = 1
		},
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
		},
		afterloading = {
			enabled = false,
			step1 = "peasant",
			step2 = true,
			step3 = "Fish autofarm"
		}
	},
	autofarm = false,
	fish = false,
	xpfarm = false,
    cage = CFrame.new(0,0,0),
}

function getAvatarUrl(user)
	local thumbnail_request = `https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds={user.UserId}&size=48x48&format=png`
	local response = request({
		Url = thumbnail_request,
		Method = "GET"
	})
	local b = response.Body
	return b:match('"https://tr.rbxcdn.com/.+["]'):gsub('"', "")
end
local local_pfp = getAvatarUrl(player)
function SendMessage(message)
	if not request then return end
	local url = g.n7.saveable.webhook.link
	if url ~= "" or url ~= " " then
		local http = HttpService
		local headers = {
			["Content-Type"] = "application/json"
		}
		local data = {
			["content"] = message,
			["username"] = player.Name,
			["avatar_url"] = local_pfp
		}
		local body = http:JSONEncode(data)
		request({
			Url = url,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	end
end

function SendWarn(admin, was)
	if not request then return end
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
	local url = g.n7.saveable.webhook.link
	if url ~= "" or url ~= " " then
		local http = HttpService
		local headers = {
			["Content-Type"] = "application/json"
		}
		local data = {
			content = `{g.n7.saveable.webhook.cfg.ping} Admin {_was} the server! Kicked \`{player.Name}\``,
			username = player.Name,
			avatar_url = local_pfp,
		}
		if needEmbed then
			data.embeds = {
				{
					title = "Admin that joined",
					description = string.format("Admins [profile](https://www.roblox.com/users/%d/profile)\nDisplay: %s\nUsername: %s", admin.UserId, admin.DisplayName, admin.Name),
					color = 16711680,
					thumbnail = { url = getAvatarUrl(admin) }
				}
			}
		end
		local body = http:JSONEncode(data)
		request({
			Url = url,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	end
end

pcall(function()
    if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
        g.n7.saveable = HttpService:JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
    end
end)
function cage():CFrame
	if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
	local folder = Instance.new("Folder", workspace)
	folder.Name = "Cage (nick7hub)"

	local color = Color3.fromRGB(79, 79, 79)
	local offset = Vector3.new(math.random(-100000, 10000), 6, math.random(-100000,10000))

	--+ Creating
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
		v.Color = color
		v.Name = "discord.gg/6tgCfU2fX8"
	end
	--+ Position
	floor.Position = Vector3.new(0, 0, 0) + offset
	wall1.Position = Vector3.new(5, 5, 0) + offset
	wall2.Position = Vector3.new(-5, 5, 0) + offset
	wall3.Position = Vector3.new(0, 5, -5) + offset
	wall4.Position = Vector3.new(0, 5, 5) + offset
	ceiling.Position = Vector3.new(0, 10, 0) + offset
	--+ Size
	floor.Size = Vector3.new(10,1,10)
	wall1.Size = Vector3.new(1, 10, 10)
	wall2.Size = Vector3.new(1, 10, 10)
	wall3.Size = Vector3.new(10, 10, 1)
	wall4.Size = Vector3.new(10, 10, 1)
	ceiling.Size = Vector3.new(10,1,10)
	--
	local frame = offset + Vector3.new(0,2,0)
	g.n7.cage = CFrame.new(frame)
	return CFrame.new(frame)
end

cage()

local funny_floor -- strange unusable name for funny & so I wouldn't use it on accident

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local platform = {
	['Init'] = function()
		local part = Instance.new("Part", workspace)
		part.Anchored = true
		part.Size = Vector3.new(10,1,10)
		part.Color = Color3.fromRGB(79, 79, 79)
		part.Transparency = 0.4
		part.Name = randomString()
		funny_floor = part
		return part
	end,
	['Forget'] = function()
		if funny_floor then
			funny_floor:Destroy()
		end
		funny_floor = nil
	end
}

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

Fluent.ShowCallbackErrors = true

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
	SubTitle = "bordr gam | by stonifam",
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
	local lists = {} -- 1: bricklandia, 2: farlands, 3: pirates
	for folderNumber,cargoFolder in {CargoInfo.BricklandiaCargoTrader, CargoInfo.FarlandsCargoTrader, CargoInfo.PirateCargoTrader} do
		if cargoFolder:FindFirstChild('Sell') then
			for _,sell in cargoFolder.Sell:GetChildren() do
				if sell:IsA('NumberValue') then
					lists[folderNumber] = {}
					table.insert(lists[folderNumber], sell)
				end
			end
		end
	end
	for num, list in lists do
		for _, cargo in list do
			if cargo and cargo.Value > most then
				most = cargo.Value
				str = cargo.Name
				island = num
			end
		end
	end

	return str, island
end

function getRoot(char)
	return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
end

Farm = Window:AddTab({Title = "Farming", Icon = "carrot"})

local status = Farm:AddParagraph({Title = "Autofarm status will be here", Content = ""})

local FarmToggle = Farm:AddToggle("FarmToggle", { Title = "Cargo autofarm", Description = "Toggles money autofarm using cargo", Default = false })
local FishFarmToggle = Farm:AddToggle("FishFarmToggle", { Title = "Fish autofarm", Description = "Toggles money autofarm using fishing", Default = false })
local XPFarmToggle = Farm:AddToggle("XPFarmToggle", { Title = "XP autofarm", Description = "Toggles XP autofarm. Farms dough\nWorks faster with worker potion", Default = false })

function FindTool(name)
	return player.Backpack:FindFirstChild(name) or player.Character:FindFirstChild(name)
end

function ToolsCountByName(name)
	local count = 0
	if FindTool(name) then
		for _,instance in pairs({player.Backpack, player.Character}) do
			for _,item in pairs(instance:GetChildren()) do
				if item:IsA("Tool") and item.Name == name then
					count += 1
				end
			end
		end
	end
	return count
end

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
	return `[ {bar} ] {string.format(" %d%%", percentage)}`
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

local function cap_check()
	if g.n7.saveable.webhook.use then
		if g.n7.saveable.webhook.cfg.on_cap then
			local coins = player.leaderstats.coins.Value
			if coins > cap then
				SendMessage(g.n7.saveable.webhook.cfg.ping.." Hitted a coin cap!")
				if g.n7.saveable.webhook.cfg.on_cap_kick then
					player:Kick("hitted coin cap.")
				end
			end
		end
	end
end

FarmToggle:OnChanged(function(Value)
	g.n7.autofarm = Value
	if g.n7.autofarm then
		if player.leaderstats.coins.Value >= 50 then
			if player.Team.Name ~= "choosing" then
				while g.n7.autofarm do
					if g.n7.fish then
						FarmToggle:SetValue(false)
						Fluent:Notify({
							Title = "nick7 hub | WARN",
							Content = "Disable fish autofarm to use cargo autofarm!",
							SubContent = "bordr autofarm",
							Duration = 5
						})
						return
					end
					cap_check()
					local exp, tp = get_exp()
					game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, true)
					for i=10,1,-1 do
						status:SetTitle("Waiting "..i.." seconds...")
						status:SetDesc("")
						task.wait(1)
						if not g.n7.autofarm then
							status:SetTitle("Finished farming!")
							status:SetDesc("")
							break
						end
					end
					if not g.n7.autofarm then
						break
					end
					local char = player.Character
					char:FindFirstChild("Humanoid").Sit = false
					local of = Vector3.new(0,0,0)
					local noise = math.random(-100,49)
					local fs = Vector3.new(noise,9500 + noise,noise)
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
							platform:Init().Position = of + Vector3.new(0,-2,0)
							getRoot(char).CFrame = CFrame.new(of)
							status:SetTitle("Teleported to selling point")
							status:SetDesc("")
							task.wait(.25)
							local bef = player.leaderstats.coins.Value
							game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer(exp, false, false)
							if g.n7.saveable.webhook.cfg.on_sale and g.n7.saveable.webhook.use then
								local aft_money = player.leaderstats.coins.Value
								SendMessage("[[!](<https://www.roblox.com/users/"..player.UserId..">)] Sold cargo for `"..aft_money-bef.."`. Total coins: `"..comma(aft_money).."` | Progress: "..bar())
							end
							status:SetTitle("Teleporting back")
							status:SetDesc("")
							task.wait(.01)
							getRoot(char).AssemblyLinearVelocity = Vector3.new(0,0,0)
							getRoot(char).AssemblyAngularVelocity = Vector3.new(0,0,0)
							getRoot(char).CFrame = g.n7.cage
							platform:Forget()
						end)
					else
						FarmToggle:SetValue(false)
						Fluent:Notify({
							Title = "nick7 hub | ERROR",
							Content = "Can't find character.",
							SubContent = "bordr autofarm",
							Duration = 5
						})
					end
				end
			else
				FarmToggle:SetValue(false)
				Fluent:Notify({
					Title = "nick7 hub | WARN",
					Content = "You can't farm as choosing!\nChoose a team first!",
					SubContent = "bordr autofarm",
					Duration = 5
				})
			end
		else
			FarmToggle:SetValue(false)
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
	g.n7.fish = Value
	if g.n7.fish then
		if not fireproximityprompt then
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "Your exploit doesn't support fireproximityprompt\nAutofarm will now just fish",
				SubContent = "bordr autofarm",
				Duration = 10
			})
		end
		local count = 0
		local count_cap = 10
		if not g.n7.autofarm then
			if player.Team.Name ~= "choosing" then
				if player.Backpack:FindFirstChild("fishing pol") or player.Character:FindFirstChild("fishing pol") then
					if player.Character and getRoot(player.Character) then
						getRoot(player.Character).CFrame = g.n7.cage
					end
					task.wait(1)
					while g.n7.fish do
						if fireproximityprompt then
							count = count + 1
							status:SetDesc(count.."/"..count_cap.." until sale")
						end
						if not player.Character:FindFirstChild("fishing pol") then
							player.Backpack:FindFirstChild("fishing pol").Parent = player.Character
						end
						task.wait()
						game:GetService("ReplicatedStorage").Packages.Knit.Services.FishingService.RF.Fire:InvokeServer(0)
						local bait
						if player.Character:FindFirstChild("fishing pol") then
							repeat task.wait() until player.Character:FindFirstChild("fishing pol").Bait.Value
							bait = player.Character:FindFirstChild("fishing pol").Bait.Value
						end
						for i=20,0,-1 do
							task.wait(0.1)
							status:SetTitle(`Waiting 2 seconds... ({i/10})`)
							if not g.n7.fish then status:SetTitle("Finished farming!");return end
						end
						status:SetTitle("Waiting until bait moves...")
						repeat task.wait() until bait.Position.Y ~= 5
						game:GetService("ReplicatedStorage").Packages.Knit.Services.FishingService.RF.Fire:InvokeServer(0)
						status:SetTitle("Caught fish")
						if count >= count_cap and fireproximityprompt then
							local bef = player.leaderstats.coins.Value
							status:SetTitle("Selling fish...")
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
								getRoot(player.Character).CFrame = g.n7.cage
								if g.n7.saveable.webhook.cfg.on_sale and g.n7.saveable.webhook.use then
									local aft_money = player.leaderstats.coins.Value
									SendMessage("[[!](<https://www.roblox.com/users/"..player.UserId.."/profile>)] Sold fish for `"..aft_money-bef.."`. Total coins: `"..comma(aft_money).."` | Progress: "..bar())
								end
								cap_check()
								task.wait(1)
							end
						end
					end
				else
					FishFarmToggle:SetValue(false)
					if player.leaderstats.coins.Value >= 150 then
						game:GetService("ReplicatedStorage").Packages.Knit.Services.ShopService.RF.Shop:InvokeServer("fishing pol", false, true)
						repeat task.wait() until player.Backpack:FindFirstChild("fishing pol") or player.Character:FindFirstChild("fishing pol")
						FishFarmToggle:SetValue(true)
					else
						Fluent:Notify({
							Title = "nick7 hub | WARN",
							Content = "Not enough coins! You need 150 coins",
							SubContent = "bordr autofarm",
							Duration = 5
						})
					end
				end
			else
				FishFarmToggle:SetValue(false)
				Fluent:Notify({
					Title = "nick7 hub | WARN",
					Content = "You can't farm as choosing!\nChoose a team first!",
					SubContent = "bordr autofarm",
					Duration = 5
				})
			end
		else
			FishFarmToggle:SetValue(false)
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "Disable cargo autofarm to use fish autofarm!",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
	end
end)

local stations = {} --Part with ProximityPrompt

function UpdateDoughStations()
	stations = {}
	for _,v in workspace:GetDescendants() do
		if v:IsA("ProximityPrompt") and v.Name == "Dough" and v.Parent.Parent.Name == "Dough Stand" then
			table.insert(stations, v.Parent)
		end
	end
end

UpdateDoughStations()

local TeamSpawns = {} --example: peasant:string = {SpawnLocation:SpawnLocation, SpawnLocation:SpawnLocation}...

function TS_INIT() -- TeamSpawns init, adds all game spawns to TeamSpawns table
    local spawners = {}

    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("SpawnLocation") then
            table.insert(spawners, object)
        end
    end

    for _, team: Team in ipairs(game:GetService("Teams"):GetTeams()) do
        if team.Name ~= "choosing" then
            local teamSpawns = {}
            for _, spawner: SpawnLocation in ipairs(spawners) do
                if spawner.TeamColor == team.TeamColor then
                    table.insert(teamSpawns, spawner)
                end
            end
            TeamSpawns[team.Name] = teamSpawns
        end
    end
end


XPFarmToggle:OnChanged(function(Value)
	g.n7.xpfarm = Value
	if g.n7.xpfarm then
		if player.Team ~= game.Teams:FindFirstChild("choosing") then
			TS_INIT()
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				xpcall(function()

					local function GetStation():Part --example: workspace.Map.Islands.Bricklandia['Dough Stand'].Part.Dough
						local Spawns = TeamSpawns[player.Team.Name]
						local closest = {math.huge, nil}
						for _,stand in ipairs(stations) do
							for _,Spawn in ipairs(Spawns) do
								if (Spawn.Position-stand.Position).Magnitude < closest[1] then
									closest = {(Spawn.Position-stand.Position).Magnitude, stand}
								end
							end
						end
						return closest[2]
					end
					status:SetDesc("")
					status:SetTitle("Getting station")
					local stand = GetStation()

					while g.n7.xpfarm and not Fluent.Unloaded do
						pcall(function()
							status:SetDesc("")
							status:SetTitle("Waiting for character")
							if player.Character then
								local localRoot = player.Character:WaitForChild("HumanoidRootPart")
								localRoot.CFrame = CFrame.new(stand.Position+Vector3.new(1,1,1))
								task.wait(0.2)
								status:SetTitle("Firing ProximityPrompt")
								status:SetDesc("Making dough")
								stand.Dough.HoldDuration = 0
								repeat
									fireproximityprompt(stand.Dough)
									if (localRoot.Position-stand.Position).Magnitude > 4 then
										localRoot.CFrame = CFrame.new(stand.Position+Vector3.new(1,1,1))
									end
									task.wait(0.3)
								until stand ~= GetStation() or Fluent.Unloaded or not player.Character or not g.n7.xpfarm
								status:SetTitle("Getting new station.")
								status:SetDesc("")
								stand = GetStation()
								task.wait()
							end
						end)
					end
				end, function(err)
					local fullTraceback = debug.traceback(err, 2)
					local firstLine = string.match(fullTraceback, ":%d+:")
					warn("Error: " .. err .. " at line " .. firstLine)
				end)

			end
		else
			Fluent:Notify({
				Title = "nick7 hub | WARN",
				Content = "You must choose a team first!",
				SubContent = "bordr autofarm",
				Duration = 5
			})
		end
		status:SetTitle("Autofarm status will be here")
		status:SetDesc("")
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
			local sign = workspace.Map.Islands["Choosing Island"].TeamChangers.Peasent.TeamPad
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

local recipe = { -- any names // format: COUNT#NAME,COUNT#NAME
	['full belly'] = function()
		return '1#catapillah,1#applee,1#bery'
	end,
	['worker'] = function()
		return '3#bone'
	end,
	['buffie'] = function()
		return '1#shinie_bar,1#catapillah,1#moony_rok'
	end,
	['disguise'] = function()
		return '1#pink_flowa,1#catapillah,1#moony_rok'
	end,
	['heal'] = function()
		return '1#pink_flowa,1#bone,1#applee'
	end,
	['jumppowah'] = function()
		return '1#moony_rok,1#pink_flowa,1#bery'
	end,
	['speed'] = function()
		return '1#moony_rok,1#shinie_bar,1#bone'
	end,
	['spoopy'] = function()
		return '1#bone,1#bery,1#ghost_bricc'
	end,
	['stamina'] = function()
		return '1#shinie_bar,1#pink_flowa,1#applee,1#catapillah'
	end,
	['regeneration'] = function()
		return '2#pink_flowa,1#applee'
	end
}

function Brew(potion)
	local function GetIngredient(ingredient:string):ClickDetector
		local bricklandia = workspace.Map.Islands.Bricklandia
		local farlands = workspace.Map.Islands.Farlands
		local known = {
			['bone'] = function()
				return bricklandia.bone.ClickDetector or farlands.bone.ClickDetector
			end,
			['applee'] = function()
				for _,island in {bricklandia, farlands} do
					if island:FindFirstChild('applee') then
						for _,v in island.applee:GetChildren() do
							if v:FindFirstChildOfClass("ClickDetector") then
								return v:FindFirstChildOfClass("ClickDetector")
							end
						end
					end
				end
			end,
			['catapillah'] = function()
				for _,island in {bricklandia, farlands} do
					if island:FindFirstChild('catapillah') then
						for _,v in island.catapillah:GetChildren() do
							if v:FindFirstChildOfClass("ClickDetector") then
								return v:FindFirstChildOfClass("ClickDetector")
							end
						end
					end
				end
			end,
			['bery'] = function()
				return bricklandia.bery.Part.ClickDetector or farlands.bery.Part.ClickDetector
			end,
			['shinie_bar'] = function()
				return bricklandia["shinie bar"].ClickDetector or farlands["shinie bar"].ClickDetector
			end,
			['moony_rok'] = function()
				return bricklandia["moony rok"].ClickDetector or farlands["moony rok"].ClickDetector
			end,
			['pink_flowa'] = function()
				return bricklandia["pink flowa"].ClickDetector or farlands["pink flowa"].ClickDetector
			end,
			['ghost_bricc'] = function()
				return bricklandia["ghost bricc"].ClickDetector or farlands["ghost bricc"].ClickDetector
			end
		}
		if known[ingredient] then
			return known[ingredient]()
		end
	end

	if recipe[potion] then
		if player.Character then
			local localRoot = player.Character:FindFirstChild('HumanoidRootPart')

			local lastPos = localRoot.CFrame

			local function ParseIngredients(input)
				local result = {}
			
				for part in string.gmatch(input, "([^,]+)") do
					local number, ingredient = string.match(part, "(%d+)#(.+)")
			
					if number and ingredient then
						number = tonumber(number)

						if result[ingredient] then
							table.insert(result[ingredient], number)
						else
							result[ingredient] = {number}
						end
					end
				end
				return result
			end

			local potion_todo = ParseIngredients(recipe[potion]())

			for ingredient, quantities in pairs(potion_todo) do
				for _, quantity in ipairs(quantities) do
					for _ = 0,quantity do
						local ingredient_spaced = string.gsub(ingredient, '_', ' ')
						repeat
							local clickDetector = GetIngredient(ingredient)
							if clickDetector then
								localRoot.CFrame = CFrame.new(clickDetector.Parent.Position+Vector3.new(0,2.5,0))
								fireclickdetector(clickDetector)
								task.wait()
							end
							game:GetService("RunService").RenderStepped:Wait()
						until ToolsCountByName(ingredient_spaced) >= quantity or Fluent.Unloaded
						task.wait()
					end
				end
			end
			local preBrewPotionCount = ToolsCountByName(`{potion} potin`)
		
			local function Convert(text:string)
				local words = {}

				for word in string.gmatch(text, "[^ ]+") do
					table.insert(words, (word:sub(1, 1):upper() .. word:sub(2):lower()))
				end

				local pascalString = table.concat(words)
				
				return pascalString
			end

			localRoot.CFrame = CFrame.new(workspace.Map.Islands.Bricklandia["Witch Hut"].Cauldron:FindFirstChild("Part").Position+Vector3.new(0,2,0))

			local beforeFiring = os.clock()

			repeat
				game:GetService("ReplicatedStorage").Remotes.BrewPotion:FireServer(Convert(potion))

				task.wait(0.1)

			until ToolsCountByName(`{potion} potin`) > preBrewPotionCount or Fluent.Unloaded or os.clock()>beforeFiring+30
			localRoot.CFrame = lastPos
		end
	end
end

if fireclickdetector then
	local potionNames = {}
	for potion,_ in pairs(recipe) do
		table.insert(potionNames, potion)
	end
	UISection:AddDropdown("Brewer", {
        Title = "Potion brewer",
        Description = "You can select multiple potions.",
        Values = potionNames,
        Multi = true,
        Default = {}
    })

	UISection:AddInput("PotionCount", {
        Title = "Potion count",
		Description = "Brews selected number of potions",
        Default = 1,
        Placeholder = 1,
        Numeric = true,
        Finished = true,
        Callback = function(Value)
            g.n7.saveable.potions.multiplier = tonumber(Value) or 1
        end
    })

	UISection:AddButton({Title = "Brew selected", Description = "Brews selected options in queue", Callback = function()
		local msgg = Instance.new('Hint', workspace)
		msgg.Text = 'Current queue: '..table.concat(Fluent.Options.Brewer.Value, ", ")
		for selected,_ in Fluent.Options.Brewer.Value do
			for i=1,g.n7.saveable.potions.multiplier or 1 do
				msgg.Text = `Brewing {selected} potion{g.n7.saveable.potions.multiplier>1 and ` ({i}/{g.n7.saveable.potions.multiplier})` or ''}.`
				Brew(selected)
				task.wait(0.1)
			end
			task.wait(0.1)
		end
		msgg:Destroy()
	end})
	
end

if request then
	Webhook = Window:AddTab({Title = "Webhook", Icon = "bell"})
	local UseWebhook = Webhook:AddToggle("UseWebhook", { Title = "Use webhook", Description = "Will message on selected event(-s)", Default = g.n7.saveable.webhook.use})
	UseWebhook:OnChanged(function(Value)
		g.n7.saveable.webhook.use = Value
	end)

	Webhook:AddInput("WebhookLink", {
		Title = "Webhook link",
		Description = "After typing, press Enter",
		Default = #g.n7.saveable.webhook.link > 0 and g.n7.saveable.webhook.link or "",
		Numeric = false,
		Finished = true,
		Placeholder = "https://discord.com/api/webhooks/*",
		Callback = function(Value)
			g.n7.saveable.webhook.link = Value
		end
	})

	Webhook:AddInput("WebhookPing", {
		Title = "Mention text",
		Description = "AKA ping",
		Default = g.n7.saveable.webhook.cfg.ping,
		Numeric = false,
		Finished = true,
		Placeholder = "@everyone",
		Callback = function(Value)
			g.n7.saveable.webhook.cfg.ping = Value
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

	UISection:AddToggle("EventAdmin", {
		Title = "Admin join/exists",
		Description = "Will message when admin is on the server",
		Default = g.n7.saveable.webhook.cfg.on_admin,
		Callback = function(Value)
			g.n7.saveable.webhook.cfg.on_admin = Value
		end
	})
	UISection:AddToggle("EventSale", {
		Title = "Sale",
		Description = "Will message when you sell cargo/fish (with autofarm)",
		Default = g.n7.saveable.webhook.cfg.on_sale,
		Callback = function(Value)
			g.n7.saveable.webhook.cfg.on_sale = Value
		end
	})
	UISection:AddToggle("EventCap", {
		Title = "Cap",
		Description = "Will message when autofarm hits money cap",
		Default = g.n7.saveable.webhook.cfg.on_cap,
		Callback = function(Value)
			g.n7.saveable.webhook.cfg.on_cap = Value
		end
	})
	UISection:AddToggle("EventCapKick", {
		Title = "(Cap) Kick after cap",
		Description = "Will kick you after autofarm hits money cap",
		Default = g.n7.saveable.webhook.cfg.on_cap_kick,
		Callback = function(Value)
			g.n7.saveable.webhook.cfg.on_cap_kick = Value
		end
	})
end

local Settings = Window:AddTab({ Title = "Settings", Icon = "cog"})
local UISection = Settings:AddSection("Farming")

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

local AdminCheck = UISection:AddToggle("AdminCheck", { Title = "Check for admins", Description = "Checks for admins while you play", Default = g.n7.saveable.check_admins})
AdminCheck:OnChanged(function(Value)
	g.n7.saveable.check_admins = Value
    task.spawn(function()
		task.wait(.1)
		local warned = false
		if g.n7.saveable.check_admins then
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
				if g.n7.saveable.webhook.use and request then
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
	if g.n7.saveable.check_admins then
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
			if g.n7.saveable.webhook.use and request then
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
				local ExportedConfiguration = HttpService:JSONEncode(g.n7.saveable)

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

local Optimization = Settings:AddSection("Optimization")

Optimization:AddToggle("3DRendering", {
	Title = "Toggle 3D rendering",
	Description = "Makes your screen white, excluding GUIs",
	Default = true,
	Callback = function(Value)
		RunService:Set3dRenderingEnabled(Value)
	end
})

if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
	local AfterLoading = Window:AddTab({ Title = "After loading", Icon = "refresh-ccw"})
	AfterLoading:AddParagraph({
		Title = "About | After loading",
		Content = "Script will execute the actions selected below after it was loaded again.\nDon't forget to export config to save changes!"
	})
	local al = AfterLoading:AddToggle("ToggleAfterLoading", {Title = "Toggle", Description = "Toggles after loading", Default = g.n7.saveable.afterloading.enabled or false})
	al:OnChanged(function(Value)
		g.n7.saveable.afterloading.enabled = Value
    end)
	local Step1 = AfterLoading:AddDropdown("Step1", {
        Title = "Step 1 | Team (neutrals)",
        Values = {"None", "peasant", "pirate"},
        Multi = false,
        Default = "peasant",
    })
    Step1:OnChanged(function(Value)
		if Value ~= nil then
			local function check_team(xteam)
				local team = string.lower(xteam)
				if team == "peasant" then return true end
				if team == "pirate" then return workspace.Map.Islands["Choosing Island"].TeamChangers.Pirate.TeamPad.Transparency == 0 end
			end
			if string.lower(Value) == "none" then
				g.n7.saveable.afterloading.step1 = Value
			else
				if check_team(Value) then
					g.n7.saveable.afterloading.step1 = Value
				end
			end
		end
    end)
	local xc = ""
	if not fireclickdetector then
		xc = " | UNSUPPORTED"
	end
	local Step2 = AfterLoading:AddToggle("Step2", { Title = "Step 2 | Full belly potion" .. xc, Description = "Brew full belly potion after team was chosen.\nIgnored if step 1 wasn't selected", Default = g.n7.saveable.afterloading.step2})
	Step2:OnChanged(function(Value)
		if Value ~= nil then
			g.n7.saveable.afterloading.step2 = Value
		end
	end)
	local Step3 = AfterLoading:AddDropdown("Step3", {
        Title = "Step 3 | Farm",
		Description = "Ignored if step 1 wasn't selected.",
        Values = {"None", "Cargo autofarm", "Fish autofarm", "XP autofarm"},
        Multi = false,
        Default = g.n7.saveable.afterloading.step3,
    })
    Step3:OnChanged(function(Value)
		if Value ~= nil then
			g.n7.saveable.afterloading.step3 = Value
		end
    end)
end

local credit_text = [[Main script is made by Stonifam with ttwiz_zs help
XP autofarm idea & how-to-make by @darktraja
Using forked Fluent UI lib by @ttwiz_z]]

Credits = Window:AddTab({Title = "Credits", Icon = "person-standing"})
Credits:AddParagraph({
	Title = "nick7 hub",
	Content = credit_text
})
Credits:AddButton({
	Title = "Copy discord invite",
	Description = "nick7 community",
	Callback = function()
		setclipboard("https://discord.gg/NGAaby4y4b")
	end
})

Window:SelectTab(1)
-- After loading part :P

if g.n7.saveable.afterloading.enabled then
	Fluent:Notify({
		Title = "nick7 hub | Welcome!",
		Content = "Afterloading is enabled, wait until it will finish.",
		SubContent = "bordr autofarm",
		Duration = 10
	})
	if g.n7.saveable.afterloading.step1 ~= "None" and g.n7.saveable.afterloading.step1 == "peasant" or g.n7.saveable.afterloading.step1 == "pirate" and player.Team.Name == "choosing" then
		local sign:Part
		if not player.Character and not player.Character:FindFirstChild("Humanoid") then
			repeat task.wait(0.2) until player.Character and player.Character:FindFirstChild("Humanoid")
		end
		if g.n7.saveable.afterloading.step1 == "peasant" then
			sign = workspace.Map.Islands["Choosing Island"].TeamChangers.Peasent.TeamPad
		elseif g.n7.saveable.afterloading.step1 == "pirate" then
			sign = workspace.Map.Islands["Choosing Island"].TeamChangers.Pirate.TeamPad
		end
		if player.Team == game.Teams:FindFirstChild("choosing") then
			local char = player.Character
			local root = char:FindFirstChild("HumanoidRootPart")
			if char and char:FindFirstChild("Humanoid") then
				local path = PathfindingService:CreatePath()
				path:ComputeAsync(root.Position, sign.Position)
				local waypoints = path:GetWaypoints()
				for _,v in waypoints do
					char:FindFirstChild("Humanoid"):MoveTo(v.Position)
					char:FindFirstChild("Humanoid").MoveToFinished:Wait(.2)
				end
			end
		end
		task.wait(3)
		if g.n7.saveable.afterloading.step2 and fireclickdetector then
			if player.Character then
				Brew('full belly')
				
				local potion = FindTool("full belly potin")
				potion.Parent = player.Character
				potion:Activate()
				potion.Parent = player.Backpack
			end
		end
		if g.n7.saveable.afterloading.step3 ~= "None" then
			if g.n7.saveable.afterloading.step3 == "Cargo autofarm" then
				FarmToggle:SetValue(true)
			elseif g.n7.saveable.afterloading.step3 == "Fish autofarm" then
				FishFarmToggle:SetValue(true)
			elseif g.n7.saveable.afterloading.step3 == "XP autofarm" then
				Brew('worker')

				local potion = FindTool("worker potin")
				potion.Parent = player.Character
				potion:Activate()
				
				task.wait(0.2)

				XPFarmToggle:SetValue(true)
			end
		end
	end
end