local RunService = game:GetService("RunService")
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

getgenv().n7tls = {
	vip = true,
	farmtab = {
		farm1 = false,
		farmw = "RareM4A1",
		farmxp = false
	},
	clubtab = {
		club = {
			name = "cool name",
			color = Color3.fromRGB(255,0,0),
			decal = "5205790785",
			description = "cool description"
		},
		invite = {
			player = nil,
			player_loop = false
		},
		clubevade = false,
		force = {
			player = nil,
			forceclub_username = "",
			forceclub_userid = 1,
			forceclub_loop = false
		}
	},
	trading = {
		target = nil,
		loop_all = false,
		loop_player = false,
	},
	weapons = {
		target = nil,
		loopkill_target = false,
		loopkill_server = false
	}
}

function match(s1, s2)
	local a1 = string.lower(s1)
	local a2 = string.lower(s2)
	if string.match(a1, a2) then
		return true
	end
end


local replicated = game:GetService("ReplicatedStorage")
local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local window = lib:MakeWindow({Name = "nick7 hub | ".. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, SaveConfig = false, IntroEnabled = false})
local main = window:MakeTab({Name = "Main & Misc", Icon = nil, PremiumOnly = false})
local weapons = window:MakeTab({Name = "Weapons", Icon = nil, PremiumOnly = false})
local club = window:MakeTab({Name = "Club", Icon = nil, PremiumOnly = false})
local trading = window:MakeTab({Name = "Trading", Icon = nil, PremiumOnly = false})
local cfg = window:MakeTab({Name = "Settings & Creds", Icon = nil, PremiumOnly = false})

function user(str)
	local PartialName = str
	local Players = game.Players:GetPlayers()
	local passed = false
	for i = 1, #Players do
		local CurrentPlayer = Players[i]
		if string.lower(CurrentPlayer.Name):sub(1, #PartialName) == string.lower(PartialName) then
			passed = true
			return CurrentPlayer
		end
	end
	lib:MakeNotification({Name = "nick7 hub | Warn", Content = "Can't find player!", Image = nil, Time = 5})
end
main:AddSection({Name = "World"})
main:AddButton({
	Name = "Unlock all zones",
	Callback = function()
		for i=1,10 do
			replicated.Events.Access.RequestBuyAccess:FireServer(i)
		end
	end
})
main:AddToggle({
	Name = "Unlock VIP",
	Default = true,
	Callback = function()
		getgenv().n7tls.vip = not getgenv().n7tls.vip
		for _,v in pairs(workspace.Camera.AccessWalls.VIP:GetChildren()) do
			if not getgenv().n7tls.vip then
				for _,a in pairs(workspace:GetChildren()) do
					if match(a.Name, "Safe") then
						if a:FindFirstChild("Door") then
							a.Door.Transparency = .5
							a.Door.CanCollide = false
							break
						end
					end
				end
				v.CanCollide = false
				if v.Name == "VIPONLY" then
					if v:FindFirstChild("SurfaceGui") then
						for _,j in pairs(v.SurfaceGui:GetChildren()) do
							if j:IsA("TextLabel") then
								if j.Text == "LOCKED" then
									j.Text = "nick7 hub :3"
								elseif j.Text == "VIP USERS" then
									j.Text = "for you (& VIP)"
								end
							elseif j:IsA("ImageLabel") then
								j.Image = 'rbxassetid://5205790785'
							end
						end
					end
				end
			else
				v.CanCollide = true
				if v.Name == "VIPONLY" then
					if v:FindFirstChild("SurfaceGui") then
						for _,j in pairs(v.SurfaceGui:GetChildren()) do
							if j:IsA("TextLabel") then
								if j.Text == "nick7 hub :3" then
									j.Text = "LOCKED"
								elseif j.Text == "for you (& VIP)" then
									j.Text = "VIP USERS"
								end
							elseif j:IsA("ImageLabel") then
								j.Image = 'rbxassetid://2701433023'
							end
						end
					end
				end
			end
		end
	end
})

main:AddSection({Name = "Farming"})

main:AddButton({
	Name = "Sell all",
	Callback = function()
		for i=1,70 do
			replicated.Events.Shop.RequestSellItem:FireServer(1)
		end
	end,
})
main:AddLabel("UNSAFE doesn't have delays (can crash you),\nSAFE has delays")
main:AddButton({
	Name = "[UNSAFE] Farm XP (~5 seconds)",
	Callback = function()
		for i=1,1000 do
			replicated.Events.Loot.RequestLoot:FireServer(500)
		end
	end,
})
main:AddToggle({
	Name = "[SAFE] Farm XP",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.farmtab.farmxp = Value
		while getgenv().n7tls.farmtab.farmxp do
			replicated.Events.Loot.RequestLoot:FireServer(500)
			RunService.RenderStepped:Wait()
		end
	end,
})
main:AddTextbox({
	Name = "Request loot (1-769)",
	Default = 502,
	TextDisappear = true,
	Callback = function(Value)
		replicated.Events.Loot.RequestLoot:FireServer(Value)
	end
})
main:AddToggle({
	Name = "Farm money",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.farmtab.farm1 = Value
		if getgenv().n7tls.farmtab.farm1 then
			for i=1,50 do
				replicated.Events.Shop.RequestSellItem:FireServer(1)
			end
		end
		while getgenv().n7tls.farmtab.farm1 do
			replicated.Events.GunShop.RequestBuy:FireServer(getgenv().n7tls.farmtab.farmw)
			replicated.Events.Shop.RequestShop:FireServer()
			replicated.Events.Shop.RequestSellItem:FireServer(1)
			RunService.RenderStepped:Wait()
		end
	end
})
main:AddDropdown({
	Name = "Farm with",
	Default = "RareM4A1",
	Options = {"VIPGlock17","VIPAK47","RareM4A1"},
	Callback = function(Value)
		getgenv().n7tls.farmtab.farmw = Value
	end    
})
main:AddSection({Name = "Equipment"})

main:AddButton({Name = "Buy best ($183,000)", Callback = function()
	replicated.Events.BackpackShop.RequestBuy:FireServer("Backpack9")
	replicated.Events.Toolshop.RequestBuy:FireServer("Plasmacutter","Tools")
	replicated.Events.Toolshop.RequestBuy:FireServer("Automaticpicklock", "Picklocks")
	replicated.Events.Toolshop.RequestBuy:FireServer("Hackingdevice", "Electricaltools")
	replicated.Events.Toolshop.RequestBuy:FireServer("Stethoscope", "Safetools")
	replicated.Events.PetShop.RequestBuy:FireServer("Bulldog")
	end
})

main:AddButton({
	Name = "Buy best armor ($515,000)",
	Callback = function()
		replicated.Events.ArmourShop.RequestBuy:FireServer("HeavyBodyArmour3")
	end
})

weapons:AddSection({Name = "Buying"})
weapons:AddDropdown({
	Name = "Buy weapon",
	Options = {"Glock17 ($500)", "1911 ($1,500)", "TEC9 ($8,000)", "Shotgun ($20,000)", "UZI ($35,000)", "AK47 ($70,000)", "M4 carbine ($95,000)", "Golden1911 ($100,000)", "Golden shotgun ($150,000)", "GoldenUZI ($200,000)", "Golden M4 ($500,000)", "VIPGlock17 ($100)","VIPTEC9 ($100)","VIPAK47 ($100)","RareUZI ($400,000)","RareM4A1 ($95,000)"},
	Callback = function(Value)
		local allowed = {"Glock17", "1911", "TEC9", "Shotgun", "UZI", "AK47", "M4A1", "Golden1911", "GoldenShotgun", "GoldenUZI", "GoldenM4A1", "VIPGlock17", "VIPTEC9", "VIPAK47", "RareUZI", "RareM4A1"}
		local output = ""
		for _,v in pairs(allowed) do
			if match(Value, v) then
				output = v
			end
		end
		replicated.Events.GunShop.RequestBuy:FireServer(output)
	end
})
weapons:AddSection({Name = "Killing - player"})

weapons:AddLabel("IMPORTANT NOTE: WEAPON MUST BE EQUIPPED!")

local wk_target = weapons:AddLabel("Target: no target :)")

weapons:AddTextbox({
	Name = "Username (not display name)",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.weapons.target = user(Value)
		wk_target:Set("Target: ".. getgenv().n7tls.weapons.target.Name.." | "..getgenv().n7tls.weapons.target.DisplayName)
	end,

})
weapons:AddButton({
	Name = "Kill player",
	Callback = function()
		local character = getgenv().n7tls.weapons.target.Character
		for i=1,13 do
			replicated.Events.Weapon.RequestHit:FireServer(character)
			RunService.RenderStepped:Wait()
		end
	end
})

weapons:AddToggle({
	Name = "Loop kill player",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.weapons.loopkill_target = Value
		while getgenv().n7tls.weapons.loopkill_target do
			replicated.Events.Weapon.RequestHit:FireServer(getgenv().n7tls.weapons.target.Character)
			RunService.RenderStepped:Wait()
		end
	end
})

weapons:AddSection({Name = "Killing - server"})

weapons:AddButton({
	Name = "Kill all",
	Callback = function()
		for _,v in game.Players:GetPlayers() do
			if v.Name ~= game.Players.LocalPlayer.Name then
				for i=1,13 do
					replicated.Events.Weapon.RequestHit:FireServer(v.Character)
				end
				RunService.RenderStepped:Wait()
			end
		end
		task.wait()
	end
})

weapons:AddToggle({
	Name = "Loop kill all",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.weapons.loopkill_server = Value
		while getgenv().n7tls.weapons.loopkill_server do
			for _,v in game.Players:GetPlayers() do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i=1,13 do
						if getgenv().n7tls.weapons.loopkill_server then
							replicated.Events.Weapon.RequestHit:FireServer(v.Character)
						else break
						end
					end
					RunService.RenderStepped:Wait()
				end
			end
		end
	end
})

club:AddSection({Name = "Club evading"})

club:AddButton({
	Name = "Leave",
	Callback = function()
		replicated.Events.Guild.LeaveGuild:FireServer()
	end
})

club:AddToggle({
	Name = "Auto leave",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.clubevade = Value
		while getgenv().n7tls.clubtab.clubevade do
			replicated.Events.Guild.LeaveGuild:FireServer()
			task.wait(.4)
		end
	end
})

club:AddSection({Name = "Club creation"})

club:AddLabel("Note: the club that was created is broken and it is temporary")

club:AddTextbox({
	Name = "Name of the club",
	Default = "cool name",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.club.name = Value
	end
})

club:AddColorpicker({
	Name = "Color",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(Value)
		getgenv().n7tls.clubtab.club.color = Value
	end	  
})

club:AddTextbox({
	Name = "Decal (w/o rbxassetid://)",
	Default = "5205790785",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.club.decal = "rbxassetid://"..tostring(Value)
	end
})

club:AddTextbox({
	Name = "Description",
	Default = "cool description",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.club.description = Value
	end
})

club:AddButton({
	Name = "Create club",
	Callback = function()
		replicated.Events.Guild.RequestGuildInfo:FireServer()
		replicated.Events.Guild.SendCreateGuild:FireServer(getgenv().n7tls.clubtab.club.name, getgenv().n7tls.clubtab.club.color, getgenv().n7tls.clubtab.club.decal, getgenv().n7tls.clubtab.club.description)
		lib:MakeNotification({Name = "nick7 hub | Success", Content = "Created club", Image = nil, Time = 5})
	end,
})

club:AddSection({Name = "Force member"})
club:AddLabel("*You MUST be president rank to force members")

local target_force = club:AddLabel("Target: no target :)")

club:AddTextbox({
	Name = "Username (not display name)",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.force.forceclub_username = user(Value).Name
		getgenv().n7tls.clubtab.force.forceclub_userid = user(Value).UserId
		getgenv().n7tls.clubtab.force.player = user(Value)
	end
})

club:AddButton({
	Name = "Force member",
	Callback = function()
		replicated.Events.Guild.SendInvite:FireServer(getgenv().n7tls.clubtab.force.player)
		replicated.Events.Guild.RequestChangeTitle:FireServer({["ID"] = getgenv().n7tls.clubtab.force.forceclub_userid, ["Name"] = getgenv().n7tls.clubtab.force.forceclub_username, ["Status"] = "Requests"}, "Member")
	end
})

club:AddButton({
	Name = "Force member all players (whole server)",
	Callback = function()
		for _, player in game.Players:GetPlayers() do
			if player.Name ~= game.Players.LocalPlayer.Name then
				replicated.Events.Guild.SendInvite:FireServer(player)
				replicated.Events.Guild.RequestChangeTitle:FireServer({["ID"] = player.UserId, ["Name"] = player.Name, ["Status"] = "Requests"}, "Member")
			end
		end
	end
})

club:AddToggle({
	Name = "Loop member server",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.clubtab.force.forceclub_loop = Value
		while getgenv().n7tls.clubtab.force.forceclub_loop do
			for _, player in game.Players:GetPlayers() do
				if player.Name ~= game.Players.LocalPlayer.Name then
					replicated.Events.Guild.SendInvite:FireServer(player)
					replicated.Events.Guild.RequestChangeTitle:FireServer({["ID"] = player.UserId, ["Name"] = player.Name, ["Status"] = "Requests"}, "Member")
				end
				task.wait()
			end
			task.wait()
		end
	end,
})

trading:AddSection({Name = "Force trade - player"})

local ft_target = trading:AddLabel("Target: no target :)")

trading:AddTextbox({
	Name = "Username (not display name)",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().n7tls.trading.target = user(Value)
		ft_target:Set("Target: ".. getgenv().n7tls.trading.target.Name.." | "..getgenv().n7tls.trading.target.DisplayName)
	end,
	
})

trading:AddButton({
	Name = "Force trade",
	Callback = function()
		replicated.Events.Trade.AcceptTrade:FireServer(getgenv().n7tls.trading.target.UserId)
	end
})

trading:AddToggle({
	Name = "Loop force trade target",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.trading.loop_player = Value
		while getgenv().n7tls.trading.loop_player do
			replicated.Events.Trade.AcceptTrade:FireServer(getgenv().n7tls.trading.target.UserId)
			task.wait()
		end
	end,
})

trading:AddSection({Name = "Force trade - server"})

trading:AddToggle({
	Name = "Loop force trade all",
	Default = false,
	Callback = function(Value)
		getgenv().n7tls.trading.loop_all = Value
		while getgenv().n7tls.trading.loop_all do
			for _,v in game.Players:GetPlayers() do
				replicated:WaitForChild("Events"):WaitForChild("Trade"):WaitForChild("AcceptTrade"):FireServer(v.UserId)
				task.wait()
			end
		end
	end,
})
cfg:AddSection({Name = "GUI"})
cfg:AddButton({
	Name = "Destroy",
	Callback = function()
		lib:Destroy()
	end    
})
cfg:AddSection({Name = "Credits"})
cfg:AddLabel("Script made by nick7 with <3")
cfg:AddLabel("Join nick7 community - discord.gg/6tgCfU2fX8")
cfg:AddLabel("Using Orion UI library for this script.")